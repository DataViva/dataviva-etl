import sys, click, codecs, time
from sqlalchemy.types import Numeric
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_BIBLIOTECA_2009.py ies/extract/data/IES_2009/BIBLIOTECA.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[-2]
    table = folder+'_'+file_desc

    start = time.time()

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_UNIDADE_FUNCIONAMENTO': Numeric(8),'CO_UNIDADE_FUNCIONAMENTO' : Numeric(8),'CO_BIBLIOTECA' : Numeric(8),'CO_TIPO_BIBLIOTECA' : Numeric(8),'IN_REDE_WIRELESS' : Numeric(8),'IN_CATALOGO_ONLINE' : Numeric(8),'QT_ASSENTO' : Numeric(8),'QT_EMPRESTIMO_DOMICILIAR' : Numeric(8),'QT_EMPRESTIMO_BIBLIOTECA' : Numeric(8),'QT_COMUTACAO' : Numeric(8),'QT_USUARIO_CAPACITADO' : Numeric(8),'QT_ACERVO' : Numeric(8)}
    columns = ['CO_UNIDADE_FUNCIONAMENTO','CO_UNIDADE_FUNCIONAMENTO','CO_BIBLIOTECA','CO_TIPO_BIBLIOTECA','IN_REDE_WIRELESS','IN_CATALOGO_ONLINE','QT_ASSENTO','QT_EMPRESTIMO_DOMICILIAR','QT_EMPRESTIMO_BIBLIOTECA','QT_COMUTACAO','QT_USUARIO_CAPACITADO']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:8],
                line[8:16],
                line[16:24],
                line[24:32],
                line[32:40],
                line[40:48],
                line[48:56],
                line[56:64],
                line[64:72],
                line[72:80],
                line[80:88]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()