import sys, click, magic, codecs, time, itertools
from os.path import splitext, basename
from write_data import write_data

'''

USAGE EXAMPLE:
python ies/extract/load/extract_UNIDADE_FUNCIONAMENTO.py ies/extract/data/IES_2009/UNIDADE_FUNCIONAMENTO.txt

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
    columns = ['CO_UNIDADE_FUNCIONAMENTO', 'CO_TIPO_UNIDADE', 'IN_POLO_EXTERIOR', 'IN_POSSUI_NEAD', 'IN_POLO_COMPARTILHADO', 'IN_SUBTIPO_UNIDADE', 'CO_IES', 'CO_UNIDADE_IES', 'CO_MUNICIPIO', 'QT_SALA_AULA', 'IN_AC_RAMPAS', 'IN_AC_EQUIP_ELETROMECANICO', 'IN_AC_BANHEIRO_ADAPTADO', 'IN_AC_MOBILIARIO_ADAPTADO', 'IN_INST_NENHUMA', 'IN_INST_RESTAURANTE_UNIV [121-128]IN_INST_QUADRA', 'IN_INST_TEATRO', 'IN_INST_CINEMA', 'IN_INST_SERVICOS', 'IN_COND_ACESSIBILIDADE', 'IN_POSSUI_LABORATORIO', 'IN_POSSUI_BIBLIOTECA']
    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in itertools.islice(fp, 1000):
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
                line[80:88],
                line[88:96],
                line[96:104],
                line[104:112],
                line[112:120],
                line[120:136],
                line[136:144],
                line[144:152],
                line[152:160],
                line[160:168],
                line[168:176],
                line[176:184]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    write_data(table, tuples, columns, chuncksize)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()