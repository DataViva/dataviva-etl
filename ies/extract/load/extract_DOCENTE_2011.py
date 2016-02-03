import sys, click, magic, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_DOCENTE_2011.py ies/extract/data/IES_2011/DOCENTE.txt

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
    dtype = {'CO_IES':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'IN_CAPITAL_IES':Numeric(8),'CO_DOCENTE_IES':Numeric(8),'CO_DOCENTE':Numeric(8),'CO_SITUACAO_DOCENTE':Numeric(8),'DS_SITUACAO_DOCENTE':String(50),'CO_ESCOLARIDADE_DOCENTE':Numeric(8),'DS_ESCOLARIDADE_DOCENTE':String(14),'CO_REGIME_TRABALHO':Numeric(8),'DS_REGIME_TRABALHO':String(38),'IN_SEXO_DOCENTE':Numeric(8),'DS_SEXO_DOCENTE':String(9),'NU_ANO_DOCENTE_NASC':Numeric(4),'NU_MES_DOCENTE_NASC':Numeric(2),'NU_DIA_DOCENTE_NASC':Numeric(2),'NU_IDADE_DOCENTE':Numeric(8),'CO_COR_RACA_DOCENTE':Numeric(8),'DS_COR_RACA_DOCENTE':String(24),'CO_PAIS_DOCENTE':Numeric(8),'CO_NACIONALIDADE_DOCENTE':Numeric(8),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'IN_DOCENTE_DEFICIENCIA':Numeric(8),'IN_CEGUEIRA':Numeric(8),'IN_BAIXA_VISAO':Numeric(8),'IN_SURDEZ':Numeric(8),'IN_DEFICIENCIA_AUDITIVA':Numeric(8),'IN_DEFICIENCIA_FISICA':Numeric(8),'IN_SURDOCEGUEIRA':Numeric(8),'IN_DEFICIENCIA_MULTIPLA':Numeric(8),'IN_DEFICIENCIA_INTELECTUAL':Numeric(8),'IN_ATU_EAD':Numeric(8),'IN_ATU_EXTENSAO':Numeric(8),'IN_ATU_GESTAO':Numeric(8),'IN_ATU_GRAD_PRESENCIAL':Numeric(8),'IN_ATU_POS_EAD':Numeric(8),'IN_ATU_POS_PRESENCIAL':Numeric(8),'IN_ATU_SEQUENCIAL':Numeric(8),'IN_ATU_PESQUISA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'IN_SUBSTITUTO':Numeric(8),'IN_EXERCICIO_DT_REF':Numeric(8),'IN_VISITANTE':Numeric(8),'IN_VISITANTE_IFES_VINCULO':Numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','IN_CAPITAL_IES','CO_DOCENTE_IES','CO_DOCENTE','CO_SITUACAO_DOCENTE','DS_SITUACAO_DOCENTE','CO_ESCOLARIDADE_DOCENTE','DS_ESCOLARIDADE_DOCENTE','CO_REGIME_TRABALHO','DS_REGIME_TRABALHO','IN_SEXO_DOCENTE','DS_SEXO_DOCENTE','NU_ANO_DOCENTE_NASC','NU_MES_DOCENTE_NASC','NU_DIA_DOCENTE_NASC','NU_IDADE_DOCENTE','CO_COR_RACA_DOCENTE','DS_COR_RACA_DOCENTE','CO_PAIS_DOCENTE','CO_NACIONALIDADE_DOCENTE','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','IN_DOCENTE_DEFICIENCIA','IN_CEGUEIRA','IN_BAIXA_VISAO','IN_SURDEZ','IN_DEFICIENCIA_AUDITIVA','IN_DEFICIENCIA_FISICA','IN_SURDOCEGUEIRA','IN_DEFICIENCIA_MULTIPLA','IN_DEFICIENCIA_INTELECTUAL','IN_ATU_EAD','IN_ATU_EXTENSAO','IN_ATU_GESTAO','IN_ATU_GRAD_PRESENCIAL','IN_ATU_POS_EAD','IN_ATU_POS_PRESENCIAL','IN_ATU_SEQUENCIAL','IN_ATU_PESQUISA','IN_BOLSA_PESQUISA','IN_SUBSTITUTO','IN_EXERCICIO_DT_REF','IN_VISITANTE','IN_VISITANTE_IFES_VINCULO']

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
            line[240:248],
            line[248:256],
            line[256:306],
            line[306:314],
            line[314:328],
            line[328:336],
            line[336:374],
            line[374:382],
            line[382:391],
            line[391:395],
            line[395:397],
            line[397:399],
            line[399:407],
            line[407:415],
            line[415:439],
            line[439:447],
            line[447:455],
            line[455:463],
            line[463:471],
            line[471:479],
            line[479:487],
            line[487:495],
            line[495:503],
            line[503:511],
            line[511:519],
            line[519:527],
            line[527:535],
            line[535:543],
            line[543:551],
            line[551:559],
            line[559:567],
            line[567:575],
            line[575:583],
            line[583:591],
            line[591:599],
            line[599:607],
            line[607:615],
            line[615:623],
            line[623:631],
            line[631:639],
            line[639:647],
                )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()