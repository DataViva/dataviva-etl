import sys, click, magic, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_DOCENTE_2012.py ies/extract/data/IES_2012/DOCENTE.txt

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
    dtype={'CO_IES':Numeric(8),'NO_IES':String(200),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'IN_CAPITAL_IES':Numeric(8),'CO_DOCENTE_IES':Numeric(8),'CO_DOCENTE':Numeric(13),'CO_SITUACAO_DOCENTE':Numeric(8),'DS_SITUACAO_DOCENTE':String(50),'CO_ESCOLARIDADE_DOCENTE':Numeric(8),'DS_ESCOLARIDADE_DOCENTE':String(14),'CO_REGIME_TRABALHO':Numeric(8),'DS_REGIME_TRABALHO':String(38),'IN_SEXO_DOCENTE':Numeric(8),'DS_SEXO_DOCENTE':String(9),'NU_ANO_DOCENTE_NASC':Numeric(4),'NU_MES_DOCENTE_NASC':Numeric(2),'NU_DIA_DOCENTE_NASC':Numeric(2),'NU_IDADE_DOCENTE':Numeric(8),'CO_COR_RACA_DOCENTE':Numeric(8),'DS_COR_RACA_DOCENTE':String(24),'CO_PAIS_DOCENTE':Numeric(8),'CO_NACIONALIDADE_DOCENTE':Numeric(8),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'IN_DOCENTE_DEFICIENCIA':Numeric(8),'IN_CEGUEIRA':Numeric(8),'IN_BAIXA_VISAO':Numeric(8),'IN_SURDEZ':Numeric(8),'IN_DEFICIENCIA_AUDITIVA':Numeric(8),'IN_DEFICIENCIA_FISICA':Numeric(8),'IN_SURDOCEGUEIRA':Numeric(8),'IN_DEFICIENCIA_MULTIPLA':Numeric(8),'IN_DEFICIENCIA_INTELECTUAL':Numeric(8),'IN_ATU_EAD':Numeric(8),'IN_ATU_EXTENSAO':Numeric(8),'IN_ATU_GESTAO':Numeric(8),'IN_ATU_GRAD_PRESENCIAL':Numeric(8),'IN_ATU_POS_EAD':Numeric(8),'IN_ATU_POS_PRESENCIAL':Numeric(8),'IN_ATU_SEQUENCIAL':Numeric(8),'IN_ATU_PESQUISA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'IN_SUBSTITUTO':Numeric(8),'IN_EXERCICIO_DT_REF':Numeric(8),'IN_VISITANTE':Numeric(8),'IN_VISITANTE_IFES_VINCULO':Numeric(8)}
    columns = ['CO_IES','NO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','IN_CAPITAL_IES','CO_DOCENTE_IES','CO_DOCENTE','CO_SITUACAO_DOCENTE','DS_SITUACAO_DOCENTE','CO_ESCOLARIDADE_DOCENTE','DS_ESCOLARIDADE_DOCENTE','CO_REGIME_TRABALHO','DS_REGIME_TRABALHO','IN_SEXO_DOCENTE','DS_SEXO_DOCENTE','NU_ANO_DOCENTE_NASC','NU_MES_DOCENTE_NASC','NU_DIA_DOCENTE_NASC','NU_IDADE_DOCENTE','CO_COR_RACA_DOCENTE','DS_COR_RACA_DOCENTE','CO_PAIS_DOCENTE','CO_NACIONALIDADE_DOCENTE','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','IN_DOCENTE_DEFICIENCIA','IN_CEGUEIRA','IN_BAIXA_VISAO','IN_SURDEZ','IN_DEFICIENCIA_AUDITIVA','IN_DEFICIENCIA_FISICA','IN_SURDOCEGUEIRA','IN_DEFICIENCIA_MULTIPLA','IN_DEFICIENCIA_INTELECTUAL','IN_ATU_EAD','IN_ATU_EXTENSAO','IN_ATU_GESTAO','IN_ATU_GRAD_PRESENCIAL','IN_ATU_POS_EAD','IN_ATU_POS_PRESENCIAL','IN_ATU_SEQUENCIAL','IN_ATU_PESQUISA','IN_BOLSA_PESQUISA','IN_SUBSTITUTO','IN_EXERCICIO_DT_REF','IN_VISITANTE','IN_VISITANTE_IFES_VINCULO']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[1:8],
                line[8:208],
                line[208:216],
                line[216:316],
                line[316:324],
                line[324:424],
                line[424:432],
                line[432:440],
                line[440:453],
                line[453:461],
                line[461:511],
                line[511:519],
                line[519:533],
                line[533:541],
                line[541:579],
                line[579:587],
                line[587:596],
                line[596:600],
                line[600:602],
                line[602:604],
                line[604:612],
                line[612:620],
                line[620:644],
                line[644:652],
                line[652:660],
                line[660:668],
                line[668:676],
                line[676:684],
                line[684:692],
                line[692:700],
                line[700:708],
                line[708:716],
                line[716:724],
                line[724:732],
                line[732:740],
                line[740:748],
                line[748:756],
                line[756:764],
                line[764:772],
                line[772:780],
                line[780:788],
                line[788:796],
                line[796:804],
                line[804:812],
                line[812:820],
                line[820:828],
                line[828:836],
                line[836:844],
                line[844:852]
        )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()