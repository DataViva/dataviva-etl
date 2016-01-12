import sys, os, click, magic, codecs, re, time
from os.path import splitext, basename
import pandas, sqlalchemy

'''

USAGE EXAMPLE:
python ies/extract/load/extract_IES.py ies/extract/data/IES_2009/IES.txt

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
    columns = ['CO_IES', 'CO_MANTENEDORA', 'CO_CATEGORIA_ADMINISTRATIVA', 'DS_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'NO_ORGANIZACAO_ACADEMICA', 'CO_MUNICIPIO_IES', 'NO_MUNICIPIO_IES', 'CO_UF', 'SGL_UF', 'NO_REGIAO', 'IN_CAPITAL', 'IN_ENTIDADE_BENEFICENTE', 'QT_TEC_TOTAL', 'QT_TEC_FUND_INCOMP_FEM', 'QT_TEC_FUND_INCOMP_MASC', 'QT_TEC_FUND_COMP_FEM', 'QT_TEC_FUND_COMP_MASC', 'QT_TEC_MEDIO_FEM', 'QT_TEC_MEDIO_MASC', 'QT_TEC_SUPERIOR_FEM', 'QT_TEC_SUPERIOR_MASC', 'QT_TEC_ESPECIALISTA_FEM', 'QT_TEC_ESPECIALISTA_MASC', 'QT_TEC_MESTRADO_FEM', 'QT_TEC_MESTRADO_MASC', 'QT_TEC_DOUTORADO_FEM', 'QT_TEC_DOUTORADO_MASC']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:8],
                line[8:16],
                line[16:24],
                line[24:74],
                line[74:82],
                line[82:182],
                line[182:190],
                line[190:340],
                line[340:348],
                line[348:350],
                line[350:380],
                line[380:388],
                line[388:396],
                line[396:404],
                line[404:412],
                line[412:420],
                line[420:428],
                line[428:436],
                line[436:444],
                line[444:452],
                line[452:460],
                line[460:468],
                line[468:476],
                line[476:484],
                line[484:492],
                line[492:500],
                line[500:508],
                line[508:516]
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