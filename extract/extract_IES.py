import sys, os, click, MySQLdb, magic, codecs, re

'''

USAGE EXAMPLE:
python extract_IES.py data/IES.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):

    connection = MySQLdb.connect(host='localhost', user='root', passwd='', db='dataviva_raw')

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
            CO_IES = line[0:8]
            CO_MANTENEDORA = line[8:16]
            CO_CATEGORIA_ADMINISTRATIVA = line[16:24]
            DS_CATEGORIA_ADMINISTRATIVA = line[24:74]
            CO_ORGANIZACAO_ACADEMICA = line[74:82]
            NO_ORGANIZACAO_ACADEMICA = line[82:182]
            CO_MUNICIPIO_IES = line[182:190]
            NO_MUNICIPIO_IES = line[190:340]
            CO_UF = line[340:348]
            SGL_UF = line[348:350]
            NO_REGIAO = line[350:380]
            IN_CAPITAL = line[380:388]
            IN_ENTIDADE_BENEFICENTE = line[388:396]
            QT_TEC_TOTAL = line[396:404]
            QT_TEC_FUND_INCOMP_FEM = line[404:412]
            QT_TEC_FUND_INCOMP_MASC = line[412:420]
            QT_TEC_FUND_COMP_FEM = line[420:428]
            QT_TEC_FUND_COMP_MASC = line[428:436]
            QT_TEC_MEDIO_FEM = line[436:444]
            QT_TEC_MEDIO_MASC = line[444:452]
            QT_TEC_SUPERIOR_FEM = line[452:460]
            QT_TEC_SUPERIOR_MASC = line[460:468]
            QT_TEC_ESPECIALISTA_FEM = line[468:476]
            QT_TEC_ESPECIALISTA_MASC = line[476:484]
            QT_TEC_MESTRADO_FEM = line[484:492]
            QT_TEC_MESTRADO_MASC = line[492:500]
            QT_TEC_DOUTORADO_FEM = line[500:508]
            QT_TEC_DOUTORADO_MASC = line[508:516]
            
            tupla = (CO_IES, CO_MANTENEDORA, CO_CATEGORIA_ADMINISTRATIVA, DS_CATEGORIA_ADMINISTRATIVA, 
                     CO_ORGANIZACAO_ACADEMICA, NO_ORGANIZACAO_ACADEMICA, CO_MUNICIPIO_IES, NO_MUNICIPIO_IES, 
                     CO_UF, SGL_UF, NO_REGIAO, IN_CAPITAL, IN_ENTIDADE_BENEFICENTE, QT_TEC_TOTAL, 
                     QT_TEC_FUND_INCOMP_FEM, QT_TEC_FUND_INCOMP_MASC, QT_TEC_FUND_COMP_FEM, QT_TEC_FUND_COMP_MASC, 
                     QT_TEC_MEDIO_FEM, QT_TEC_MEDIO_MASC, QT_TEC_SUPERIOR_FEM, QT_TEC_SUPERIOR_MASC, 
                     QT_TEC_ESPECIALISTA_FEM, QT_TEC_ESPECIALISTA_MASC, QT_TEC_MESTRADO_FEM, QT_TEC_MESTRADO_MASC, 
                     QT_TEC_DOUTORADO_FEM, QT_TEC_DOUTORADO_MASC)

            #Substitutes empty or spaces fields for None
            tupla = tuple([None if not str(x).strip() else x for x in tupla])

            data_list.append(tupla)

    cursor = connection.cursor()
    cursor.executemany('''
                   INSERT INTO IES (CO_IES, CO_MANTENEDORA, CO_CATEGORIA_ADMINISTRATIVA,
                   DS_CATEGORIA_ADMINISTRATIVA, CO_ORGANIZACAO_ACADEMICA, NO_ORGANIZACAO_ACADEMICA,
                   CO_MUNICIPIO_IES, NO_MUNICIPIO_IES, CO_UF, SGL_UF, NO_REGIAO, IN_CAPITAL,
                   IN_ENTIDADE_BENEFICENTE, QT_TEC_TOTAL, QT_TEC_FUND_INCOMP_FEM, QT_TEC_FUND_INCOMP_MASC,
                   QT_TEC_FUND_COMP_FEM, QT_TEC_FUND_COMP_MASC, QT_TEC_MEDIO_FEM, QT_TEC_MEDIO_MASC,
                   QT_TEC_SUPERIOR_FEM, QT_TEC_SUPERIOR_MASC, QT_TEC_ESPECIALISTA_FEM, 
                   QT_TEC_ESPECIALISTA_MASC, QT_TEC_MESTRADO_FEM, QT_TEC_MESTRADO_MASC, 
                   QT_TEC_DOUTORADO_FEM, QT_TEC_DOUTORADO_MASC)
                   VALUES (%s)''' % ('%s, '*(len(tupla)-1)+'%s'), data_list)
    connection.commit()
    connection.close()

if __name__ == "__main__":
    main()