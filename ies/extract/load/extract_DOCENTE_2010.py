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
                line[folder = file_path.split('/')[:2]],
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
    dtype={'CO_IES'numeric(8):,'CO_CATEGORIA_ADMINISTRATIVA':numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'IN_CAPITAL':numeric(8),'CO_DOCENTE_IES':numeric(8),'CO_DOCENTE':numeric(8),'CO_SITUACAO_DOCENTE':numeric(8),'CO_ESCOLARIDADE_DOCENTE':numeric(8),'DS_ESCOLARIDADE_DOCENTE':numeric(8),'CO_REGIME_TRABALHO':numeric(8),'DS_REGIME_TRABALHO':numeric(8),'IN_SEXO_DOCENTE':numeric(8),'DS_SEXO_DOCENTE':numeric(8),'NU_ANO_DOCENTE_NASC':numeric(8),'NU_MES_DOCENTE_NASC':numeric(8),'NU_DIA_DOCENTE_NASC':numeric(8),'NU_IDADE_DOCENTE':numeric(8),'CO_COR_RACA_DOCENTE':numeric(8),'DS_COR_RACA_DOCENTE':numeric(8),'NO_MAE':String(100),'CO_PAIS_DOCENTE':numeric(8),'CO_NACIONALIDADE_DOCENTE':String(100),'CO_UF_NASCIMENTO':numeric(8),'CO_MUNICIPIO_NASCIMENTO':numeric(8),'IN_DOCENTE_DEFICIENCIA':numeric(8),'IN_CEGUEIRA':numeric(8),'IN_BAIXA_VISAO':numeric(8),'IN_SURDEZ':numeric(8),'IN_DEFICIENCIA_AUDITIVA':numeric(8),'IN_DEFICIENCIA_FISICA':numeric(8),'IN_SURDOCEGUEIRA':numeric(8),'IN_DEFICIENCIA_MULTIPLA':numeric(8),'IN_DEFICIENCIA_INTELECTUAL':numeric(8),'IN_ATU_EAD':numeric(8),'IN_ATU_EXTENSAO':numeric(8),'IN_ATU_GESTAO':numeric(8),'IN_ATU_GRAD_PRESENCIAL':numeric(8),'IN_ATU_POS_EAD':numeric(8),'IN_ATU_POS_PRESENCIAL':numeric(8),'IN_ATU_SEQUENCIAL':numeric(8),'IN_ATU_PESQUISA':numeric(8),'IN_BOLSA_PESQUISA':numeric(8),'IN_SUBSTITUTO':numeric(8),'IN_EXERCICIO_DT_REF':numeric(8),'IN_VISITANTE':numeric(8),'IN_VISITANTE_IFES_VINCULO':numeric(8),'DT_CADASTRO':numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','IN_CAPITAL','CO_DOCENTE_IES','CO_DOCENTE','CO_SITUACAO_DOCENTE','CO_ESCOLARIDADE_DOCENTE','DS_ESCOLARIDADE_DOCENTE','CO_REGIME_TRABALHO','DS_REGIME_TRABALHO','IN_SEXO_DOCENTE','DS_SEXO_DOCENTE','NU_ANO_DOCENTE_NASC','NU_MES_DOCENTE_NASC','NU_DIA_DOCENTE_NASC','NU_IDADE_DOCENTE','CO_COR_RACA_DOCENTE','DS_COR_RACA_DOCENTE','NO_MAE','CO_PAIS_DOCENTE','CO_NACIONALIDADE_DOCENTE','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','IN_DOCENTE_DEFICIENCIA','IN_CEGUEIRA','IN_BAIXA_VISAO','IN_SURDEZ','IN_DEFICIENCIA_AUDITIVA','IN_DEFICIENCIA_FISICA','IN_SURDOCEGUEIRA','IN_DEFICIENCIA_MULTIPLA','IN_DEFICIENCIA_INTELECTUAL','IN_ATU_EAD','IN_ATU_EXTENSAO','IN_ATU_GESTAO','IN_ATU_GRAD_PRESENCIAL','IN_ATU_POS_EAD','IN_ATU_POS_PRESENCIAL','IN_ATU_SEQUENCIAL','IN_ATU_PESQUISA','IN_BOLSA_PESQUISA','IN_SUBSTITUTO','IN_EXERCICIO_DT_REF','IN_VISITANTE','IN_VISITANTE_IFES_VINCULO','DT_CADASTRO']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
            line[0:7],
            line[8:15],
            line[16:115],
            line[116:123],
            line[124:223],
            line[224:231],
            line[232:239],
            line[240:253],
            line[254:261],
            line[262:269],
            line[270:283],
            line[284:291],
            line[292:329],
            line[330:337],
            line[338:346],
            line[347:350],
            line[351:352],
            line[353:354],
            line[355:362],
            line[363:370],
            line[371:394],
            line[395:402],
            line[403:410],
            line[411:418],
            line[419:426],
            line[427:434],
            line[435:442],
            line[443:450],
            line[451:458],
            line[459:466],
            line[467:474],
            line[475:482],
            line[483:490],
            line[491:498],
            line[499:506],
            line[507:514],
            line[515:522],
            line[523:530],
            line[531:538],
            line[539:546],
            line[547:554],
            line[555:562],
            line[563:570],
            line[571:578],
            line[579:586],
            line[587:594],
            line[595:602],
            line[603:612]
                )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

                line[print "::: %s minutes :::" % str((time.time() : start)/60)],

if __name__ == "__main__":
    main()