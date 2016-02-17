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
    dtype = {'CO_IES':Numeric(8),'NO_IES':String(200),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(100),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO_CURSO':Numeric(8),'NO_MUNICIPIO_CURSO':String(150),'CO_UF_CURSO':Numeric(8),'SGL_UF_CURSO':String(2),'NO_REGIAO_CURSO':String(30),'IN_CAPITAL_CURSO':Numeric(8),'CO_CURSO':Numeric(8),'NO_CURSO':String(200),'CO_OCDE':String(12),'NO_OCDE':String(120),'CO_OCDE_AREA_GERAL':String(12),'NO_OCDE_AREA_GERAL':String(120),'CO_OCDE_AREA_ESPECIFICA':String(12),'NO_OCDE_AREA_ESPECIFICA':String(120),'CO_OCDE_AREA_DETALHADA':String(12),'NO_OCDE_AREA_DETALHADA':String(120),'CO_GRAU_ACADEMICO':Numeric(8),'DS_GRAU_ACADEMICO':String(12),'CO_MODALIDADE_ENSINO':Numeric(8),'DS_MODALIDADE_ENSINO':String(11),'CO_NIVEL_ACADEMICO':Numeric(8),'DS_NIVEL_ACADEMICO':String(33),'IN_GRATUITO':Numeric(8),'TP_ATRIBUTO_INGRESSO':Numeric(8),'CO_LOCAL_OFERTA':Numeric(8),'NU_CARGA_HORARIA':Numeric(8),'DT_INICIO_FUNCIONAMENTO': String (38),'DT_AUTORIZACAO_CURSO':Numeric(38),'IN_AJUDA_DEFICIENTE':Numeric(8),'IN_MATERIAL_DIGITAL':Numeric(8),'IN_MATERIAL_AMPLIADO':Numeric(8),'IN_MATERIAL_TATIL':Numeric(8),'IN_MATERIAL_IMPRESSO':Numeric(8),'IN_MATERIAL_AUDIO':Numeric(8),'IN_MATERIAL_BRAILLE':Numeric(8),'IN_DISCIPLINA_LIBRAS':Numeric(8),'IN_GUIA_INTERPRETE':Numeric(8),'IN_MATERIAL_LIBRAS':Numeric(8),'IN_RECURSOS_COMUNICACAO':Numeric(8),'IN_RECURSOS_INFORMATICA':Numeric(8),'IN_TRADUTOR_LIBRAS':Numeric(8),'IN_INTEGRAL_CURSO':Numeric(8),'IN_MATUTINO_CURSO':Numeric(8),'IN_NOTURNO_CURSO':Numeric(8),'IN_VESPERTINO_CURSO':Numeric(8),'NU_PERC_CARGA_HOR_DISTANCIA':Numeric(8),'NU_INTEGRALIZACAO_MATUTINO':Numeric(8),'NU_INTEGRALIZACAO_VESPERTINO':Numeric(8),'NU_INTEGRALIZACAO_NOTURNO':Numeric(8),'NU_INTEGRALIZACAO_INTEGRAL':Numeric(8),'NU_INTEGRALIZACAO_EAD':Numeric(8),'IN_OFERECE_DISC_DISTANCIA':Numeric(8),'IN_POSSUI_LABORATORIO':Numeric(8),'QT_INSCRITOS_ANO_EAD':Numeric(8),'QT_VAGAS_ANUAL_EAD':Numeric(8),'QT_VAGAS_INTEGRAL_PRES':Numeric(8),'QT_VAGAS_MATUTINO_PRES':Numeric(8),'QT_VAGAS_VESPERTINO_PRES':Numeric(8),'QT_VAGAS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_MATUTINO_PRES':Numeric(8),'QT_INSCRITOS_VESPERTINO_PRES':Numeric(8),'QT_INSCRITOS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_INTEGRAL_PRES':Numeric(8),'QT_MATRICULA_CURSO':Numeric(8),'QT_CONCLUINTE_CURSO':Numeric(8),'QT_INGRESSO_CURSO':Numeric(8),'QT_INGRESSO_PROCESSO_SELETIVO':Numeric(8),'QT_INGRESSO_OUTRA_FORMA':Numeric(8)}
    columns = ['CO_IES','NO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO_CURSO','NO_MUNICIPIO_CURSO','CO_UF_CURSO','SGL_UF_CURSO','NO_REGIAO_CURSO','IN_CAPITAL_CURSO','CO_CURSO','NO_CURSO','CO_OCDE','NO_OCDE','CO_OCDE_AREA_GERAL','NO_OCDE_AREA_GERAL','CO_OCDE_AREA_ESPECIFICA','NO_OCDE_AREA_ESPECIFICA','CO_OCDE_AREA_DETALHADA','NO_OCDE_AREA_DETALHADA','CO_GRAU_ACADEMICO','DS_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','DS_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','DS_NIVEL_ACADEMICO','IN_GRATUITO','TP_ATRIBUTO_INGRESSO','CO_LOCAL_OFERTA','NU_CARGA_HORARIA','DT_INICIO_FUNCIONAMENTO','DT_AUTORIZACAO_CURSO','IN_AJUDA_DEFICIENTE','IN_MATERIAL_DIGITAL','IN_MATERIAL_AMPLIADO','IN_MATERIAL_TATIL','IN_MATERIAL_IMPRESSO','IN_MATERIAL_AUDIO','IN_MATERIAL_BRAILLE','IN_DISCIPLINA_LIBRAS','IN_GUIA_INTERPRETE','IN_MATERIAL_LIBRAS','IN_RECURSOS_COMUNICACAO','IN_RECURSOS_INFORMATICA','IN_TRADUTOR_LIBRAS','IN_INTEGRAL_CURSO','IN_MATUTINO_CURSO','IN_NOTURNO_CURSO','IN_VESPERTINO_CURSO','NU_PERC_CARGA_HOR_DISTANCIA','NU_INTEGRALIZACAO_MATUTINO','NU_INTEGRALIZACAO_VESPERTINO','NU_INTEGRALIZACAO_NOTURNO','NU_INTEGRALIZACAO_INTEGRAL','NU_INTEGRALIZACAO_EAD','IN_OFERECE_DISC_DISTANCIA','IN_POSSUI_LABORATORIO','QT_INSCRITOS_ANO_EAD','QT_VAGAS_ANUAL_EAD','QT_VAGAS_INTEGRAL_PRES','QT_VAGAS_MATUTINO_PRES','QT_VAGAS_VESPERTINO_PRES','QT_VAGAS_NOTURNO_PRES','QT_INSCRITOS_MATUTINO_PRES','QT_INSCRITOS_VESPERTINO_PRES','QT_INSCRITOS_NOTURNO_PRES','QT_INSCRITOS_INTEGRAL_PRES','QT_MATRICULA_CURSO','QT_CONCLUINTE_CURSO','QT_INGRESSO_CURSO','QT_INGRESSO_PROCESSO_SELETIVO','QT_INGRESSO_OUTRA_FORMA']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                    line[0:8],
                    line[8:208],
                    line[208:216],
                    line[216:316],
                    line[316:324],
                    line[324:424],
                    line[424:432],
                    line[432:582],
                    line[582:590],
                    line[590:592],
                    line[592:622],
                    line[622:630],
                    line[630:638],
                    line[638:838],
                    line[838:850],
                    line[850:970],
                    line[970:982],
                    line[982:1102],
                    line[1102:1114],
                    line[1114:1234],
                    line[1234:1246],
                    line[1246:1366],
                    line[1366:1374],
                    line[1374:1386],
                    line[1386:1394],
                    line[1394:1405],
                    line[1405:1413],
                    line[1413:1446],
                    line[1446:1454],
                    line[1454:1462],
                    line[1462:1470],
                    line[1470:1478],
                    line[1478:1516],
                    line[1516:1554],
                    line[1554:1562],
                    line[1562:1570],
                    line[1570:1578],
                    line[1578:1586],
                    line[1586:1594],
                    line[1594:1602],
                    line[1602:1610],
                    line[1610:1618],
                    line[1618:1626],
                    line[1626:1634],
                    line[1634:1642],
                    line[1642:1650],
                    line[1650:1658],
                    line[1658:1666],
                    line[1666:1674],
                    line[1674:1682],
                    line[1682:1690],
                    line[1690:1698],
                    line[1698:1706],
                    line[1706:1714],
                    line[1714:1722],
                    line[1722:1730],
                    line[1730:1738],
                    line[1738:1746],
                    line[1746:1754],
                    line[1754:1762],
                    line[1762:1770],
                    line[1770:1778],
                    line[1778:1786],
                    line[1786:1794],
                    line[1794:1802],
                    line[1802:1810],
                    line[1810:1818],
                    line[1818:1826],
                    line[1826:1834],
                    line[1834:1842],
                    line[1842:1850],
                    line[1850:1858],
                    line[1858:1866],
                    line[1866:1873]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()