import sys, click, magic, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_DOCENTE_2009.py ies/extract/data/IES_2009/DOCENTE.txt

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
    dtype = {'CO_IES' : String(8),'CO_CATEGORIA_ADMINISTRATIVA' : String(8),'DS_CATEGORIA_ADMINISTRATIVA' : String(50),'CO_ORGANIZACAO_ACADEMICA' : String(8),'NO_ORGANIZACAO_ACADEMICA' : String(100),'CO_MUNICIPIO_IES' : String(8),'NO_MUNICIPIO_IES' : String(150),'CO_UF' : String(8),'NO_REGIAO' : String(30),'CO_VINCULO_IES_DOCENTE' : String(8),'CO_DOCENTE' : String(8),'CO_SITUACAO_DOCENTE' : String(8),'CO_ESCOLARIDADE_DOCENTE' : String(8),'CO_REGIME_TRABALHO' : String(8),'IN_SEXO_DOCENTE' : Numeric(8),'NU_ANO_DOCENTE_NASC' : Numeric(8),'NU_MES_DOCENTE_NASC' : Numeric(8),'NU_DIA_DOCENTE_NASC' : Numeric(8),'NU_IDADE_DOCENTE' : Numeric(8),'CO_COR_RACA_DOCENTE' : String(8),'CO_PAIS_DOCENTE' : String(8),'CO_NACIONALIDADE_DOCENTE' : String(8),'NO_NACIONALIDADE_DOCENTE' : String(50),'IN_DOCENTE_DEFICIENCIA' : Numeric(8),'IN_CEGUEIRA' : Numeric(8),'IN_BAIXA_VISAO' : Numeric(8),'IN_SURDEZ' : Numeric(8),'IN_DEFICIENCIA_AUDITIVA' : Numeric(8),'IN_DEFICIENCIA_FISICA' : Numeric(8),'IN_SURDOCEGUEIRA' : Numeric(8),'IN_DEFICIENCIA_MULTIPLA' : Numeric(8),'IN_DEFICIENCIA_MENTAL' : Numeric(8),'IN_ATU_EAD' : Numeric(8),'IN_ATU_EXTENSAO' : Numeric(8),'IN_ATU_GESTAO' : Numeric(8),'IN_ATU_GRAD_PRESENCIAL' : Numeric(8),'IN_ATU_POS_EAD' : Numeric(8),'IN_ATU_POS_PRESENCIAL' : Numeric(8),'IN_ATU_SEQUENCIAL' : Numeric(8),'IN_BOLSA_PESQUISA' : Numeric(8),'IN_SUBSTITUTO' : Numeric(8)}
    columns = ['CO_IES', 'CO_CATEGORIA_ADMINISTRATIVA', 'DS_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'NO_ORGANIZACAO_ACADEMICA', 'CO_MUNICIPIO_IES', 'NO_MUNICIPIO_IES', 'CO_UF', 'NO_REGIAO', 'CO_VINCULO_IES_DOCENTE', 'CO_DOCENTE', 'CO_SITUACAO_DOCENTE', 'CO_ESCOLARIDADE_DOCENTE', 'CO_REGIME_TRABALHO', 'IN_SEXO_DOCENTE', 'NU_ANO_DOCENTE_NASC', 'NU_MES_DOCENTE_NASC', 'NU_DIA_DOCENTE_NASC', 'NU_IDADE_DOCENTE', 'CO_COR_RACA_DOCENTE', 'CO_PAIS_DOCENTE', 'CO_NACIONALIDADE_DOCENTE', 'NO_NACIONALIDADE_DOCENTE', 'IN_DOCENTE_DEFICIENCIA', 'IN_CEGUEIRA', 'IN_BAIXA_VISAO', 'IN_SURDEZ', 'IN_DEFICIENCIA_AUDITIVA', 'IN_DEFICIENCIA_FISICA', 'IN_SURDOCEGUEIRA', 'IN_DEFICIENCIA_MULTIPLA', 'IN_DEFICIENCIA_MENTAL', 'IN_ATU_EAD', 'IN_ATU_EXTENSAO', 'IN_ATU_GESTAO', 'IN_ATU_GRAD_PRESENCIAL', 'IN_ATU_POS_EAD', 'IN_ATU_POS_PRESENCIAL', 'IN_ATU_SEQUENCIAL', 'IN_BOLSA_PESQUISA', 'IN_SUBSTITUTO']

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

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()