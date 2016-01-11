import sys, os, click, MySQLdb, magic, codecs, re, time

'''

USAGE EXAMPLE:
python extract_BIBLIOTECA.py data/BIBLIOTECA.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    start = time.time()

    connection = MySQLdb.connect(host='10.85.16.51', user='root', passwd='dataviva', db='dataviva_raw')

    # Discover encoding type of file
    blob = open(file_path).read()
    m = magic.Magic(mime_encoding=True)
    encoding = m.from_buffer(blob)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    data_list = []

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            CO_UNIDADE_FUNCIONAMENTO = line[0:8]
            CO_BIBLIOTECA = line[8:16]
            CO_TIPO_BIBLIOTECA = line[16:24]
            IN_REDE_WIRELESS = line[24:32]
            IN_CATALOGO_ONLINE = line[32:40]
            QT_ASSENTO = line[40:48]
            QT_EMPRESTIMO_DOMICILIAR = line[48:56]
            QT_EMPRESTIMO_BIBLIOTECA = line[56:64]
            QT_COMUTACAO = line[64:72]
            QT_USUARIO_CAPACITADO = line[72:80]
            QT_ACERVO = line[80:88]

            tupla = (CO_UNIDADE_FUNCIONAMENTO, CO_BIBLIOTECA, CO_TIPO_BIBLIOTECA, IN_REDE_WIRELESS, IN_CATALOGO_ONLINE,
                     QT_ASSENTO, QT_EMPRESTIMO_DOMICILIAR, QT_EMPRESTIMO_BIBLIOTECA, QT_COMUTACAO, QT_USUARIO_CAPACITADO, QT_ACERVO)

            #Substitutes empty or spaces fields for None
            tupla = tuple([None if not str(x).strip() else x for x in tupla])

            data_list.append(tupla)

    cursor = connection.cursor()
    cursor.executemany('''
                   INSERT INTO BIBLIOTECA (CO_UNIDADE_FUNCIONAMENTO, CO_BIBLIOTECA, CO_TIPO_BIBLIOTECA, IN_REDE_WIRELESS, IN_CATALOGO_ONLINE,
                   QT_ASSENTO, QT_EMPRESTIMO_DOMICILIAR, QT_EMPRESTIMO_BIBLIOTECA, QT_COMUTACAO, QT_USUARIO_CAPACITADO, QT_ACERVO)
                   VALUES (%s)''' % ('%s, '*(len(tupla)-1)+'%s'), data_list)
    connection.commit()
    connection.close()

    print("--- %s minutes ---" % str((time.time() - start)/60))

if __name__ == "__main__":
    main()