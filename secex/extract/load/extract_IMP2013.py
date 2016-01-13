import os, sys, time, click, bz2, MySQLdb, magic, codecs, re
import pandas
from write_data import write_data

file_path = os.path.dirname(os.path.realpath(__file__))

''' USAGE EXAMPLE:
python extract_IMP2013.py data/IMP_2013_MUN.csv '''

@click.command()
@click.argument('input_file', type=click.Path(exists=True), required=True)

def main(input_file):
    
    # Discover encoding type of file
    with open(input_file, 'r') as fp:
        first_line = fp.readline()
    m = magic.Magic(mime_encoding=True)
    encode = m.from_buffer(first_line)

    data = pandas.read_csv(input_file, sep=',', dtype = {'CO_MES' : object, 'CO_NCM_POS': object, 'CO_PAIS': object, 'CO_UF': object, 'CO_PORTO': object, 'CO_MUN_GEO': object}, encoding = encode, nrows = 1000 )

    write_data('SECEX_2013_IMP', 100, data)

main()