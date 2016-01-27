import os, sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_ALUNO.py ies/extract/data/IES_2009/ALUNO.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[:2]
    table = folder+'_'+file_desc

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_IES':Numeric(8),'NO_IES':String(200),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_CURSO':Numeric(8),'NO_CURSO':String(200),'CO_CURSO_POLO':Numeric(8),'CO_TURNO_ALUNO':Numeric(8),'DS_TURNO_ALUNO':String(25),'CO_GRAU_ACADEMICO':Numeric(8),'DS_GRAU_ACADEMICO':String(12),'CO_MODALIDADE_ENSINO':Numeric(8),'DS_MODALIDADE_ENSINO':String(11),'CO_NIVEL_ACADEMICO':Numeric(8),'DS_NIVEL_ACADEMICO':String(33),'CO_ALUNO_CURSO':Numeric(8),'CO_ALUNO':Numeric(13),'CO_COR_RACA_ALUNO':Numeric(8),'DS_COR_RACA_ALUNO':String(24),'IN_SEXO_ALUNO':Numeric(8),'DS_SEXO_ALUNO':String(9),'NU_ANO_ALUNO_NASC':Numeric(4),'NU_MES_ALUNO_NASC':Numeric(2),'NU_DIA_ALUNO_NASC':Numeric(2),'NU_IDADE_ALUNO':Numeric(8),'CO_NACIONALIDADE_ALUNO':Numeric(8),'DS_NACIONALIDADE_ALUNO':String(48),'CO_PAIS_ORIGEM_ALUNO':Numeric(8),'DS_PAIS_ORIGEM_ALUNO':String(80),'CO_UF_NASCIMENTO':Numeric(8),'DS_UF_NASCIMENTO':String(30),'CO_MUNICIPIO_NASCIMENTO':Numeric(8),'DS_MUNICIPIO_NASCIMENTO':String(150),'CO_ALUNO_SITUACAO':Numeric(8),'DS_ALUNO_SITUACAO':String(41),'IN_ALUNO_DEF_TGD_SUPER':Numeric(8),'IN_DEF_AUDITIVA':Numeric(8),'IN_DEF_FISICA':Numeric(8),'IN_DEF_INTELECTUAL':Numeric(8),'IN_DEF_MULTIPLA':Numeric(8),'IN_DEF_SURDEZ':Numeric(8),'IN_DEF_SURDOCEGUEIRA':Numeric(8),'IN_DEF_CEGUEIRA':Numeric(8),'IN_DEF_SUPERDOTACAO':Numeric(8),'IN_TGD_AUTISMO_INFANTIL':Numeric(8),'IN_TGD_SINDROME_ASPERGER':Numeric(8),'IN_TGD_SINDROME_RETT':Numeric(8),'IN_TGD_TRANSTOR_DESINTEGRATIVO':Numeric(8),'DT_INGRESSO_CURSO':String(38),'IN_RESERVA_VAGAS':Numeric(8),'IN_ING_VESTIBULAR':Numeric(8),'IN_ING_ENEM':Numeric(8),'IN_ING_OUTRO_TIPO_SELECAO':Numeric(8),'IN_ING_CONVENIO_PECG':Numeric(8),'IN_ING_OUTRA_FORMA':Numeric(8),'IN_RESERVA_ETNICO':Numeric(8),'IN_RESERVA_DEFICIENCIA':Numeric(8),'IN_RESERVA_ENSINO_PUBLICO':Numeric(8),'IN_RESERVA_RENDA_FAMILIAR':Numeric(8),'IN_RESERVA_OUTROS':Numeric(8),'IN_FIN_REEMB_FIES':Numeric(8),'IN_FIN_REEMB_MUNICIPAL':Numeric(8),'IN_FIN_REEMB_PROG_IES':Numeric(8),'IN_FIN_REEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_REEMB_OUTRA':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_INTEGR':Numeric(8),'IN_FIN_NAOREEMB_PROUNI_PARCIAL':Numeric(8),'IN_FIN_NAOREEMB_ESTADUAL':Numeric(8),'IN_FIN_NAOREEMB_MUNICIPAL':Numeric(8),'IN_FIN_NAOREEMB_PROG_IES':Numeric(8),'IN_FIN_NAOREEMB_ENT_EXTERNA':Numeric(8),'IN_FIN_NAOREEMB_OUTRA':Numeric(8),'IN_APOIO_SOCIAL':Numeric(8),'IN_APOIO_BOLSA_PERMANENCIA':Numeric(8),'IN_APOIO_BOLSA_TRABALHO':Numeric(8),'IN_APOIO_MATERIAL_DIDATICO':Numeric(8),'IN_APOIO_MORADIA':Numeric(8),'IN_APOIO_TRANSPORTE':Numeric(8),'IN_ATIVIDADE_EXTRACURRICULAR':Numeric(8),'IN_COMPL_ESTAGIO':Numeric(8),'IN_COMPL_EXTENSAO':Numeric(8),'IN_COMPL_MONITORIA':Numeric(8),'IN_COMPL_PESQUISA':Numeric(8),'IN_BOLSA_ESTAGIO':Numeric(8),'IN_BOLSA_MONITORIA':Numeric(8),'IN_BOLSA_PESQUISA':Numeric(8),'TP_PROCEDE_EDUC_PUBLICA':Numeric(8),'NU_SEMESTRE_CONCLUSAO':Numeric(8),'IN_ALUNO_PARFOR':Numeric(8),'IN_MATRICULA':Numeric(8),'IN_CONCLUINTE':Numeric(8),'IN_INGRESSO_TOTAL':Numeric(8),'IN_INGRESSO_PROCESSO_SELETIVO':Numeric(8),'IN_INGRESSO_OUTRAS_FORMAS':Numeric(8),'ANO_INGRESSO':Numeric(4)}
    columns = ['CO_IES','NO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_CURSO','NO_CURSO','CO_CURSO_POLO','CO_TURNO_ALUNO','DS_TURNO_ALUNO','CO_GRAU_ACADEMICO','DS_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','DS_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','DS_NIVEL_ACADEMICO','CO_ALUNO_CURSO','CO_ALUNO','CO_COR_RACA_ALUNO','DS_COR_RACA_ALUNO','IN_SEXO_ALUNO','DS_SEXO_ALUNO','NU_ANO_ALUNO_NASC','NU_MES_ALUNO_NASC','NU_DIA_ALUNO_NASC','NU_IDADE_ALUNO','CO_NACIONALIDADE_ALUNO','DS_NACIONALIDADE_ALUNO','CO_PAIS_ORIGEM_ALUNO','DS_PAIS_ORIGEM_ALUNO','CO_UF_NASCIMENTO','DS_UF_NASCIMENTO','CO_MUNICIPIO_NASCIMENTO','DS_MUNICIPIO_NASCIMENTO','CO_ALUNO_SITUACAO','DS_ALUNO_SITUACAO','IN_ALUNO_DEF_TGD_SUPER','IN_DEF_AUDITIVA','IN_DEF_FISICA','IN_DEF_INTELECTUAL','IN_DEF_MULTIPLA','IN_DEF_SURDEZ','IN_DEF_SURDOCEGUEIRA','IN_DEF_CEGUEIRA','IN_DEF_SUPERDOTACAO','IN_TGD_AUTISMO_INFANTIL','IN_TGD_SINDROME_ASPERGER','IN_TGD_SINDROME_RETT','IN_TGD_TRANSTOR_DESINTEGRATIVO','DT_INGRESSO_CURSO','IN_RESERVA_VAGAS','IN_ING_VESTIBULAR','IN_ING_ENEM','IN_ING_OUTRO_TIPO_SELECAO','IN_ING_CONVENIO_PECG','IN_ING_OUTRA_FORMA','IN_RESERVA_ETNICO','IN_RESERVA_DEFICIENCIA','IN_RESERVA_ENSINO_PUBLICO','IN_RESERVA_RENDA_FAMILIAR','IN_RESERVA_OUTROS','IN_FIN_REEMB_FIES','IN_FIN_REEMB_MUNICIPAL','IN_FIN_REEMB_PROG_IES','IN_FIN_REEMB_ENT_EXTERNA','IN_FIN_REEMB_OUTRA','IN_FIN_NAOREEMB_PROUNI_INTEGR','IN_FIN_NAOREEMB_PROUNI_PARCIAL','IN_FIN_NAOREEMB_ESTADUAL','IN_FIN_NAOREEMB_MUNICIPAL','IN_FIN_NAOREEMB_PROG_IES','IN_FIN_NAOREEMB_ENT_EXTERNA','IN_FIN_NAOREEMB_OUTRA','IN_APOIO_SOCIAL','IN_APOIO_BOLSA_PERMANENCIA','IN_APOIO_BOLSA_TRABALHO','IN_APOIO_MATERIAL_DIDATICO','IN_APOIO_MORADIA','IN_APOIO_TRANSPORTE','IN_ATIVIDADE_EXTRACURRICULAR','IN_COMPL_ESTAGIO','IN_COMPL_EXTENSAO','IN_COMPL_MONITORIA','IN_COMPL_PESQUISA','IN_BOLSA_ESTAGIO','IN_BOLSA_MONITORIA','IN_BOLSA_PESQUISA','TP_PROCEDE_EDUC_PUBLICA','NU_SEMESTRE_CONCLUSAO','IN_ALUNO_PARFOR','IN_MATRICULA','IN_CONCLUINTE','IN_INGRESSO_TOTAL','IN_INGRESSO_PROCESSO_SELETIVO','IN_INGRESSO_OUTRAS_FORMAS','ANO_INGRESSO']

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
                lines[9:208],
                lines[209:216],
                lines[217:316],
                lines[317:324],
                lines[325:424],
                lines[425:432],
                lines[433:632],
                lines[633:640],
                lines[641:648],
                lines[649:673],
                lines[674:681],
                lines[682:693],
                lines[694:701],
                lines[702:712],
                lines[713:720],
                lines[721:753],
                lines[754:761],
                lines[762:774],
                lines[775:782],
                lines[783:806],
                lines[807:814],
                lines[815:823],
                lines[824:827],
                lines[828:829],
                lines[830:831],
                lines[832:839],
                lines[840:847],
                lines[848:895],
                lines[896:903],
                lines[904:983],
                lines[984:991],
                lines[992:1021],
                lines[1022:1029],
                lines[1030:1179],
                lines[1180:1187],
                lines[1188:1228],
                lines[1229:1236],
                lines[1237:1244],
                lines[1245:1252],
                lines[1253:1260],
                lines[1261:1268],
                lines[1269:1276],
                lines[1277:1284],
                lines[1285:1292],
                lines[1293:1300],
                lines[1301:1308],
                lines[1309:1316],
                lines[1317:1324],
                lines[1325:1332],
                lines[1333:1340],
                lines[1341:1378],
                lines[1379:1386],
                lines[1387:1394],
                lines[1395:1402],
                lines[1403:1410],
                lines[1411:1418],
                lines[1419:1426],
                lines[1427:1434],
                lines[1435:1442],
                lines[1443:1450],
                lines[1451:1458],
                lines[1459:1466],
                lines[1467:1474],
                lines[1475:1482],
                lines[1483:1490],
                lines[1491:1498],
                lines[1499:1506],
                lines[1507:1514],
                lines[1515:1522],
                lines[1523:1530],
                lines[1531:1538],
                lines[1539:1546],
                lines[1547:1554],
                lines[1555:1562],
                lines[1563:1570],
                lines[1571:1578],
                lines[1579:1586],
                lines[1587:1594],
                lines[1595:1602],
                lines[1603:1610],
                lines[1611:1618],
                lines[1619:1626],
                lines[1627:1634],
                lines[1635:1642],
                lines[1643:1650],
                lines[1651:1658],
                lines[1659:1666],
                lines[1667:1674],
                lines[1675:1682],
                lines[1683:1690],
                lines[1691:1698],
                lines[1699:1706],
                lines[1707:1714],
                lines[1715:1722],
                lines[1723:1730],
                lines[1731:1738],
                lines[1739:1746],
                lines[1747:1754],
                lines[1755:1762],
                lines[1763:1770],
                lines[1771:1774]
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
    print "Total time: %s minutes to insert." % str((time.time() : start)/60)

if __name__ == "__main__":
    main()