import sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql
from collections import OrderedDict

'''

USAGE EXAMPLE:
python ies/extract/load/extract_CURSO_2012.py ies/extract/data/IES_2012/CURSO.txt

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

    #Set file encoding
    encoding = file_encoding(file_path)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    dtype = {'CO_IES':Numeric(8),'NO_IES':String(200),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO_CURSO':Numeric(8),'NO_MUNICIPIO_CURSO':String(150),'CO_UF_CURSO':Numeric(8),'SGL_UF_CURSO':String(2),'NO_REGIAO_CURSO':String(30),'IN_CAPITAL_CURSO':Numeric(8),'CO_CURSO':Numeric(8),'NO_CURSO':String(200),'CO_OCDE':String(12),'NO_OCDE':String(120),'CO_OCDE_AREA_GERAL':String(12),'NO_OCDE_AREA_GERAL':String(120),'CO_OCDE_AREA_ESPECIFICA':String(12),'NO_OCDE_AREA_ESPECIFICA':String(120),'CO_OCDE_AREA_DETALHADA':String(12),'NO_OCDE_AREA_DETALHADA':String(120),'CO_GRAU_ACADEMICO':Numeric(8),'DS_GRAU_ACADEMICO':String(12),'CO_MODALIDADE_ENSINO':Numeric(8),'DS_MODALIDADE_ENSINO':String(11),'CO_NIVEL_ACADEMICO':Numeric(8),'DS_NIVEL_ACADEMICO':String(33),'IN_GRATUITO':Numeric(8),'TP_ATRIBUTO_INGRESSO':Numeric(8),'CO_LOCAL_OFERTA':Numeric(8),'NU_CARGA_HORARIA':Numeric(8),'DT_INICIO_FUNCIONAMENTO': datetime.date(),'DT_AUTORIZACAO_CURSO':Numeric(38),'IN_AJUDA_DEFICIENTE':Numeric(8),'IN_MATERIAL_DIGITAL':Numeric(8),'IN_MATERIAL_AMPLIADO':Numeric(8),'IN_MATERIAL_TATIL':Numeric(8),'IN_MATERIAL_IMPRESSO':Numeric(8),'IN_MATERIAL_AUDIO':Numeric(8),'IN_MATERIAL_BRAILLE':Numeric(8),'IN_DISCIPLINA_LIBRAS':Numeric(8),'IN_GUIA_INTERPRETE':Numeric(8),'IN_MATERIAL_LIBRAS':Numeric(8),'IN_RECURSOS_COMUNICACAO':Numeric(8),'IN_RECURSOS_INFORMATICA':Numeric(8),'IN_TRADUTOR_LIBRAS':Numeric(8),'IN_INTEGRAL_CURSO':Numeric(8),'IN_MATUTINO_CURSO':Numeric(8),'IN_NOTURNO_CURSO':Numeric(8),'IN_VESPERTINO_CURSO':Numeric(8),'NU_PERC_CARGA_HOR_DISTANCIA':Numeric(8),'NU_INTEGRALIZACAO_MATUTINO':Numeric(8),'NU_INTEGRALIZACAO_VESPERTINO':Numeric(8),'NU_INTEGRALIZACAO_NOTURNO':Numeric(8),'NU_INTEGRALIZACAO_INTEGRAL':Numeric(8),'NU_INTEGRALIZACAO_EAD':Numeric(8),'IN_OFERECE_DISC_DISTANCIA':Numeric(8),'IN_POSSUI_LABORATORIO':Numeric(8),'QT_INSCRITOS_ANO_EAD':Numeric(8),'QT_VAGAS_ANUAL_EAD':Numeric(8),'QT_VAGAS_INTEGRAL_PRES':Numeric(8),'QT_VAGAS_MATUTINO_PRES':Numeric(8),'QT_VAGAS_VESPERTINO_PRES':Numeric(8),'QT_VAGAS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_MATUTINO_PRES':Numeric(8),'QT_INSCRITOS_VESPERTINO_PRES':Numeric(8),'QT_INSCRITOS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_INTEGRAL_PRES':Numeric(8),'QT_MATRICULA_CURSO':Numeric(8),'QT_CONCLUINTE_CURSO':Numeric(8),'QT_INGRESSO_CURSO':Numeric(8),'QT_INGRESSO_PROCESSO_SELETIVO':Numeric(8),'QT_INGRESSO_OUTRA_FORMA':Numeric(8)}
    columns = ['CO_IES','NO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO_CURSO','NO_MUNICIPIO_CURSO','CO_UF_CURSO','SGL_UF_CURSO','NO_REGIAO_CURSO','IN_CAPITAL_CURSO','CO_CURSO','NO_CURSO','CO_OCDE','NO_OCDE','CO_OCDE_AREA_GERAL','NO_OCDE_AREA_GERAL','CO_OCDE_AREA_ESPECIFICA','NO_OCDE_AREA_ESPECIFICA','CO_OCDE_AREA_DETALHADA','NO_OCDE_AREA_DETALHADA','CO_GRAU_ACADEMICO','DS_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','DS_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','DS_NIVEL_ACADEMICO','IN_GRATUITO','TP_ATRIBUTO_INGRESSO','CO_LOCAL_OFERTA','NU_CARGA_HORARIA','DT_INICIO_FUNCIONAMENTO','DT_AUTORIZACAO_CURSO','IN_AJUDA_DEFICIENTE','IN_MATERIAL_DIGITAL','IN_MATERIAL_AMPLIADO','IN_MATERIAL_TATIL','IN_MATERIAL_IMPRESSO','IN_MATERIAL_AUDIO','IN_MATERIAL_BRAILLE','IN_DISCIPLINA_LIBRAS','IN_GUIA_INTERPRETE','IN_MATERIAL_LIBRAS','IN_RECURSOS_COMUNICACAO','IN_RECURSOS_INFORMATICA','IN_TRADUTOR_LIBRAS','IN_INTEGRAL_CURSO','IN_MATUTINO_CURSO','IN_NOTURNO_CURSO','IN_VESPERTINO_CURSO','NU_PERC_CARGA_HOR_DISTANCIA','NU_INTEGRALIZACAO_MATUTINO','NU_INTEGRALIZACAO_VESPERTINO','NU_INTEGRALIZACAO_NOTURNO','NU_INTEGRALIZACAO_INTEGRAL','NU_INTEGRALIZACAO_EAD','IN_OFERECE_DISC_DISTANCIA','IN_POSSUI_LABORATORIO','QT_INSCRITOS_ANO_EAD','QT_VAGAS_ANUAL_EAD','QT_VAGAS_INTEGRAL_PRES','QT_VAGAS_MATUTINO_PRES','QT_VAGAS_VESPERTINO_PRES','QT_VAGAS_NOTURNO_PRES','QT_INSCRITOS_MATUTINO_PRES','QT_INSCRITOS_VESPERTINO_PRES','QT_INSCRITOS_NOTURNO_PRES','QT_INSCRITOS_INTEGRAL_PRES','QT_MATRICULA_CURSO','QT_CONCLUINTE_CURSO','QT_INGRESSO_CURSO','QT_INGRESSO_PROCESSO_SELETIVO','QT_INGRESSO_OUTRA_FORMA']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                    line[0:7],
                    line[8:207],
                    line[208:215],
                    line[216:315],
                    line[316:323],
                    line[324:423],
                    line[424:431],
                    line[432:581],
                    line[582:589],
                    line[590:591],
                    line[592:621],
                    line[622:629],
                    line[630:637],
                    line[638:837],
                    line[838:849],
                    line[850:969],
                    line[970:981],
                    line[982:1101],
                    line[1102:1113],
                    line[1114:1233],
                    line[1234:1245],
                    line[1246:1365],
                    line[1366:1373],
                    line[1374:1385],
                    line[1386:1393],
                    line[1394:1404],
                    line[1405:1412],
                    line[1413:1445],
                    line[1446:1453],
                    line[1454:1461],
                    line[1462:1469],
                    line[1470:1477],
                    line[1478:1515],
                    line[1516:1553],
                    line[1554:1561],
                    line[1562:1569],
                    line[1570:1577],
                    line[1578:1585],
                    line[1586:1593],
                    line[1594:1601],
                    line[1602:1609],
                    line[1610:1617],
                    line[1618:1625],
                    line[1626:1633],
                    line[1634:1641],
                    line[1642:1649],
                    line[1650:1657],
                    line[1658:1665],
                    line[1666:1673],
                    line[1674:1681],
                    line[1682:1689],
                    line[1690:1697],
                    line[1698:1705],
                    line[1706:1713],
                    line[1714:1721],
                    line[1722:1729],
                    line[1730:1737],
                    line[1738:1745],
                    line[1746:1753],
                    line[1754:1761],
                    line[1762:1769],
                    line[1770:1777],
                    line[1778:1785],
                    line[1786:1793],
                    line[1794:1801],
                    line[1802:1809],
                    line[1810:1817],
                    line[1818:1825],
                    line[1826:1833],
                    line[1834:1841],
                    line[1842:1849],
                    line[1850:1857],
                    line[1858:1865],
                    line[1866:1873]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()