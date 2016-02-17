import os, sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_LOCAL_OFERTA_POLO_2011.py ies/extract/data/IES_2011/LOCAL_OFERTA_POLO.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[-2]
    table = folder+'_'+file_desc

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_LOCAL_OFERTA_IES':Numeric(8),'CO_IES':Numeric(8),'CO_MUNICIPIO':Numeric(8),'CO_UF':Numeric(8),'IN_SEDE':Numeric(8),'CO_CURSO_POLO':Numeric(8),'CO_CURSO':Numeric(8)}
    columns = ['CO_LOCAL_OFERTA_IES','CO_IES','CO_MUNICIPIO','CO_UF','IN_SEDE','CO_CURSO_POLO','CO_CURSO']

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
				line[0:8],
				line[8:16],
				line[16:24],
				line[24:32],
				line[32:40],
				line[40:48],
				line[48:55],
            	)

         tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()