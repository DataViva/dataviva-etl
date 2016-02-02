import sys, click, magic, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_DOCENTE_2010.py ies/extract/data/IES_2010/DOCENTE.txt

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
    dtype={'CO_IES':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'IN_CAPITAL':Numeric(8),'CO_DOCENTE_IES':Numeric(8),'CO_DOCENTE':Numeric(8),'CO_SITUACAO_DOCENTE':Numeric(8),'CO_ESCOLARIDADE_DOCENTE':Numeric(8),'DS_ESCOLARIDADE_DOCENTE':Numeric(8),'CO_REGIME_TRABALHO':Numeric(8),'DS_REGIME_TRABALHO':Numeric(8),'IN_SEXO_DOCENTE':Numeric(8),'DS_SEXO_DOCENTE':Numeric(8),'NU_ANO_DOCENTE_NASC':Numeric(8),'NU_MES_DOCENTE_NASC':Numeric(8),'NU_DIA_DOCENTE_NASC':Numeric(8),'NU_IDADE_DOCENTE':Numeric(8),'CO_COR_RACA_DOCENTE':Numeric(8),'DS_COR_RACA_DOCENTE':Numeric(8),'NO_MAE':String(100),'CO_PAIS_DOCENTE':Numeric(8),'CO_NACIONALIDADE_DOCENTE':String(100),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'IN_DOCENTE_DEFICIENCIA':Numeric(8),'IN_CEGUEIRA':Numeric(8),'IN_BAIXA_VISAO':Numeric(8),'IN_SURDEZ':Numeric(8),'IN_DEFICIENCIA_AUDITIVA':Numeric(8),'IN_DEFICIENCIA_FISICA':Numeric(8),'IN_SURDOCEGUEIRA':Numeric(8),'IN_DEFICIENCIA_MULTIPLA':Numeric(8),'IN_DEFICIENCIA_INTELECTUAL':Numeric(8),'IN_ATU_EAD':Numeric(8),'IN_ATU_EXTENSAO':Numeric(8),'IN_ATU_GESTAO':Numeric(8),'IN_ATU_GRAD_PRESENCIAL':Numeric(8),'IN_ATU_POS_EAD':Numeric(8),'IN_ATU_POS_PRESENCIAL':Numeric(8),'IN_ATU_SEQUENCIAL':Numeric(8),'IN_ATU_PESQUISA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'IN_SUBSTITUTO':Numeric(8),'IN_EXERCICIO_DT_REF':Numeric(8),'IN_VISITANTE':Numeric(8),'IN_VISITANTE_IFES_VINCULO':Numeric(8),'DT_CADASTRO':Numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','IN_CAPITAL','CO_DOCENTE_IES','CO_DOCENTE','CO_SITUACAO_DOCENTE','CO_ESCOLARIDADE_DOCENTE','DS_ESCOLARIDADE_DOCENTE','CO_REGIME_TRABALHO','DS_REGIME_TRABALHO','IN_SEXO_DOCENTE','DS_SEXO_DOCENTE','NU_ANO_DOCENTE_NASC','NU_MES_DOCENTE_NASC','NU_DIA_DOCENTE_NASC','NU_IDADE_DOCENTE','CO_COR_RACA_DOCENTE','DS_COR_RACA_DOCENTE','NO_MAE','CO_PAIS_DOCENTE','CO_NACIONALIDADE_DOCENTE','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','IN_DOCENTE_DEFICIENCIA','IN_CEGUEIRA','IN_BAIXA_VISAO','IN_SURDEZ','IN_DEFICIENCIA_AUDITIVA','IN_DEFICIENCIA_FISICA','IN_SURDOCEGUEIRA','IN_DEFICIENCIA_MULTIPLA','IN_DEFICIENCIA_INTELECTUAL','IN_ATU_EAD','IN_ATU_EXTENSAO','IN_ATU_GESTAO','IN_ATU_GRAD_PRESENCIAL','IN_ATU_POS_EAD','IN_ATU_POS_PRESENCIAL','IN_ATU_SEQUENCIAL','IN_ATU_PESQUISA','IN_BOLSA_PESQUISA','IN_SUBSTITUTO','IN_EXERCICIO_DT_REF','IN_VISITANTE','IN_VISITANTE_IFES_VINCULO','DT_CADASTRO']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:8],
                line[8:16],
                line[16:116],
                line[116:124],
                line[124:224],
                line[224:232],
                line[232:240],
                line[240:254],
                line[254:262],
                line[262:270],
                line[270:284],
                line[284:292],
                line[292:330],
                line[330:338],
                line[338:347],
                line[347:351],
                line[351:353],
                line[353:355],
                line[355:363],
                line[363:371],
                line[371:395],
                line[395:403],
                line[403:411],
                line[411:419],
                line[419:427],
                line[427:435],
                line[435:443],
                line[443:451],
                line[451:459],
                line[459:467],
                line[467:475],
                line[475:483],
                line[483:491],
                line[491:499],
                line[499:507],
                line[507:515],
                line[515:523],
                line[523:531],
                line[531:539],
                line[539:547],
                line[547:555],
                line[555:563],
                line[563:571],
                line[571:579],
                line[579:587],
                line[587:595],
                line[595:603],
                line[603:613],
                line[613:621]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()