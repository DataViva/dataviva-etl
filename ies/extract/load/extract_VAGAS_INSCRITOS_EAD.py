import sys, click, magic, codecs, time, itertools
from os.path import splitext, basename
from write_data import write_data

'''

USAGE EXAMPLE:
python ies/extract/load/extract_VAGAS_INSCRITOS_EAD.py ies/extract/data/IES_2009/VAGAS_INSCRITOS_EAD.txt

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

    # Discover encoding type of file reading fist line
    with open(file_path, 'r') as fp:
        first_line = fp.readline()
    m = magic.Magic(mime_encoding=True)

    encoding = m.from_buffer(first_line)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    columns = ['CO_IES', 'CO_CATEGORIA_ADMINISTRATIVA', 'DS_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'NO_ORGANIZACAO_ACADEMICA', 'CO_MUNICIPIO_IES', 'NO_MUNICIPIO_IES', 'SGL_UF_IES', 'CO_CURSO_EAD', 'NO_CURSO_EAD', 'CO_GRAU_ACADEMICO', 'CO_NIVEL_ACADEMICO', 'CO_OCDE', 'NU_VAGAS_OFERECIDAS_EAD', 'QT_INSCRITOS_ANO_EAD']
    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in itertools.islice(fp, 1000):
            row = (
                line[0:8],
                line[8:16],
                line[16:66],
                line[66:74],
                line[74:174],
                line[174:182],
                line[182:332],
                line[332:334],
                line[334:342],
                line[342:542],
                line[542:550],
                line[550:558],
                line[558:570],
                line[570:578],
                line[578:586]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    write_data(table, tuples, columns, chuncksize)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()