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
            line[0:8],
            line[8:208],
            line[208:216],
            line[216:224],
            line[224:324],
            line[324:332],
            line[332:432],
            line[432:440],
            line[440:590],
            line[590:598],
            line[598:600],
            line[600:630],
            line[630:638],
            line[638:646],
            line[646:654],
            line[654:662],
            line[662:670],
            line[670:678],
            line[678:686],
            line[686:694],
            line[694:702],
            line[702:710],
            line[710:718],
            line[718:726],
            line[726:734],
            line[734:742],
            line[742:750],
            line[750:758],
            line[758:766],
            line[766:774],
            line[774:782],
            line[782:796],
            line[796:810],
            line[810:824],
            line[824:838],
            line[838:852],
            line[852:866],
            line[866:880],
            line[880:894],
            line[894:908],
            line[908:921]
    )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    write_sql(table, tuples, columns, 'replace', chuncksize, dtype)

   print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()