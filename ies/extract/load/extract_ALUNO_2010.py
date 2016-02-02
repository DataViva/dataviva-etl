import os, sys, click, codecs, time, magic
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
#from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_ALUNO_2010.py ies/extract/data/IES_2010/ALUNO.txt

'''

@click.command() @click.argument('file_path', type=click.Path(exists=True),
required=True) def main(file_path):     #Set table by file_path     file_name =
basename(file_path)     file_desc, file_ext = splitext(file_name)     folder =
file_path.split('/')[-2]     table = folder+'_'+file_desc

    #Set file encoding
    fp = open(file_path).read()
    m = magic.Magic(mime_encoding=True)
    encoding = m.from_buffer(fp)

    tuples = []
    dtype = {'CO_IES':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(50),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(200),'CO_CURSO':String(100),'NO_CURSO':String(200),'CO_GRAU_ACADEMICO':Numeric(8),'CO_MODALIDADE_ENSINO':Numeric(8),'CO_NIVEL_ACADEMICO':Numeric(8),'CO_ALUNO_CURSO':Numeric(8),'CO_ALUNO':Numeric(8),'CO_COR_RACA_ALUNO':Numeric(8),'DS_COR_RACA_ALUNO':String(100),'IN_SEXO_ALUNO':Numeric(8),'DS_SEXO_ALUNO':String(100),'NU_ANO_ALUNO_NASC':Numeric(8),'NU_DIA_ALUNO_NASC':Numeric(8),'NU_MES_ALUNO_NASC':Numeric(8),'NU_IDADE_ALUNO':Numeric(8),'CO_NACIONALIDADE_ALUNO':Numeric(8),'CO_PAIS_ORIGEM_ALUNO':Numeric(8),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'CO_ALUNO_SITUACAO':Numeric(8),'IN_ALUNO_DEFICIENCIA':Numeric(8),'IN_DEF_AUDITIVA':Numeric(8),'IN_DEF_FISICA':Numeric(8),'IN_DEF_INTELECTUAL':Numeric(8),'IN_DEF_MULTIPLA':Numeric(8),'IN_DEF_SURDEZ':Numeric(8),'IN_DEF_SURDOCEGUEIRA':Numeric(8),'IN_DEF_BAIXA_VISAO':Numeric(8),'IN_DEF_CEGUEIRA':Numeric(8),'DT_INGRESSO_CURSO':String(38),'IN_ATIVIDADE_COMPLEMENTAR':Numeric(8),'IN_RESERVA_VAGAS':Numeric(8),'IN_FINANC_ESTUDANTIL':Numeric(8),'IN_APOIO_SOCIAL':Numeric(8),'CO_CURSO_POLO':Numeric(8),'CO_TURNO_ALUNO':Numeric(8),'IN_ING_VESTIBULAR':Numeric(8),'IN_ING_ENEM':Numeric(8),'IN_ING_OUTRA_FORMA_SELECAO':Numeric(8),'IN_ING_CONVENIO_PEC_G':Numeric(8),'IN_ING_OUTRA_FORMA':Numeric(8),'IN_RESERVA_ETNICO':Numeric(8),'IN_RESERVA_DEFICIENCIA':Numeric(8),'IN_RESERVA_ENSINO_PUBLICO':Numeric(8),'IN_RES_RENDA_FAMILIAR':Numeric(8),'IN_RESERVA_OUTROS':Numeric(8),'IN_FIN_REEMB_FIES':Numeric(8),'IN_FIN_REEMB_ESTADUAL':Numeric(8),'IN_FIN_REEMB_MUNICIPAL':Numeric(8),'IN_FIN_REEMB_PROG_IES':Numeric(8),'IN_FIN_REEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_REEMB_OUTRA':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_INTEGR':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_PARCIAL':Numeric(8),'IN_FIN_NAOREEMB_ESTADUAL':Numeric(8),'IN_FIN_NAOREEMB_MUNICIPAL':Numeric(8),'IN_FIN_NAOREEMB_PROG_IES':Numeric(8),'IN_FIN_NAOREEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_NAOREEMB_OUTRA':Numeric(8),'IN_APOIO_ALIMENTACAO':Numeric(8),'IN_APOIO_BOLSA_PERMANENCIA':Numeric(8),'IN_APOIO_BOLSA_TRABALHO':Numeric(8),'IN_APOIO_MATERIAL_DIDATICO':Numeric(8),'IN_APOIO_MORADIA':Numeric(8),'IN_APOIO_TRANSPORTE':Numeric(8),'IN_COMPL_ESTAGIO':Numeric(8),'IN_COMPL_EXTENSAO':Numeric(8),'IN_COMPL_MONITORIA':Numeric(8),'IN_COMPL_PESQUISA':Numeric(8),'IN_BOLSA_ESTAGIO':Numeric(8),'IN_BOLSA_EXTENSAO':Numeric(8),'IN_BOLSA_MONITORIA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'TP_PROCEDE_EDUC_PUBLICA':Numeric(8),'IN_MATRICULA':Numeric(8),'IN_CONCLUINTE':Numeric(8),'IN_INGRESSO':Numeric(8),'IN_ING_PROCESSO_SELETIVO':Numeric(8),'IN_ING_OUTRAS_FORMAS':Numeric(8),'ANO_INGRESSO':Numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_CURSO','NO_CURSO','CO_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','CO_ALUNO_CURSO','CO_ALUNO','CO_COR_RACA_ALUNO','DS_COR_RACA_ALUNO','IN_SEXO_ALUNO','DS_SEXO_ALUNO','NU_ANO_ALUNO_NASC','NU_DIA_ALUNO_NASC','NU_MES_ALUNO_NASC','NU_IDADE_ALUNO','CO_NACIONALIDADE_ALUNO','CO_PAIS_ORIGEM_ALUNO','CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','CO_ALUNO_SITUACAO','IN_ALUNO_DEFICIENCIA','IN_DEF_AUDITIVA','IN_DEF_FISICA','IN_DEF_INTELECTUAL','IN_DEF_MULTIPLA','IN_DEF_SURDEZ','IN_DEF_SURDOCEGUEIRA','IN_DEF_BAIXA_VISAO','IN_DEF_CEGUEIRA','DT_INGRESSO_CURSO','IN_ATIVIDADE_COMPLEMENTAR','IN_RESERVA_VAGAS','IN_FINANC_ESTUDANTIL','IN_APOIO_SOCIAL','CO_CURSO_POLO','CO_TURNO_ALUNO','IN_ING_VESTIBULAR','IN_ING_ENEM','IN_ING_OUTRA_FORMA_SELECAO','IN_ING_CONVENIO_PEC_G','IN_ING_OUTRA_FORMA','IN_RESERVA_ETNICO','IN_RESERVA_DEFICIENCIA','IN_RESERVA_ENSINO_PUBLICO','IN_RES_RENDA_FAMILIAR','IN_RESERVA_OUTROS','IN_FIN_REEMB_FIES','IN_FIN_REEMB_ESTADUAL','IN_FIN_REEMB_MUNICIPAL','IN_FIN_REEMB_PROG_IES','IN_FIN_REEMB_ENT_EXTERNA','IN_FIN_REEMB_OUTRA','IN_FIN_NAOREEMB_PROUNI_INTEGR','IN_FIN_NAOREEMB_PROUNI_PARCIAL','IN_FIN_NAOREEMB_ESTADUAL','IN_FIN_NAOREEMB_MUNICIPAL','IN_FIN_NAOREEMB_PROG_IES','IN_FIN_NAOREEMB_ENT_EXTERNA','IN_FIN_NAOREEMB_OUTRA','IN_APOIO_ALIMENTACAO','IN_APOIO_BOLSA_PERMANENCIA','IN_APOIO_BOLSA_TRABALHO','IN_APOIO_MATERIAL_DIDATICO','IN_APOIO_MORADIA','IN_APOIO_TRANSPORTE','IN_COMPL_ESTAGIO','IN_COMPL_EXTENSAO','IN_COMPL_MONITORIA','IN_COMPL_PESQUISA','IN_BOLSA_ESTAGIO','IN_BOLSA_EXTENSAO','IN_BOLSA_MONITORIA','IN_BOLSA_PESQUISA','TP_PROCEDE_EDUC_PUBLICA','IN_MATRICULA','IN_CONCLUINTE','IN_INGRESSO','IN_ING_PROCESSO_SELETIVO','IN_ING_OUTRAS_FORMAS','ANO_INGRESSO']

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
            	line[0:8],
				line[8:16],
				line[16:116],
				line[116:124],
				line[124:224],
				line[224:232],
				line[232:432],
				line[432:440],
				line[440:448],
				line[448:456],
				line[456:464],
				line[464:478],
				line[478:486],
				line[486:510],
				line[510:518],
				line[518:527],
				line[527:531],
				line[531:533],
				line[533:535],
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
				line[647:655],
				line[655:665],
				line[665:673],
				line[673:681],
				line[681:689],
				line[689:697],
				line[697:705],
				line[705:713],
				line[713:721],
				line[721:729],
				line[729:737],
				line[737:745],
				line[745:753],
				line[753:761],
				line[761:769],
				line[769:777],
				line[777:785],
				line[785:793],
				line[793:801],
				line[801:809],
				line[809:817],
				line[817:825],
				line[825:833],
				line[833:841],
				line[841:849],
				line[849:857],
				line[857:865],
				line[865:873],
				line[873:881],
				line[881:889],
				line[889:897],
				line[897:905],
				line[905:913],
				line[913:921],
				line[921:929],
				line[929:937],
				line[937:945],
				line[945:953],
				line[953:961],
				line[961:969],
				line[969:977],
				line[977:985],
				line[985:993],
				line[993:1001],
				line[1001:1009],
				line[1009:1017],
				line[1017:1025],
				line[1025:1033],
				line[1033:1041],
				line[1041:1049],
				line[1049:1057],
				line[1057:1062],
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