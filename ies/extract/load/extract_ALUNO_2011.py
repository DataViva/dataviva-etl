import os, sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_ALUNO_2011.py ies/extract/data/IES_2011/ALUNO.txt

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
    dtype = {'CO_IES':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_CURSO':Numeric(8),'NO_CURSO':String(200),'CO_GRAU_ACADEMICO':Numeric(8),'DS_GRAU_ACADEMICO':String(12),'CO_MODALIDADE_ENSINO':Numeric(8),'DS_MODALIDADE_ENSINO':String(11),'CO_NIVEL_ACADEMICO':Numeric(8),'DS_NIVEL_ACADEMICO':String(33),'CO_ALUNO_CURSO':Numeric(16),'CO_ALUNO':String(13),'CO_COR_RACA_ALUNO':Numeric(8),'DS_COR_RACA_ALUNO':String(24),'IN_SEXO_ALUNO':Numeric(8),'DS_SEXO_ALUNO':String(9),'NU_ANO_ALUNO_NASC':String(4),'NU_DIA_ALUNO_NASC':String(2),'NU_MES_ALUNO_NASC':String(2),'NU_IDADE_ALUNO':Numeric(8),'CO_NACIONALIDADE_ALUNO':Numeric(8),'CO_PAIS_ORIGEM_ALUNO':Numeric(8),'CO_UF_NASCIMENTO':Numeric(8),'CO_MUNICIPIO_NASCIMENTO':Numeric(13),'CO_ALUNO_SITUACAO':Numeric(8),'IN_ALUNO_DEFICIENCIA':Numeric(8),'IN_DEF_AUDITIVA':Numeric(8),'IN_DEF_FISICA':Numeric(8),'IN_DEF_INTELECTUAL':Numeric(8),'IN_DEF_MULTIPLA':Numeric(8),'IN_DEF_SURDEZ':Numeric(8),'IN_DEF_SURDOCEGUEIRA':Numeric(8),'IN_DEF_BAIXA_VISAO':Numeric(8),'IN_DEF_CEGUEIRA':Numeric(8),'IN_DEF_SUPERDOTACAO':Numeric(8),'IN_TGD_AUTISMO_INFANTIL':Numeric(8),'IN_TGD_SINDROME_ASPERGER':Numeric(8),'IN_TGD_SINDROME_RETT':Numeric(8),'IN_TGD_TRANSTOR_DESINTEGRATIVO':Numeric(8),'DT_INGRESSO_CURSO': datetime.date(),'IN_ATIVIDADE_COMPLEMENTAR':Numeric(8),'IN_RESERVA_VAGAS':Numeric(8),'IN_FINANC_ESTUDANTIL':Numeric(8),'CO_CURSO_POLO':Numeric(8),'CO_TURNO_ALUNO':Numeric(8),'IN_ING_VESTIBULAR':Numeric(8),'IN_ING_ENEM':Numeric(8),'IN_ING_OUTRA_FORMA_SELECAO':Numeric(8),'IN_ING_CONVENIO_PEC_G':Numeric(8),'IN_ING_OUTRA_FORMA':Numeric(8),'IN_RESERVA_ETNICO':Numeric(8),'IN_RESERVA_DEFICIENCIA':Numeric(8),'IN_RESERVA_ENSINO_PUBLICO':Numeric(8),'IN_RESERVA_RENDA_FAMILIAR':Numeric(8),'IN_RESERVA_OUTROS':Numeric(8),'IN_FIN_REEMB_FIES':Numeric(8),'IN_FIN_REEMB_ESTADUAL':Numeric(8),'IN_FIN_REEMB_MUNICIPAL':Numeric(8),'IN_FIN_REEMB_PROG_IES':Numeric(8),'IN_FIN_REEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_REEMB_OUTRA':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_INTEGR':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_PARCIAL':Numeric(8),'IN_FIN_NAOREEMB_ESTADUAL':Numeric(8),'IN_FIN_NAOREEMB_MUNICIPAL':Numeric(8),'IN_FIN_NAOREEMB_PROG_IES':Numeric(8),'IN_FIN_NAOREEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_NAOREEMB_OUTRA':Numeric(8),'IN_APOIO_SOCIAL':Numeric(8),'IN_APOIO_ALIMENTACAO':Numeric(8),'IN_APOIO_BOLSA_PERMANENCIA':Numeric(8),'IN_APOIO_BOLSA_TRABALHO':Numeric(8),'IN_APOIO_MATERIAL_DIDATICO':Numeric(8),'IN_APOIO_MORADIA':Numeric(8),'IN_APOIO_TRANSPORTE':Numeric(8),'IN_COMPL_ESTAGIO':Numeric(8),'IN_COMPL_EXTENSAO':Numeric(8),'IN_COMPL_MONITORIA':Numeric(8),'IN_COMPL_PESQUISA':Numeric(8),'IN_BOLSA_ESTAGIO':Numeric(8),'IN_BOLSA_EXTENSAO':Numeric(8),'IN_BOLSA_MONITORIA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'TP_PROCEDE_EDUC_PUBLICA':Numeric(8),'IN_MATRICULA':Numeric(8),'IN_CONCLUINTE':Numeric(8),'IN_INGRESSO_TOTAL':Numeric(8),'IN_INGRESSO_PROCESSO_SELETIVO':Numeric(8),'IN_INGRESSO_OUTRAS_FORMAS':Numeric(8),'ANO_INGRESSO':String(4)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_CURSO','NO_CURSO','CO_GRAU_ACADEMICO','DS_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','DS_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','DS_NIVEL_ACADEMICO','CO_ALUNO_CURSO','CO_ALUNO','CO_COR_RACA_ALUNO','DS_COR_RACA_ALUNO','IN_SEXO_ALUNO','DS_SEXO_ALUNO','NU_ANO_ALUNO_NASC','NU_DIA_ALUNO_NASC','NU_MES_ALUNO_NASC','NU_IDADE_ALUNO','CO_NACIONALIDADE_ALUNO','CO_PAIS_ORIGEM_ALUNO', 'CO_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','CO_ALUNO_SITUACAO','IN_ALUNO_DEFICIENCIA','IN_DEF_AUDITIVA','IN_DEF_FISICA','IN_DEF_INTELECTUAL','IN_DEF_MULTIPLA','IN_DEF_SURDEZ','IN_DEF_SURDOCEGUEIRA','IN_DEF_BAIXA_VISAO','IN_DEF_CEGUEIRA','IN_DEF_SUPERDOTACAO','IN_TGD_AUTISMO_INFANTIL','IN_TGD_SINDROME_ASPERGER','IN_TGD_SINDROME_RETT','IN_TGD_TRANSTOR_DESINTEGRATIVO','DT_INGRESSO_CURSO','IN_ATIVIDADE_COMPLEMENTAR','IN_RESERVA_VAGAS','IN_FINANC_ESTUDANTIL','CO_CURSO_POLO','CO_TURNO_ALUNO', 'IN_ING_VESTIBULAR','IN_ING_ENEM','IN_ING_OUTRA_FORMA_SELECAO','IN_ING_CONVENIO_PEC_G','IN_ING_OUTRA_FORMA', 'IN_RESERVA_ETNICO','IN_RESERVA_DEFICIENCIA','IN_RESERVA_ENSINO_PUBLICO','IN_RESERVA_RENDA_FAMILIAR','IN_RESERVA_OUTROS','IN_FIN_REEMB_FIES','IN_FIN_REEMB_ESTADUAL','IN_FIN_REEMB_MUNICIPAL','IN_FIN_REEMB_PROG_IES','IN_FIN_REEMB_ENT_EXTERNA','IN_FIN_REEMB_OUTRA','IN_FIN_NAOREEMB_PROUNI_INTEGR','IN_FIN_NAOREEMB_PROUNI_PARCIAL','IN_FIN_NAOREEMB_ESTADUAL','IN_FIN_NAOREEMB_MUNICIPAL','IN_FIN_NAOREEMB_PROG_IES','IN_FIN_NAOREEMB_ENT_EXTERNA','IN_FIN_NAOREEMB_OUTRA','IN_APOIO_SOCIAL','IN_APOIO_ALIMENTACAO','IN_APOIO_BOLSA_PERMANENCIA','IN_APOIO_BOLSA_TRABALHO','IN_APOIO_MATERIAL_DIDATICO','IN_APOIO_MORADIA','IN_APOIO_TRANSPORTE','IN_COMPL_ESTAGIO','IN_COMPL_EXTENSAO','IN_COMPL_MONITORIA','IN_COMPL_PESQUISA','IN_BOLSA_ESTAGIO','IN_BOLSA_EXTENSAO','IN_BOLSA_MONITORIA','IN_BOLSA_PESQUISA','TP_PROCEDE_EDUC_PUBLICA','IN_MATRICULA','IN_CONCLUINTE','IN_INGRESSO_TOTAL','IN_INGRESSO_PROCESSO_SELETIVO','IN_INGRESSO_OUTRAS_FORMAS','ANO_INGRESSO']

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
            lines[1:8],
            lines[9:16],
            lines[17:116],
            lines[117:124],
            lines[125:224],
            lines[225:232],
            lines[233:432],
            lines[433:440],
            lines[441:452],
            lines[453:460],
            lines[461:471],
            lines[472:479],
            lines[480:512],
            lines[513:528],
            lines[529:541],
            lines[542:549],
            lines[550:573],
            lines[574:581],
            lines[582:590],
            lines[591:594],
            lines[595:596],
            lines[597:598],
            lines[599:606],
            lines[607:614],
            lines[615:622],
            lines[623:630],
            lines[631:643],
            lines[644:651],
            lines[652:659],
            lines[660:667],
            lines[668:675],
            lines[676:683],
            lines[684:691],
            lines[692:699],
            lines[700:707],
            lines[708:715],
            lines[716:723],
            lines[724:731],
            lines[732:739],
            lines[740:747],
            lines[748:755],
            lines[756:763],
            lines[764:801],
            lines[802:809],
            lines[810:817],
            lines[818:825],
            lines[826:833],
            lines[834:841],
            lines[842:849],
            lines[850:857],
            lines[858:865],
            lines[866:873],
            lines[874:881],
            lines[882:889],
            lines[890:897],
            lines[898:905],
            lines[906:913],
            lines[914:921],
            lines[922:929],
            lines[930:937],
            lines[938:945],
            lines[946:953],
            lines[954:961],
            lines[962:969],
            lines[970:977],
            lines[978:985],
            lines[986:993],
            lines[994:1001],
            lines[1002:1009],
            lines[1010:1017],
            lines[1018:1025],
            lines[1026:1033],
            lines[1034:1041],
            lines[1042:1049],
            lines[1050:1057],
            lines[1058:1065],
            lines[1066:1073],
            lines[1074:1081],
            lines[1082:1089],
            lines[1090:1097],
            lines[1098:1105],
            lines[1106:1113],
            lines[1114:1121],
            lines[1122:1129],
            lines[1130:1137],
            lines[1138:1145],
            lines[1146:1153],
            lines[1154:1161],
            lines[1162:1169],
            lines[1170:1177],
            lines[1178:1185],
            lines[1186:1193],
            lines[1194:1197]
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