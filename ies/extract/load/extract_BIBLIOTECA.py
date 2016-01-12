import sys, os, click, magic, codecs, re, time
from os.path import splitext, basename
import pandas, sqlalchemy

'''

USAGE EXAMPLE:
python ies/extract/load/extract_BIBLIOTECA.py ies/extract/data/IES_2009/BIBLIOTECA.txt

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

    # Discover encoding type of file
    blob = open(file_path).read()
    m = magic.Magic(mime_encoding=True)
    encoding = m.from_buffer(blob)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    columns = ['CO_UNIDADE_FUNCIONAMENTO', 'CO_BIBLIOTECA', 'CO_TIPO_BIBLIOTECA', 'IN_REDE_WIRELESS', 'IN_CATALOGO_ONLINE', 'QT_ASSENTO', 'QT_EMPRESTIMO_DOMICILIAR', 'QT_EMPRESTIMO_BIBLIOTECA', 'QT_COMUTACAO', 'QT_USUARIO_CAPACITADO', 'QT_ACERVO']

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

    write_data(table, tuples, columns)

    print "--- %s minutes ---" % str((time.time() - start)/60)

def write_data(table, tuples, columns):
    engine = sqlalchemy.create_engine('mysql://'+os.environ["DB_USER"]+":"+os.environ["DB_PW"]+'@'+os.environ["DB_HOST"]+'/'+os.environ["DB_RAW"])
    data_frame = pandas.DataFrame(tuples, columns=columns)
    data_frame.to_sql(table, engine, if_exists='replace', index=False, chunksize=100)

if __name__ == "__main__":
    main()