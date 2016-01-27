import sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql
from collections import OrderedDict

'''

USAGE EXAMPLE:
python ies/extract/load/extract_CURSO_2011.py ies/extract/data/IES_2011/CURSO.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[:2]
    table = folder+'_'+file_desc

    start = time.time()

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_IES':Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO_CURSO':Numeric(8),'NO_MUNICIPIO_CURSO':String(150),'CO_UF_CURSO':Numeric(8),'SGL_UF_CURSO':String(2),'NO_REGIAO_CURSO':String(30),'IN_CAPITAL_CURSO':Numeric(8),'CO_CURSO':Numeric(8),'NO_CURSO':String(200),'CO_OCDE':String(12),'NO_OCDE':String(120),'CO_OCDE_AREA_GERAL':String(12),'NO_OCDE_AREA_GERAL':String(120),'CO_OCDE_AREA_ESPECIFICA':String(12),'NO_OCDE_AREA_ESPECIFICA':String(120),'CO_OCDE_AREA_DETALHADA':String(12),'NO_OCDE_AREA_DETALHADA':String(120),'CO_GRAU_ACADEMICO':Numeric(8),'DS_GRAU_ACADEMICO':String(12),'CO_MODALIDADE_ENSINO':Numeric(8),'DS_MODALIDADE_ENSINO':String(11),'CO_NIVEL_ACADEMICO':Numeric(8),'DS_NIVEL_ACADEMICO':String(33),'IN_GRATUITO':Numeric(8),'TP_ATRIBUTO_INGRESSO':Numeric(8),'CO_LOCAL_OFERTA':Numeric(9),'NU_CARGA_HORARIA':Numeric(8),'DT_INICIO_FUNCIONAMENTO':String(38),'DT_AUTORIZACAO_CURSO':String(38),'IN_AJUDA_DEFICIENTE':Numeric(8),'IN_MATERIAL_DIGITAL':Numeric(8),'IN_MATERIAL_IMPRESSO':Numeric(8),'IN_MATERIAL_AUDIO':Numeric(8),'IN_MATERIAL_BRAILLE':Numeric(8),'IN_DISCIPLINA_LIBRAS':Numeric(8),'IN_GUIA_INTERPRETE':Numeric(8),'IN_MATERIAL_LIBRAS':Numeric(8),'IN_TRADUTOR_LIBRAS':Numeric(8),'IN_INTEGRAL_CURSO':Numeric(8),'IN_MATUTINO_CURSO':Numeric(8),'IN_NOTURNO_CURSO':Numeric(8),'IN_VESPERTINO_CURSO':Numeric(8),'IN_MATERIAL_AMPLIADO':Numeric(8),'IN_MATERIAL_TATIL':Numeric(8),'IN_RECURSOS_COMUNICACAO':Numeric(8),'IN_RECURSOS_INFORMATICA':Numeric(8),'NU_PERC_CARGA_HOR_DISTANCIA':Numeric(8),'NU_INTEGRALIZACAO_MATUTINO':Numeric(8),'NU_INTEGRALIZACAO_VESPERTINO':Numeric(8),'NU_INTEGRALIZACAO_NOTURNO':Numeric(8),'NU_INTEGRALIZACAO_INTEGRAL':Numeric(8),'IN_OFERECE_DISC_DISTANCIA':Numeric(8),'IN_POSSUI_LABORATORIO':Numeric(8),'QT_MATRICULA_CURSO':Numeric(8),'QT_CONCLUINTE_CURSO':Numeric(8),'QT_INGRESSO_CURSO':Numeric(8),'QT_INGRESSO_PROCESSO_SELETIVO':Numeric(8),'QT_INGRESSO_OUTRA_FORMA':Numeric(8),'QT_INSCRITOS_ANO_EAD':Numeric(8),'QT_VAGAS_ANUAL_EAD':Numeric(8),'QT_VAGAS_INTEGRAL_PRES':Numeric(8),'QT_VAGAS_MATUTINO_PRES':Numeric(8),'QT_VAGAS_VESPERTINO_PRES':Numeric(8),'QT_VAGAS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_MATUTINO_PRES':Numeric(8),'QT_INSCRITOS_VESPERTINO_PRES':Numeric(8),'QT_INSCRITOS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_INTEGRAL_PRES':Numeric(8),'NU_INTEGRALIZACAO_EAD':Numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO_CURSO','NO_MUNICIPIO_CURSO','CO_UF_CURSO','SGL_UF_CURSO','NO_REGIAO_CURSO','IN_CAPITAL_CURSO','CO_CURSO','NO_CURSO','CO_OCDE','NO_OCDE','CO_OCDE_AREA_GERAL','NO_OCDE_AREA_GERAL','CO_OCDE_AREA_ESPECIFICA','NO_OCDE_AREA_ESPECIFICA','CO_OCDE_AREA_DETALHADA','NO_OCDE_AREA_DETALHADA','CO_GRAU_ACADEMICO','DS_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','DS_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','DS_NIVEL_ACADEMICO','IN_GRATUITO','TP_ATRIBUTO_INGRESSO','CO_LOCAL_OFERTA','NU_CARGA_HORARIA','DT_INICIO_FUNCIONAMENTO','DT_AUTORIZACAO_CURSO','IN_AJUDA_DEFICIENTE','IN_MATERIAL_DIGITAL','IN_MATERIAL_IMPRESSO','IN_MATERIAL_AUDIO','IN_MATERIAL_BRAILLE','IN_DISCIPLINA_LIBRAS','IN_GUIA_INTERPRETE','IN_MATERIAL_LIBRAS','IN_TRADUTOR_LIBRAS','IN_INTEGRAL_CURSO','IN_MATUTINO_CURSO','IN_NOTURNO_CURSO','IN_VESPERTINO_CURSO','IN_MATERIAL_AMPLIADO','IN_MATERIAL_TATIL','IN_RECURSOS_COMUNICACAO','IN_RECURSOS_INFORMATICA','NU_PERC_CARGA_HOR_DISTANCIA','NU_INTEGRALIZACAO_MATUTINO','NU_INTEGRALIZACAO_VESPERTINO','NU_INTEGRALIZACAO_NOTURNO','NU_INTEGRALIZACAO_INTEGRAL','IN_OFERECE_DISC_DISTANCIA','IN_POSSUI_LABORATORIO','QT_MATRICULA_CURSO','QT_CONCLUINTE_CURSO','QT_INGRESSO_CURSO','QT_INGRESSO_PROCESSO_SELETIVO','QT_INGRESSO_OUTRA_FORMA','QT_INSCRITOS_ANO_EAD','QT_VAGAS_ANUAL_EAD','QT_VAGAS_INTEGRAL_PRES','QT_VAGAS_MATUTINO_PRES','QT_VAGAS_VESPERTINO_PRES','QT_VAGAS_NOTURNO_PRES','QT_INSCRITOS_MATUTINO_PRES','QT_INSCRITOS_VESPERTINO_PRES','QT_INSCRITOS_NOTURNO_PRES','QT_INSCRITOS_INTEGRAL_PRES','NU_INTEGRALIZACAO_EAD']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                    line[0:7],
                    line[8:15],
                    line[16:115],
                    line[116:123],
                    line[124:223],
                    line[224:231],
                    line[232:381],
                    line[382:389],
                    line[390:391],
                    line[392:421],
                    line[422:429],
                    line[430:437],
                    line[438:637],
                    line[638:649],
                    line[650:769],
                    line[770:781],
                    line[782:901],
                    line[902:913],
                    line[914:1033],
                    line[1034:1045],
                    line[1046:1165],
                    line[1166:1173],
                    line[1174:1185],
                    line[1186:1193],
                    line[1194:1204],
                    line[1205:1212],
                    line[1213:1245],
                    line[1246:1253],
                    line[1254:1261],
                    line[1262:1270],
                    line[1271:1278],
                    line[1279:1316],
                    line[1317:1354],
                    line[1355:1362],
                    line[1363:1370],
                    line[1371:1378],
                    line[1379:1386],
                    line[1387:1394],
                    line[1395:1402],
                    line[1403:1410],
                    line[1411:1418],
                    line[1419:1426],
                    line[1427:1434],
                    line[1435:1442],
                    line[1443:1450],
                    line[1451:1458],
                    line[1459:1466],
                    line[1467:1474],
                    line[1475:1482],
                    line[1483:1490],
                    line[1491:1498],
                    line[1499:1506],
                    line[1507:1514],
                    line[1515:1522],
                    line[1523:1530],
                    line[1531:1538],
                    line[1539:1546],
                    line[1547:1554],
                    line[1555:1562],
                    line[1563:1570],
                    line[1571:1578],
                    line[1579:1586],
                    line[1587:1594],
                    line[1595:1602],
                    line[1603:1610],
                    line[1611:1618],
                    line[1619:1626],
                    line[1627:1634],
                    line[1635:1642],
                    line[1643:1650],
                    line[1651:1658],
                    line[1659:1666],
                    line[1667:1674]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "::: %s minutes :::" % str((time.time() : start)/60)

if __name__ == "__main__":
    main()