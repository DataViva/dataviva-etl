import os, sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_ALUNO_2010.py ies/extract/data/IES_2010/ALUNO.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[-2]
    table = folder+'_'+file_desc

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_IES':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(50),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(200),'CO_CURSO':String(100),'NO_CURSO':Numeric(8),'CO_GRAU_ACADEMICO':Numeric(8),'CO_MODALIDADE_ENSINO':Numeric(8),'CO_NIVEL_ACADEMICO':Numeric(8),'CO_ALUNO_CURSO':Numeric(8),'CO_ALUNO':Numeric(8),'CO_COR_RACA_ALUNO':Numeric(8),'IN_SEXO_ALUNO':Numeric(8),'DS_SEXO_ALUNO':Numeric(8),'NU_ANO_ALUNO_NASC':Numeric(8),'NU_DIA_ALUNO_NASC':Numeric(8),'NU_MES_ALUNO_NASC':Numeric(8),'NU_IDADE_ALUNO':Numeric(8),'CO_NACIONALIDADE_ALUNO':Numeric(8),'CO_PAIS_ORIGEM_ALUNO':Numeric(8),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'CO_ALUNO_SITUACAO':Numeric(8),'IN_DEF_AUDITIVA':Numeric(8),'IN_DEF_FISICA':Numeric(8),'IN_DEF_INTELECTUAL':Numeric(8),'IN_DEF_MULTIPLA':Numeric(8),'IN_DEF_SURDEZ':Numeric(8),'IN_DEF_SURDOCEGUEIRA':Numeric(8),'IN_DEF_BAIXA_VISAO':Numeric(8),'IN_DEF_CEGUEIRA':Numeric(8),'DT_INGRESSO_CURSO':String(38),'IN_ATIVIDADE_COMPLEMENTAR':Numeric(8),'IN_RESERVA_VAGAS':Numeric(8),'IN_APOIO_SOCIAL':Numeric(8),'CO_CURSO_POLO':Numeric(8),'CO_TURNO_ALUNO':Numeric(8),'IN_ING_VESTIBULAR':Numeric(8),'IN_ING_ENEM':Numeric(8),'IN_ING_OUTRA_FORMA_SELECAO':Numeric(8),'IN_ING_CONVENIO_PEC_G':Numeric(8),'IN_ING_OUTRA_FORMA':Numeric(8),'IN_RESERVA_ETNICO':Numeric(8),'IN_RESERVA_DEFICIENCIA':Numeric(8),'IN_RESERVA_ENSINO_PUBLICO':Numeric(8),'IN_RES_RENDA_FAMILIAR':Numeric(8),'IN_FIN_REEMB_FIES':Numeric(8),'IN_FIN_REEMB_ESTADUAL':Numeric(8),'IN_FIN_REEMB_MUNICIPAL':Numeric(8),'IN_FIN_REEMB_PROG_IES':Numeric(8),'IN_FIN_REEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_REEMB_OUTRA':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_INTEGR':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_PARCIAL':Numeric(8),'IN_FIN_NAOREEMB_ESTADUAL':Numeric(8),'IN_FIN_NAOREEMB_MUNICIPAL':Numeric(8),'IN_FIN_NAOREEMB_PROG_IES':Numeric(8),'IN_FIN_NAOREEMB_OUTRA':Numeric(8),'IN_APOIO_ALIMENTACAO':Numeric(8),'IN_APOIO_BOLSA_PERMANENCIA':Numeric(8),'IN_APOIO_BOLSA_TRABALHO':Numeric(8),'IN_APOIO_MATERIAL_DIDATICO':Numeric(8),'IN_APOIO_MORADIA':Numeric(8),'IN_APOIO_TRANSPORTE':Numeric(8),'IN_COMPL_ESTAGIO':Numeric(8),'IN_COMPL_EXTENSAO':Numeric(8),'IN_COMPL_MONITORIA':Numeric(8),'IN_COMPL_PESQUISA':Numeric(8),'IN_BOLSA_ESTAGIO':Numeric(8),'IN_BOLSA_MONITORIA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'TP_PROCEDE_EDUC_PUBLICA':Numeric(8),'IN_MATRICULA':Numeric(8),'IN_CONCLUINTE':Numeric(8),'IN_INGRESSO':Numeric(8),'IN_ING_PROCESSO_SELETIVO':Numeric(8),'IN_ING_OUTRAS_FORMAS':Numeric(8),'ANO_INGRESSO':Numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_CURSO','NO_CURSO','CO_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','CO_ALUNO_CURSO','CO_ALUNO','CO_COR_RACA_ALUNO','IN_SEXO_ALUNO','DS_SEXO_ALUNO','NU_ANO_ALUNO_NASC','NU_DIA_ALUNO_NASC','NU_MES_ALUNO_NASC','NU_IDADE_ALUNO','CO_NACIONALIDADE_ALUNO','CO_PAIS_ORIGEM_ALUNO','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','CO_ALUNO_SITUACAO','IN_DEF_AUDITIVA','IN_DEF_FISICA','IN_DEF_INTELECTUAL','IN_DEF_MULTIPLA','IN_DEF_SURDEZ','IN_DEF_SURDOCEGUEIRA','IN_DEF_BAIXA_VISAO','IN_DEF_CEGUEIRA','DT_INGRESSO_CURSO','IN_ATIVIDADE_COMPLEMENTAR','IN_RESERVA_VAGAS','IN_APOIO_SOCIAL','CO_CURSO_POLO','CO_TURNO_ALUNO','IN_ING_VESTIBULAR','IN_ING_ENEM','IN_ING_OUTRA_FORMA_SELECAO','IN_ING_CONVENIO_PEC_G','IN_ING_OUTRA_FORMA','IN_RESERVA_ETNICO','IN_RESERVA_DEFICIENCIA','IN_RESERVA_ENSINO_PUBLICO','IN_RES_RENDA_FAMILIAR','IN_FIN_REEMB_FIES','IN_FIN_REEMB_ESTADUAL','IN_FIN_REEMB_MUNICIPAL','IN_FIN_REEMB_PROG_IES','IN_FIN_REEMB_ENT_EXTERNA','IN_FIN_REEMB_OUTRA','IN_FIN_NAOREEMB_PROUNI_INTEGR','IN_FIN_NAOREEMB_PROUNI_PARCIAL','IN_FIN_NAOREEMB_ESTADUAL','IN_FIN_NAOREEMB_MUNICIPAL','IN_FIN_NAOREEMB_PROG_IES','IN_FIN_NAOREEMB_OUTRA','IN_APOIO_ALIMENTACAO','IN_APOIO_BOLSA_PERMANENCIA','IN_APOIO_BOLSA_TRABALHO','IN_APOIO_MATERIAL_DIDATICO','IN_APOIO_MORADIA','IN_APOIO_TRANSPORTE','IN_COMPL_ESTAGIO','IN_COMPL_EXTENSAO','IN_COMPL_MONITORIA','IN_COMPL_PESQUISA','IN_BOLSA_ESTAGIO','IN_BOLSA_MONITORIA','IN_BOLSA_PESQUISA','TP_PROCEDE_EDUC_PUBLICA','IN_MATRICULA','IN_CONCLUINTE','IN_INGRESSO','IN_ING_PROCESSO_SELETIVO','IN_ING_OUTRAS_FORMAS','ANO_INGRESSO']

    #max_allowed_packet to mysql insert 16777216
    max_allowed_packet = 1000000

    #number of rows will be written in batches of this size at a time
    chuncksize = 10000

    #If table exists, insert data. Create if does not exist.
    if_exists = 'append'

    first_insertion = True

    start = time.time()

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
            	line[0:7],
				line[8:15],
				line[16:115],
				line[116:123],
				line[124:223],
				line[224:231],
				line[232:431],
				line[432:439],
				line[440:447],
				line[448:455],
				line[456:463],
				line[464:477],
				line[478:485],
				line[486:509],
				line[510:517],
				line[518:526],
				line[527:530],
				line[531:532],
				line[533:534],
				line[535:542],
				line[543:550],
				line[551:558],
				line[559:566],
				line[567:574],
				line[575:582],
				line[583:590],
				line[591:598],
				line[599:606],
				line[607:614],
				line[615:622],
				line[623:630],
				line[631:638],
				line[639:646],
				line[647:654],
				line[655:664],
				line[665:672],
				line[673:680],
				line[681:688],
				line[689:696],
				line[697:704],
				line[705:712],
				line[713:720],
				line[721:728],
				line[729:736],
				line[737:744],
				line[745:752],
				line[753:760],
				line[761:768],
				line[769:776],
				line[777:784],
				line[785:792],
				line[793:800],
				line[801:808],
				line[809:816],
				line[817:824],
				line[825:832],
				line[833:840],
				line[841:848],
				line[849:856],
				line[857:864],
				line[865:872],
				line[873:880],
				line[881:888],
				line[889:896],
				line[897:904],
				line[905:912],
				line[913:920],
				line[921:928],
				line[929:936],
				line[937:944],
				line[945:952],
				line[953:960],
				line[961:968],
				line[969:976],
				line[977:984],
				line[985:992],
				line[993:1000],
				line[1001:1008],
				line[1009:1016],
				line[1017:1024],
				line[1025:1032],
				line[1033:1040],
				line[1041:1048],
				line[1049:1056],
				line[1057:1060]
                )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

            if sys.getsizeof(tuples) > max_allowed_packet:
                if first_insertion == True:
                    write_sql(table, tuples, columns, 'replace', chuncksize, dtype)
                    print "...importing..."
                    tuples = []
                    first_insertion = False

                else:
                    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)
                    print "...importing..."
                    tuples = []

    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)
    print "Total time: %s minutes to insert." % str((time.time() - start)/60)

if __name__ == "__main__":
    main()