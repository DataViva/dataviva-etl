import sys, click, codecs, time
from sqlalchemy.types import Numeric, String
from os.path import splitext, basename
from file_encoding import file_encoding
from df_to_sql import write_sql
from collections import OrderedDict

'''

USAGE EXAMPLE:
python ies/extract/load/extract_CURSO_2010.py ies/extract/data/IES_2010/CURSO.txt

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
    dtype = {'CO_IES': Numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':Numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(50),'CO_ORGANIZACAO_ACADEMICA':Numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO':Numeric(8),'CO_UF':Numeric(8),'CO_CURSO':Numeric(8),'NO_CURSO':String(200),'CO_OCDE':String(12),'NO_OCDE':String(120),'CO_OCDE_AREA_GERAL':Numeric(8),'NO_AREA_GERAL':String(120),'CO_OCDE_AREA_ESPECIFICA':Numeric(8),'NO_AREA_ESPECIFICA':String(120),'CO_OCDE_AREA_DETALHADA':Numeric(8),'NO_AREA_DETALHADA':String(120),'CO_GRAU_ACADEMICO':Numeric(8),'CO_MODALIDADE_ENSINO':Numeric(8),'CO_NIVEL_ACADEMICO':Numeric(8),'IN_GRATUITO':Numeric(8),'TP_ATRIBUTO_INGRESSO':Numeric(8),'CO_LOCAL_OFERTA_IES':Numeric(8),'CO_MUNICIPIO':Numeric(8),'CO_UF':Numeric(8),'NU_CARGA_HORARIA':Numeric(8),'DT_INICIO_FUNCIONAMENTO': String (38),'IN_AJUDA_DEFICIENTE':Numeric(8),'IN_MATERIAL_DIGITAL':Numeric(8),'IN_MATERIAL_IMPRESSO':Numeric(8),'IN_MATERIAL_AUDIO':Numeric(8),'IN_MATERIAL_BRAILLE':Numeric(8),'IN_DISCIPLINA_LIBRAS':Numeric(8),'IN_GUIA_INTERPRETE':Numeric(8),'IN_MATERIAL_LIBRAS':Numeric(8),'IN_SINTESE_VOZ':Numeric(8),'IN_TRADUTOR_LIBRAS':Numeric(8),'IN_INTEGRAL_CURSO':Numeric(8),'IN_MATUTINO_CURSO':Numeric(8),'IN_NOTURNO_CURSO':Numeric(8),'IN_VESPERTINO_CURSO':Numeric(8),'NU_PERC_CARGA_HOR_DISTANCIA':Numeric(8),'NU_INTEGRALIZACAO_MATUTINO':Numeric(8),'NU_INTEGRALIZACAO_VESPERTINO':Numeric(8),'NU_INTEGRALIZACAO_NOTURNO':Numeric(8),'NU_INTEGRALIZACAO_INTEGRAL':Numeric(8),'TP_MOTIVO_SEM_VINCULO':Numeric(8),'CO_CURSO_REPRESENTADO':Numeric(8),'IN_OFERECE_DISC_DISTANCIA':Numeric(8),'IN_UTILIZA_LABORATORIO':Numeric(8),'QT_INSCRITOS_ANO_EAD':Numeric(8),'QT_VAGAS_ANUAL_EAD':Numeric(8),'QT_VAGAS_INTEGRAL_PRES':Numeric(8),'QT_VAGAS_MATUTINO_PRES':Numeric(8),'QT_VAGAS_NOTURNO_PRES':Numeric(8),'QT_VAGAS_VESPERTINO_PRES':Numeric(8),'QT_INSCRITOS_MATUTINO_PRES':Numeric(8),'QT_INSCRITOS_VESPERTINO_PRES':Numeric(8),'QT_INSCRITOS_NOTURNO_PRES':Numeric(8),'QT_INSCRITOS_INTEGRAL_PRES':Numeric(8),'QT_MATRICULA_CURSO':Numeric(8),'QT_CONCLUINTE_CURSO':Numeric(8),'QT_INGRESSO_CURSO':Numeric(8),'QT_INGRESSO_PROCESSO_SELETIVO':Numeric(8),'QT_INGRESSO_OUTRA_FORMA':Numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO','CO_UF','CO_CURSO','NO_CURSO','CO_OCDE','NO_OCDE','CO_OCDE_AREA_GERAL','NO_AREA_GERAL','CO_OCDE_AREA_ESPECIFICA','NO_AREA_ESPECIFICA','CO_OCDE_AREA_DETALHADA','NO_AREA_DETALHADA','CO_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','IN_GRATUITO','TP_ATRIBUTO_INGRESSO','CO_LOCAL_OFERTA_IES','CO_MUNICIPIO','CO_UF','NU_CARGA_HORARIA','DT_INICIO_FUNCIONAMENTO','IN_AJUDA_DEFICIENTE','IN_MATERIAL_DIGITAL','IN_MATERIAL_IMPRESSO','IN_MATERIAL_AUDIO','IN_MATERIAL_BRAILLE','IN_DISCIPLINA_LIBRAS','IN_GUIA_INTERPRETE','IN_MATERIAL_LIBRAS','IN_SINTESE_VOZ','IN_TRADUTOR_LIBRAS','IN_INTEGRAL_CURSO','IN_MATUTINO_CURSO','IN_NOTURNO_CURSO','IN_VESPERTINO_CURSO','NU_PERC_CARGA_HOR_DISTANCIA','NU_INTEGRALIZACAO_MATUTINO','NU_INTEGRALIZACAO_VESPERTINO','NU_INTEGRALIZACAO_NOTURNO','NU_INTEGRALIZACAO_INTEGRAL','TP_MOTIVO_SEM_VINCULO','CO_CURSO_REPRESENTADO','IN_OFERECE_DISC_DISTANCIA','IN_UTILIZA_LABORATORIO','QT_INSCRITOS_ANO_EAD','QT_VAGAS_ANUAL_EAD','QT_VAGAS_INTEGRAL_PRES','QT_VAGAS_MATUTINO_PRES','QT_VAGAS_NOTURNO_PRES','QT_VAGAS_VESPERTINO_PRES','QT_INSCRITOS_MATUTINO_PRES','QT_INSCRITOS_VESPERTINO_PRES','QT_INSCRITOS_NOTURNO_PRES','QT_INSCRITOS_INTEGRAL_PRES','QT_MATRICULA_CURSO','QT_CONCLUINTE_CURSO','QT_INGRESSO_CURSO','QT_INGRESSO_PROCESSO_SELETIVO','QT_INGRESSO_OUTRA_FORMA']

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
                line[248:448],
                line[448:460],
                line[460:580],
                line[580:592],
                line[592:712],
                line[712:724],
                line[724:844],
                line[844:856],
                line[856:976],
                line[976:984],
                line[984:992],
                line[992:1000],
                line[1000:1008],
                line[1008:1016],
                line[1016:1024],
                line[1024:1032],
                line[1032:1042],
                line[1042:1050],
                line[1050:1058],
                line[1058:1066],
                line[1066:1074],
                line[1074:1082],
                line[1082:1090],
                line[1090:1098],
                line[1098:1106],
                line[1106:1114],
                line[1114:1122],
                line[1122:1130],
                line[1130:1138],
                line[1138:1146],
                line[1146:1154],
                line[1154:1162],
                line[1162:1170],
                line[1170:1178],
                line[1178:1186],
                line[1186:1194],
                line[1194:1202],
                line[1202:1210],
                line[1210:1218],
                line[1218:1226],
                line[1226:1234],
                line[1234:1242],
                line[1242:1250],
                line[1250:1258],
                line[1258:1266],
                line[1266:1274],
                line[1274:1282],
                line[1282:1290],
                line[1290:1298],
                line[1298:1306],
                line[1306:1314],
                line[1314:1322],
                line[1322:1330],
                line[1330:1338],
                line[1338:1346],
                line[1346:1354],
                line[1354:1402]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

    chuncksize = 100
    if_exists = 'replace'
    write_sql(table, tuples, columns, if_exists, chuncksize, dtype)

    print "::: %s minutes :::" % str((time.time() - start)/60)

if __name__ == "__main__":
    main()