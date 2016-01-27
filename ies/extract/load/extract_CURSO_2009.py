import sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql
from collections import OrderedDict

'''

USAGE EXAMPLE:
python ies/extract/load/extract_CURSO_2009.py ies/extract/data/IES_2009/CURSO.txt

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
    dtype = {'CO_IES' : String(8), 'CO_UNIDADE_FUNCIONAMENTO' : String(8), 'CO_CATEGORIA_ADMINISTRATIVA' : String(8), 'DS_CATEGORIA_ADMINISTRATIVA' : String(50), 'CO_ORGANIZACAO_ACADEMICA' : String(8), 'NO_ORGANIZACAO_ACADEMICA' : String(100), 'CO_NIVEL_ACADEMICO' : String(8), 'CO_MODALIDADE_ENSINO' : String(8), 'CO_GRAU_ACADEMICO' : String(8), 'CO_CURSO' : String (8), 'NO_CURSO' : String(200), 'CO_MUNICIPIO_CURSO' : String(120), 'NO_MUNICIPIO_CURSO' : String(120), 'CO_UF_CURSO' : String(120), 'NO_REGIAO_CURSO' : String(120), 'CO_OCDE_AREA_GERAL' : String(8), 'NO_AREA_GERAL' : String(120), 'CO_OCDE_AREA_ESPECIFICA' : String(8), 'NO_AREA_ESPECIFICA' : String(120), 'CO_OCDE_AREA_DETALHADA' : String(8), 'NO_AREA_DETALHADA' : String(120), 'CO_OCDE' : String(12), 'NO_OCDE' : String(120), 'IN_MATUTINO' : Numeric(8) , 'IN_VESPERTINO' : Numeric(8), 'IN_NOTURNO' : Numeric(8), 'IN_INTEGRAL' : Numeric(8), 'QT_MATRICULA' : Numeric(8), 'QT_CONCLUINTE' : Numeric(8), 'QT_INSCRITOS_ANO' : Numeric(8), 'QT_VAGAS_INTEGRAL' : Numeric(8), 'QT_VAGAS_MATUTINO' : Numeric(8), 'QT_VAGAS_NOTURNO' : Numeric(8), 'QT_VAGAS_VESPERTINO' : Numeric(8), 'QT_INGRESSO_CURSO' : Numeric(8), 'QT_PROCESSO_SELETIVO' : Numeric(8), 'IN_ENEM' : Numeric(8), 'IN_VESTIBULAR' : Numeric(8), 'IN_OUTRA_FORMA_SELECAO' : Numeric(8), 'QT_PROCESSO_OUTRA_FORMA' : Numeric(8), 'IN_CONVENIO_PEC_G' : Numeric(8), 'IN_OUTRAS_FORMAS_INGRESSO' : Numeric(8), 'NU_CARGA_HORARIA' : Numeric(8), 'NU_PRAZO_INTEGRALIZACAO' : Numeric(8), 'IN_PERMITE_CONCLUINTE' : Numeric(8), 'IN_UTILIZA_LABORATORIO' : Numeric(8), 'IN_AJUDA_DEFICIENTE' : Numeric(8), 'IN_ALTO_RELEVO' : Numeric(8), 'IN_BRAILLE' : Numeric(8), 'IN_CARACTER_AMPLIADO' : Numeric(8), 'IN_GUIA_INTERPRETE' : Numeric(8), 'IN_TRADUTOR_LIBRAS' : Numeric(8), 'IN_AUDIO' : Numeric(8), 'IN_DISCIPLINA_LIBRAS' : Numeric(8), 'IN_MATERIAL_LIBRAS' : Numeric(8), 'IN_SINTESE_VOZ' : Numeric(8), 'IN_OFERECE_DISC_DISTANCIA' : Numeric(8), 'IN_PARTICIPA_UAB' : Numeric(8), 'NU_PERC_CARGA_HOR_DISTANCIA' : Numeric(8)}
    columns = ['CO_IES', 'CO_UNIDADE_FUNCIONAMENTO', 'CO_CATEGORIA_ADMINISTRATIVA', 'DS_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'NO_ORGANIZACAO_ACADEMICA', 'CO_NIVEL_ACADEMICO', 'CO_MODALIDADE_ENSINO', 'CO_GRAU_ACADEMICO', 'CO_CURSO', 'NO_CURSO', 'CO_MUNICIPIO_CURSO', 'NO_MUNICIPIO_CURSO', 'CO_UF_CURSO', 'NO_REGIAO_CURSO', 'CO_OCDE_AREA_GERAL', 'NO_AREA_GERAL', 'CO_OCDE_AREA_ESPECIFICA', 'NO_AREA_ESPECIFICA', 'CO_OCDE_AREA_DETALHADA', 'NO_AREA_DETALHADA', 'CO_OCDE', 'NO_OCDE', 'IN_MATUTINO' , 'IN_VESPERTINO', 'IN_NOTURNO', 'IN_INTEGRAL', 'QT_MATRICULA', 'QT_CONCLUINTE', 'QT_INSCRITOS_ANO', 'QT_VAGAS_INTEGRAL', 'QT_VAGAS_MATUTINO', 'QT_VAGAS_NOTURNO', 'QT_VAGAS_VESPERTINO', 'QT_INGRESSO_CURSO', 'QT_PROCESSO_SELETIVO', 'IN_ENEM', 'IN_VESTIBULAR', 'IN_OUTRA_FORMA_SELECAO', 'QT_PROCESSO_OUTRA_FORMA', 'IN_CONVENIO_PEC_G', 'IN_OUTRAS_FORMAS_INGRESSO', 'NU_CARGA_HORARIA', 'NU_PRAZO_INTEGRALIZACAO', 'IN_PERMITE_CONCLUINTE', 'IN_UTILIZA_LABORATORIO', 'IN_AJUDA_DEFICIENTE', 'IN_ALTO_RELEVO', 'IN_BRAILLE', 'IN_CARACTER_AMPLIADO', 'IN_GUIA_INTERPRETE', 'IN_TRADUTOR_LIBRAS', 'IN_AUDIO', 'IN_DISCIPLINA_LIBRAS', 'IN_MATERIAL_LIBRAS', 'IN_SINTESE_VOZ', 'IN_OFERECE_DISC_DISTANCIA', 'IN_PARTICIPA_UAB', 'NU_PERC_CARGA_HOR_DISTANCIA']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:8],
                line[8:16],
                line[16:24],
                line[24:74],
                line[74:82],
                line[82:182],
                line[182:190],
                line[190:198],
                line[198:206],
                line[206:214],
                line[214:414],
                line[414:534],
                line[534:654],
                line[654:774],
                line[774:894],
                line[894:902],
                line[902:1022],
                line[1022:1030],
                line[1030:1150],
                line[1150:1158],
                line[1158:1278],
                line[1278:1290],
                line[1290:1410],
                line[1410:1418],
                line[1418:1426],
                line[1426:1434],
                line[1434:1442],
                line[1442:1450],
                line[1450:1458],
                line[1458:1466],
                line[1466:1474],
                line[1474:1482],
                line[1482:1490],
                line[1490:1498],
                line[1498:1506],
                line[1506:1514],
                line[1514:1522],
                line[1522:1530],
                line[1530:1538],
                line[1538:1546],
                line[1546:1554],
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
                line[1690:1698]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "--- %s minutes ---" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()