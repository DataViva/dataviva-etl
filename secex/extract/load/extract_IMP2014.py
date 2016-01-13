import os, sys, time, click, bz2, MySQLdb, magic, codecs, re
import pandas
from write_data import write_data

file_path = os.path.dirname(os.path.realpath(__file__))

''' USAGE EXAMPLE:
python extract_IMP2014.py data/IMP_2014_MUN.csv '''

@click.command()
@click.argument('input_file', type=click.Path(exists=True), required=True)

def main(input_file):
    
    # Discover encoding type of file
    blob = open(input_file).read()
    m = magic.Magic(mime_encoding=True)
    encode = m.from_buffer(blob)

    header = ['CO_ANO', 'CO_MES', 'CO_SH4', 'CO_PAIS', 'CO_UF', 'CO_PORTO', 'CO_MUN_GEO', 'KG_LIQUIDO', 'VL_FOB']
    data = pandas.read_csv(input_file, sep=';',names = header, dtype = {'CO_MES' : object, 'CO_SH4': object, 'CO_PAIS': object,
    'CO_UF': object,
    'CO_PORTO': object,
    'CO_MUN_GEO': object}, encoding = encode )

    write_data('SECEX_2014_IMP', 100, data)


    #import pdb; pdb.set_trace()

main()