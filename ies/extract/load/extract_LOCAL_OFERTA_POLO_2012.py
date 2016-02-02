import os, sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_LOCAL_OFERTA_POLO_2012.py ies/extract/data/IES_2012/LOCAL_OFERTA_POLO.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[:2]
    table = folder+'_'+file_desc

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_LOCAL_OFERTA_IES':Numeric(8),'CO_IES':Numeric(8),'CO_MUNICIPIO_LOCAL_OFERTA':Numeric(8),'NO_MUNICIPIO_LOCAL_OFERTA':String(150),'CO_UF_LOCAL_OFERTA':Numeric(8),'SGL_UF_LOCAL_OFERTA':String(2),'IN_SEDE':Numeric(8),'CO_CURSO_POLO':Numeric(8),'CO_CURSO':Numeric(8),'IN_LOCAL_OFERTA_NEAD':Numeric(8),'IN_LOCAL_OFERTA_UAB':Numeric(8),'IN_LOCAL_OFERTA_REITORIA':Numeric(8),'IN_LOCAL_OFERTA_POLO':Numeric(8),'IN_LOCAL_OFERTA_UNID_ACADEMICA':Numeric(8)}
    columns = ['CO_LOCAL_OFERTA_IES','CO_IES','CO_MUNICIPIO_LOCAL_OFERTA','NO_MUNICIPIO_LOCAL_OFERTA','CO_UF_LOCAL_OFERTA','SGL_UF_LOCAL_OFERTA','IN_SEDE','CO_CURSO_POLO','CO_CURSO','IN_LOCAL_OFERTA_NEAD','IN_LOCAL_OFERTA_UAB','IN_LOCAL_OFERTA_REITORIA','IN_LOCAL_OFERTA_POLO','IN_LOCAL_OFERTA_UNID_ACADEMICA']

    #max_allowed_packet to mysql insert 16777216
    max_allowed_packet = 1000000

    #number of rows will be written in batches of this size at a time
    chuncksize = 10000

    #If table exists, insert data. Create if does not exist.
    if_exists = 'append'

    first_insertion = True

    start = time.time()

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
            line[1:8],
            line[9:16],
            line[17:24],
            line[25:174],
            line[175:182],
            line[183:184],
            line[185:192],
            line[193:200],
            line[201:208],
            line[209:216],
            line[217:224],
            line[225:232],
            line[233:240],
            line[241:248]
            	)

          tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()