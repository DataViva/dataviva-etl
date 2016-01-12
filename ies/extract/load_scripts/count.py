# -*- coding: utf-8 -*-
import sys, os, click, MySQLdb, magic, codecs, re, time
from os.path import splitext, basename

'''

USAGE EXAMPLE:
python count.py data/CURSO.txt

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    file_name = basename(file_path)
    table, file_ext = splitext(file_name)

    start = time.time()

    # Discover encoding type of file
    blob = open(file_path).read()
    m = magic.Magic(mime_encoding=True)
    encoding = m.from_buffer(blob)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    numero_de_linhas = 0

    tuples = []
    columns = []

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row_data = {
                'CO_IES' : line[0:8],
                'CO_UNIDADE_FUNCIONAMENTO' : line[8:16],
                'CO_CATEGORIA_ADMINISTRATIVA' : line[16:24],
                'DS_CATEGORIA_ADMINISTRATIVA' : line[24:74],
                'CO_ORGANIZACAO_ACADEMICA' : line[74:82],
                'NO_ORGANIZACAO_ACADEMICA' : line[82:182],
                'CO_NIVEL_ACADEMICO' : line[182:190],
                'CO_MODALIDADE_ENSINO' : line[190:198],
                'CO_GRAU_ACADEMICO' : line[198:206],
                'CO_CURSO' : line[206:214],
                'NO_CURSO' : line[214:414],
                'CO_MUNICIPIO_CURSO' : line[414:534],
                'NO_MUNICIPIO_CURSO' : line[534:654],
                'CO_UF_CURSO' : line[654:774],
                'NO_REGIAO_CURSO' : line[774:894],
                'CO_OCDE_AREA_GERAL' : line[894:902],
                'NO_AREA_GERAL' : line[902:1022],
                'CO_OCDE_AREA_ESPECIFICA' : line[1022:1030],
                'NO_AREA_ESPECIFICA' : line[1030:1150],
                'CO_OCDE_AREA_DETALHADA' : line[1150:1158],
                'NO_AREA_DETALHADA' : line[1158:1278],
                'CO_OCDE' : line[1278:1290],
                'NO_OCDE' : line[1290:1410],
                'IN_MATUTINO' : line[1410:1418],
                'IN_VESPERTINO' : line[1418:1426],
                'IN_NOTURNO' : line[1426:1434],
                'IN_INTEGRAL' : line[1434:1442],
                'QT_MATRICULA' : line[1442:1450],
                'QT_CONCLUINTE' : line[1450:1458],
                'QT_INSCRITOS_ANO' : line[1458:1466],
                'QT_VAGAS_INTEGRAL' : line[1466:1474],
                'QT_VAGAS_MATUTINO' : line[1474:1482],
                'QT_VAGAS_NOTURNO' : line[1482:1490],
                'QT_VAGAS_VESPERTINO' : line[1490:1498],
                'QT_INGRESSO_CURSO' : line[1498:1506],
                'QT_PROCESSO_SELETIVO' : line[1506:1514],
                'IN_ENEM' : line[1514:1522],
                'IN_VESTIBULAR' : line[1522:1530],
                'IN_OUTRA_FORMA_SELECAO' : line[1530:1538],
                'QT_PROCESSO_OUTRA_FORMA' : line[1538:1546],
                'IN_CONVENIO_PEC_G' : line[1546:1554],
                'IN_OUTRAS_FORMAS_INGRESSO' : line[1554:1562],
                'NU_CARGA_HORARIA' : line[1562:1570],
                'NU_PRAZO_INTEGRALIZACAO' : line[1570:1578],
                'IN_PERMITE_CONCLUINTE' : line[1578:1586],
                'IN_UTILIZA_LABORATORIO' : line[1586:1594],
                'IN_AJUDA_DEFICIENTE' : line[1594:1602],
                'IN_ALTO_RELEVO' : line[1602:1610],
                'IN_BRAILLE' : line[1610:1618],
                'IN_CARACTER_AMPLIADO' : line[1618:1626],
                'IN_GUIA_INTERPRETE' : line[1626:1634],
                'IN_TRADUTOR_LIBRAS' : line[1634:1642],
                'IN_AUDIO' : line[1642:1650],
                'IN_DISCIPLINA_LIBRAS' : line[1650:1658],
                'IN_MATERIAL_LIBRAS' : line[1658:1666],
                'IN_SINTESE_VOZ' : line[1666:1674],
                'IN_OFERECE_DISC_DISTANCIA' : line[1674:1682],
                'IN_PARTICIPA_UAB' : line[1682:1690],
                'NU_PERC_CARGA_HOR_DISTANCIA' : line[1690:1698],
            }

            if len(columns) < 1:
                columns = [key for key in row_data.keys()]

            tuples.append(tuple([None if not str(x).strip() else x for x in row_data.values()]))


    cursor = connection.cursor()

    query = 'INSERT INTO ' + table + ' ('+','.join(columns)+')'
    query += 'VALUES (' + ('%s, ' * (len(columns) - 1) + '%s')+')'

    cursor.executemany(query, tuples)
    connection.commit()
    connection.close()

    print 'São %s linhas' % numero_de_linhas
    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()