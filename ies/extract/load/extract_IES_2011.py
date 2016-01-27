import sys, click, magic, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_IES_2011.py ies/extract/data/IES_2011/IES.txt

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
    dtype={'CO_IES':Numeric(8),'CO_MANTENEDORA':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO_IES':Numeric(8),'NO_MUNICIPIO_IES':String(150),'CO_UF_IES':Numeric(8),'SGL_UF_IES':String(2),'NO_REGIAO_IES':String(30),'IN_CAPITAL_IES':Numeric(8),'QT_TEC_TOTAL':Numeric(8),'QT_TEC_FUND_INCOMP_MASC':Numeric(8),'QT_TEC_FUND_INCOMP_FEM':Numeric(8),'QT_TEC_FUND_COMP_MASC':Numeric(8),'QT_TEC_FUND_COMP_FEM':Numeric(8),'QT_TEC_MEDIO_MASC':Numeric(8),'QT_TEC_MEDIO_FEM':Numeric(8),'QT_TEC_SUPERIOR_MASC':Numeric(8),'QT_TEC_SUPERIOR_FEM':Numeric(8),'QT_TEC_ESPECIALIZACAO_MASC':Numeric(8),'QT_TEC_ESPECIALIZACAO_FEM':Numeric(8),'QT_TEC_MESTRADO_MASC':Numeric(8),'QT_TEC_MESTRADO_FEM':Numeric(8),'QT_TEC_DOUTORADO_MASC':Numeric(8),'QT_TEC_DOUTORADO_FEM':Numeric(8),'IN_ACESSO_PORTAL_CAPES':Numeric(8),'IN_ACESSO_OUTRAS_BASES':Numeric(8),'IN_REFERENTE':Numeric(8),'VL_RECEITA_PROPRIA':Numeric(14),'VL_TRANSFERENCIA':Numeric(14),'VL_OUTRA_RECEITA':Numeric(14),'VL_DES_PESSOAL_REM_DOCENTE':Numeric(14),'VL_DES_PESSOAL_REM_TECNICO':Numeric(14),'VL_DES_PESSOAL_ENCARGO':Numeric(14),'VL_DES_CUSTEIO':Numeric(14),'VL_DES_INVESTIMENTO':Numeric(14),'VL_DES_PESQUISA':Numeric(14),'VL_DES_OUTRAS':Numeric(14)}
    columns = ['CO_IES','CO_MANTENEDORA','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO_IES','NO_MUNICIPIO_IES','CO_UF_IES','SGL_UF_IES','NO_REGIAO_IES','IN_CAPITAL_IES','QT_TEC_TOTAL','QT_TEC_FUND_INCOMP_MASC','QT_TEC_FUND_INCOMP_FEM','QT_TEC_FUND_COMP_MASC','QT_TEC_FUND_COMP_FEM','QT_TEC_MEDIO_MASC','QT_TEC_MEDIO_FEM','QT_TEC_SUPERIOR_MASC','QT_TEC_SUPERIOR_FEM','QT_TEC_ESPECIALIZACAO_MASC','QT_TEC_ESPECIALIZACAO_FEM','QT_TEC_MESTRADO_MASC','QT_TEC_MESTRADO_FEM','QT_TEC_DOUTORADO_MASC','QT_TEC_DOUTORADO_FEM','IN_ACESSO_PORTAL_CAPES','IN_ACESSO_OUTRAS_BASES','IN_REFERENTE','VL_RECEITA_PROPRIA','VL_TRANSFERENCIA','VL_OUTRA_RECEITA','VL_DES_PESSOAL_REM_DOCENTE','VL_DES_PESSOAL_REM_TECNICO','VL_DES_PESSOAL_ENCARGO','VL_DES_CUSTEIO','VL_DES_INVESTIMENTO','VL_DES_PESQUISA','VL_DES_OUTRAS']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:7],
                line[8:15],
                line[16:23],
                line[24:123],
                line[124:131],
                line[132:231],
                line[232:239],
                line[240:389],
                line[390:397],
                line[398:399],
                line[400:429],
                line[430:437],
                line[438:445],
                line[446:453],
                line[454:461],
                line[462:469],
                line[470:477],
                line[478:485],
                line[486:493],
                line[494:501],
                line[502:509],
                line[510:517],
                line[518:525],
                line[526:533],
                line[534:541],
                line[542:549],
                line[550:557],
                line[558:565],
                line[566:573],
                line[574:581],
                line[582:595],
                line[596:609],
                line[610:623],
                line[624:637],
                line[638:651],
                line[652:665],
                line[666:679],
                line[680:693],
                line[694:707],
                line[708:721]
                )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    write_sql(table, tuples, columns, 'replace', chuncksize, dtype)

                    line[print "::: %s minutes :::" % str((time.time() : start)/60)],

if __name__ == "__main__":
    main()