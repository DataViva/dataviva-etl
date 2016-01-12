import sys, os, click, magic, codecs, re, time
from os.path import splitext, basename
import pandas, sqlalchemy

'''

USAGE EXAMPLE:
python ies/extract/load/extract_DOCENTE.py ies/extract/data/IES_2009/DOCENTE.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    file_name = basename(file_path)
    file_desc, file_ext = file_name.split('.')
    folder = file_path.split('/')[3]
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
    columns = ['CO_IES', 'CO_CATEGORIA_ADMINISTRATIVA', 'DS_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'NO_ORGANIZACAO_ACADEMICA', 'CO_MUNICIPIO_IES', 'NO_MUNICIPIO_IES', 'CO_UF_IES', 'NO_REGIAO_IES', 'CO_VINCULO_IES_DOCENTE', 'CO_DOCENTE', 'CO_SITUACAO_DOCENTE', 'CO_ESCOLARIDADE_DOCENTE', 'CO_REGIME_TRABALHO', 'IN_SEXO_DOCENTE', 'NU_ANO_DOCENTE_NASC', 'NU_MES_DOCENTE_NASC', 'NU_DIA_DOCENTE_NASC', 'NU_IDADE_DOCENTE', 'CO_COR_RACA_DOCENTE', 'CO_PAIS_DOCENTE', 'CO_NACIONALIDADE_DOCENTE', 'NO_NACIONALIDADE_DOCENTE', 'IN_DOCENTE_DEFICIENCIA', 'IN_CEGUEIRA', 'IN_BAIXA_VISAO', 'IN_SURDEZ', 'IN_DEFICIENCIA_AUDITIVA', 'IN_DEFICIENCIA_FISICA', 'IN_SURDOCEGUEIRA', 'IN_DEFICIENCIA_MULTIPLA', 'IN_DEFICIENCIA_MENTAL', 'IN_ATU_EAD', 'IN_ATU_EXTENSAO', 'IN_ATU_GESTAO', 'IN_ATU_GRAD_PRESENCIAL', 'IN_ATU_POS_EAD', 'IN_ATU_POS_PRESENCIAL', 'IN_ATU_SEQUENCIAL', 'IN_BOLSA_PESQUISA', 'IN_SUBSTITUTO']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:8],
                line[8:16],
                line[16:66],
                line[66:74],
                line[74:174],
                line[174:182],
                line[182:332],
                line[332:340],
                line[340:370],
                line[370:378],
                line[378:386],
                line[386:394],
                line[394:402],
                line[402:410],
                line[410:418],
                line[418:426],
                line[426:434],
                line[434:442],
                line[442:450],
                line[450:458],
                line[458:466],
                line[466:474],
                line[474:524],
                line[524:532],
                line[532:540],
                line[540:548],
                line[548:556],
                line[556:564],
                line[564:572],
                line[572:580],
                line[580:588],
                line[588:596],
                line[596:604],
                line[604:612],
                line[612:620],
                line[620:628],
                line[628:636],
                line[636:644],
                line[644:652],
                line[652:660],
                line[660:668]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    import pdb; pdb.set_trace()
    write_data(table, tuples, columns)

    print "--- %s minutes ---" % str((time.time() - start)/60)

def write_data(table, tuples, columns):
    engine = sqlalchemy.create_engine('mysql://'+os.environ["DB_USER"]+":"+os.environ["DB_PW"]+'@'+os.environ["DB_HOST"]+'/'+os.environ["DB_RAW"])
    data_frame = pandas.DataFrame(tuples, columns=columns)
    data_frame.to_sql(table, engine, if_exists='replace', index=False, chunksize=100)

if __name__ == "__main__":
    main()