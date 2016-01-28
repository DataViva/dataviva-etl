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
    dtype={'CO_IES':Numeric(8),'NO_IES':String(200),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'IN_CAPITAL_IES':Numeric(8),'CO_DOCENTE_IES':Numeric(8),'CO_DOCENTE':Numeric(13),'CO_SITUACAO_DOCENTE':Numeric(8),'DS_SITUACAO_DOCENTE':String(50),'CO_ESCOLARIDADE_DOCENTE':Numeric(8),'DS_ESCOLARIDADE_DOCENTE':String(14),'CO_REGIME_TRABALHO':Numeric(8),'DS_REGIME_TRABALHO':String(38),'IN_SEXO_DOCENTE':Numeric(8),'DS_SEXO_DOCENTE':String(9),'NU_ANO_DOCENTE_NASC':Numeric(4),'NU_MES_DOCENTE_NASC':Numeric(2),'NU_DIA_DOCENTE_NASC':Numeric(2),'NU_IDADE_DOCENTE':Numeric(8),'CO_COR_RACA_DOCENTE':Numeric(8),'DS_COR_RACA_DOCENTE':String(24),'CO_PAIS_DOCENTE':Numeric(8),'CO_NACIONALIDADE_DOCENTE':Numeric(8),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'IN_DOCENTE_DEFICIENCIA':Numeric(8),'IN_CEGUEIRA':Numeric(8),'IN_BAIXA_VISAO':Numeric(8),'IN_SURDEZ':Numeric(8),'IN_DEFICIENCIA_AUDITIVA':Numeric(8),'IN_DEFICIENCIA_FISICA':Numeric(8),'IN_SURDOCEGUEIRA':Numeric(8),'IN_DEFICIENCIA_MULTIPLA':Numeric(8),'IN_DEFICIENCIA_INTELECTUAL':Numeric(8),'IN_ATU_EAD':Numeric(8),'IN_ATU_EXTENSAO':Numeric(8),'IN_ATU_GESTAO':Numeric(8),'IN_ATU_GRAD_PRESENCIAL':Numeric(8),'IN_ATU_POS_EAD':Numeric(8),'IN_ATU_POS_PRESENCIAL':Numeric(8),'IN_ATU_SEQUENCIAL':Numeric(8),'IN_ATU_PESQUISA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'IN_SUBSTITUTO':Numeric(8),'IN_EXERCICIO_DT_REF':Numeric(8),'IN_VISITANTE':Numeric(8),'IN_VISITANTE_IFES_VINCULO':Numeric(8)}
    columns = ['CO_IES','NO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','IN_CAPITAL_IES','CO_DOCENTE_IES','CO_DOCENTE','CO_SITUACAO_DOCENTE','DS_SITUACAO_DOCENTE','CO_ESCOLARIDADE_DOCENTE','DS_ESCOLARIDADE_DOCENTE','CO_REGIME_TRABALHO','DS_REGIME_TRABALHO','IN_SEXO_DOCENTE','DS_SEXO_DOCENTE','NU_ANO_DOCENTE_NASC','NU_MES_DOCENTE_NASC','NU_DIA_DOCENTE_NASC','NU_IDADE_DOCENTE','CO_COR_RACA_DOCENTE','DS_COR_RACA_DOCENTE','CO_PAIS_DOCENTE','CO_NACIONALIDADE_DOCENTE','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','IN_DOCENTE_DEFICIENCIA','IN_CEGUEIRA','IN_BAIXA_VISAO','IN_SURDEZ','IN_DEFICIENCIA_AUDITIVA','IN_DEFICIENCIA_FISICA','IN_SURDOCEGUEIRA','IN_DEFICIENCIA_MULTIPLA','IN_DEFICIENCIA_INTELECTUAL','IN_ATU_EAD','IN_ATU_EXTENSAO','IN_ATU_GESTAO','IN_ATU_GRAD_PRESENCIAL','IN_ATU_POS_EAD','IN_ATU_POS_PRESENCIAL','IN_ATU_SEQUENCIAL','IN_ATU_PESQUISA','IN_BOLSA_PESQUISA','IN_SUBSTITUTO','IN_EXERCICIO_DT_REF','IN_VISITANTE','IN_VISITANTE_IFES_VINCULO']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[1:8],
                line[9:208],
                line[209:216],
                line[217:316],
                line[317:324],
                line[325:424],
                line[425:432],
                line[433:440],
                line[441:453],
                line[454:461],
                line[462:511],
                line[512:519],
                line[520:533],
                line[534:541],
                line[542:579],
                line[580:587],
                line[588:596],
                line[597:600],
                line[601:602],
                line[603:604],
                line[605:612],
                line[613:620],
                line[621:644],
                line[645:652],
                line[653:660],
                line[661:668],
                line[669:676],
                line[677:684],
                line[685:692],
                line[693:700],
                line[701:708],
                line[709:716],
                line[717:724],
                line[725:732],
                line[733:740],
                line[741:748],
                line[749:756],
                line[757:764],
                line[765:772],
                line[773:780],
                line[781:788],
                line[789:796],
                line[797:804],
                line[805:812],
                line[813:820],
                line[821:828],
                line[829:836],
                line[837:844],
                line[845:852]
        )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

                line[print "::: %s minutes :::" % str((time.time() : start)/60)],

if __name__ == "__main__":
    main()