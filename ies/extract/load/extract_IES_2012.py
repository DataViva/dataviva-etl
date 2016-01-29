import sys, click, magic, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_IES_2012.py ies/extract/data/IES_2012/IES.txt

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
    dtype = {'CO_IES':Numeric(8),'NO_IES':String(200),'CO_MANTENEDORA':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO_IES':Numeric(8),'NO_MUNICIPIO_IES':String(150),'CO_UF_IES':Numeric(8),'SGL_UF_IES':String(2),'NO_REGIAO_IES':String(30),'IN_CAPITAL_IES':Numeric(8),'QT_TEC_TOTAL':Numeric(8),'QT_TEC_FUND_INCOMP_MASC':Numeric(8),'QT_TEC_FUND_INCOMP_FEM':Numeric(8),'QT_TEC_FUND_COMP_MASC':Numeric(8),'QT_TEC_FUND_COMP_FEM':Numeric(8),'QT_TEC_MEDIO_MASC':Numeric(8),'QT_TEC_MEDIO_FEM':Numeric(8),'QT_TEC_SUPERIOR_MASC':Numeric(8),'QT_TEC_SUPERIOR_FEM':Numeric(8),'QT_TEC_ESPECIALIZACAO_MASC':Numeric(8),'QT_TEC_ESPECIALIZACAO_FEM':Numeric(8),'QT_TEC_MESTRADO_MASC':Numeric(8),'QT_TEC_MESTRADO_FEM':Numeric(8),'QT_TEC_DOUTORADO_MASC':Numeric(8),'QT_TEC_DOUTORADO_FEM':Numeric(8),'IN_ACESSO_PORTAL_CAPES':Numeric(8),'IN_ACESSO_OUTRAS_BASES':Numeric(8),'IN_REFERENTE':Numeric(8),'VL_RECEITA_PROPRIA':Numeric(8),'VL_TRANSFERENCIA':Numeric(8),'VL_OUTRA_RECEITA':Numeric(8),'VL_DES_PESSOAL_REM_DOCENTE':Numeric(8),'VL_DES_PESSOAL_REM_TECNICO':Numeric(8),'VL_DES_PESSOAL_ENCARGO':Numeric(8),'VL_DES_CUSTEIO':Numeric(8),'VL_DES_INVESTIMENTO':Numeric(8),'VL_DES_PESQUISA':Numeric(8),'VL_DES_OUTRAS':Numeric(8)}
    columns = ['CO_IES','NO_IES','CO_MANTENEDORA','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO_IES','NO_MUNICIPIO_IES','CO_UF_IES','SGL_UF_IES','NO_REGIAO_IES','IN_CAPITAL_IES','QT_TEC_TOTAL','QT_TEC_FUND_INCOMP_MASC','QT_TEC_FUND_INCOMP_FEM','QT_TEC_FUND_COMP_MASC','QT_TEC_FUND_COMP_FEM','QT_TEC_MEDIO_MASC','QT_TEC_MEDIO_FEM','QT_TEC_SUPERIOR_MASC','QT_TEC_SUPERIOR_FEM','QT_TEC_ESPECIALIZACAO_MASC','QT_TEC_ESPECIALIZACAO_FEM','QT_TEC_MESTRADO_MASC','QT_TEC_MESTRADO_FEM','QT_TEC_DOUTORADO_MASC','QT_TEC_DOUTORADO_FEM','IN_ACESSO_PORTAL_CAPES','IN_ACESSO_OUTRAS_BASES','IN_REFERENTE','VL_RECEITA_PROPRIA','VL_TRANSFERENCIA','VL_OUTRA_RECEITA','VL_DES_PESSOAL_REM_DOCENTE','VL_DES_PESSOAL_REM_TECNICO','VL_DES_PESSOAL_ENCARGO','VL_DES_CUSTEIO','VL_DES_INVESTIMENTO','VL_DES_PESQUISA','VL_DES_OUTRAS']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
            line[0:7],
            line[8:207],
            line[208:215],
            line[216:223],
            line[224:323],
            line[324:331],
            line[332:431],
            line[432:439],
            line[440:589],
            line[590:597],
            line[598:599],
            line[600:629],
            line[630:637],
            line[638:645],
            line[646:653],
            line[654:661],
            line[662:669],
            line[670:677],
            line[678:685],
            line[686:693],
            line[694:701],
            line[702:709],
            line[710:717],
            line[718:725],
            line[726:733],
            line[734:741],
            line[742:749],
            line[750:757],
            line[758:765],
            line[766:773],
            line[774:781],
            line[782:795],
            line[796:809],
            line[810:823],
            line[824:837],
            line[838:851],
            line[852:865],
            line[866:879],
            line[880:893],
            line[894:907],
            line[908:921]
    )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    write_sql(table, tuples, columns, 'replace', chuncksize, dtype)

   print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()