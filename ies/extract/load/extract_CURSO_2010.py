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
    dtype = {'CO_IES': numeric(8),'CO_CATEGORIA_ADMINISTRATIVA':numeric(8),'DS_CATEGORIA_ADMINISTRATIVA':String(50),'CO_ORGANIZACAO_ACADEMICA':numeric(8),'DS_ORGANIZACAO_ACADEMICA':String(100),'CO_MUNICIPIO':numeric(8),'CO_UF':numeric(8),'CO_CURSO':numeric(8),'NO_CURSO':String(200),'CO_OCDE':String(12),'NO_OCDE':String(120),'CO_OCDE_AREA_GERAL':numeric(8),'NO_AREA_GERAL':String(120),'CO_OCDE_AREA_ESPECIFICA':numeric(8),'NO_AREA_ESPECIFICA':String(120),'CO_OCDE_AREA_DETALHADA':numeric(8),'NO_AREA_DETALHADA':String(120),'CO_GRAU_ACADEMICO':numeric(8),'CO_MODALIDADE_ENSINO':numeric(8),'CO_NIVEL_ACADEMICO':numeric(8),'IN_GRATUITO':numeric(8),'TP_ATRIBUTO_INGRESSO':numeric(8),'CO_LOCAL_OFERTA_IES':numeric(8),'CO_MUNICIPIO':numeric(8),'CO_UF':numeric(8),'NU_CARGA_HORARIA':numeric(8),'DT_INICIO_FUNCIONAMENTO':datetime.date(),'IN_AJUDA_DEFICIENTE':numeric(8),'IN_MATERIAL_DIGITAL':numeric(8),'IN_MATERIAL_IMPRESSO':numeric(8),'IN_MATERIAL_AUDIO':numeric(8),'IN_MATERIAL_BRAILLE':numeric(8),'IN_DISCIPLINA_LIBRAS':numeric(8),'IN_GUIA_INTERPRETE':numeric(8),'IN_MATERIAL_LIBRAS':numeric(8),'IN_SINTESE_VOZ':numeric(8),'IN_TRADUTOR_LIBRAS':numeric(8),'IN_INTEGRAL_CURSO':numeric(8),'IN_MATUTINO_CURSO':numeric(8),'IN_NOTURNO_CURSO':numeric(8),'IN_VESPERTINO_CURSO':numeric(8),'NU_PERC_CARGA_HOR_DISTANCIA':numeric(8),'NU_INTEGRALIZACAO_MATUTINO':numeric(8),'NU_INTEGRALIZACAO_VESPERTINO':numeric(8),'NU_INTEGRALIZACAO_NOTURNO':numeric(8),'NU_INTEGRALIZACAO_INTEGRAL':numeric(8),'TP_MOTIVO_SEM_VINCULO':numeric(8),'CO_CURSO_REPRESENTADO':numeric(8),'IN_OFERECE_DISC_DISTANCIA':numeric(8),'IN_UTILIZA_LABORATORIO':numeric(8),'QT_INSCRITOS_ANO_EAD':numeric(8),'QT_VAGAS_ANUAL_EAD':numeric(8),'QT_VAGAS_INTEGRAL_PRES':numeric(8),'QT_VAGAS_MATUTINO_PRES':numeric(8),'QT_VAGAS_NOTURNO_PRES':numeric(8),'QT_VAGAS_VESPERTINO_PRES':numeric(8),'QT_INSCRITOS_MATUTINO_PRES':numeric(8),'QT_INSCRITOS_VESPERTINO_PRES':numeric(8),'QT_INSCRITOS_NOTURNO_PRES':numeric(8),'QT_INSCRITOS_INTEGRAL_PRES':numeric(8),'QT_MATRICULA_CURSO':numeric(8),'QT_CONCLUINTE_CURSO':numeric(8),'QT_INGRESSO_CURSO':numeric(8),'QT_INGRESSO_PROCESSO_SELETIVO':numeric(8),'QT_INGRESSO_OUTRA_FORMA':numeric(8)}
    columns = ['CO_IES','CO_CATEGORIA_ADMINISTRATIVA','DS_CATEGORIA_ADMINISTRATIVA','CO_ORGANIZACAO_ACADEMICA','DS_ORGANIZACAO_ACADEMICA','CO_MUNICIPIO','CO_UF','CO_CURSO','NO_CURSO','CO_OCDE','NO_OCDE','CO_OCDE_AREA_GERAL','NO_AREA_GERAL','CO_OCDE_AREA_ESPECIFICA','NO_AREA_ESPECIFICA','CO_OCDE_AREA_DETALHADA','NO_AREA_DETALHADA','CO_GRAU_ACADEMICO','CO_MODALIDADE_ENSINO','CO_NIVEL_ACADEMICO','IN_GRATUITO','TP_ATRIBUTO_INGRESSO','CO_LOCAL_OFERTA_IES','CO_MUNICIPIO','CO_UF','NU_CARGA_HORARIA','DT_INICIO_FUNCIONAMENTO','IN_AJUDA_DEFICIENTE','IN_MATERIAL_DIGITAL','IN_MATERIAL_IMPRESSO','IN_MATERIAL_AUDIO','IN_MATERIAL_BRAILLE','IN_DISCIPLINA_LIBRAS','IN_GUIA_INTERPRETE','IN_MATERIAL_LIBRAS','IN_SINTESE_VOZ','IN_TRADUTOR_LIBRAS','IN_INTEGRAL_CURSO','IN_MATUTINO_CURSO','IN_NOTURNO_CURSO','IN_VESPERTINO_CURSO','NU_PERC_CARGA_HOR_DISTANCIA','NU_INTEGRALIZACAO_MATUTINO','NU_INTEGRALIZACAO_VESPERTINO','NU_INTEGRALIZACAO_NOTURNO','NU_INTEGRALIZACAO_INTEGRAL','TP_MOTIVO_SEM_VINCULO','CO_CURSO_REPRESENTADO','IN_OFERECE_DISC_DISTANCIA','IN_UTILIZA_LABORATORIO','QT_INSCRITOS_ANO_EAD','QT_VAGAS_ANUAL_EAD','QT_VAGAS_INTEGRAL_PRES','QT_VAGAS_MATUTINO_PRES','QT_VAGAS_NOTURNO_PRES','QT_VAGAS_VESPERTINO_PRES','QT_INSCRITOS_MATUTINO_PRES','QT_INSCRITOS_VESPERTINO_PRES','QT_INSCRITOS_NOTURNO_PRES','QT_INSCRITOS_INTEGRAL_PRES','QT_MATRICULA_CURSO','QT_CONCLUINTE_CURSO','QT_INGRESSO_CURSO','QT_INGRESSO_PROCESSO_SELETIVO','QT_INGRESSO_OUTRA_FORMA']

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:7],
                line[8:15],
                line[16:115],
                line[116:123],
                line[124:223],
                line[224:231],
                line[232:239],
                line[240:247],
                line[248:447],
                line[448:459],
                line[460:579],
                line[580:591],
                line[592:711],
                line[712:723],
                line[724:843],
                line[844:855],
                line[856:975],
                line[976:983],
                line[984:991],
                line[992:999],
                line[1000:1007],
                line[1008:1015],
                line[1016:1023],
                line[1024:1031],
                line[1032:1041],
                line[1042:1049],
                line[1050:1057],
                line[1058:1065],
                line[1066:1073],
                line[1074:1081],
                line[1082:1089],
                line[1090:1097],
                line[1098:1105],
                line[1106:1113],
                line[1114:1121],
                line[1122:1129],
                line[1130:1137],
                line[1138:1145],
                line[1146:1153],
                line[1154:1161],
                line[1162:1169],
                line[1170:1177],
                line[1178:1185],
                line[1186:1193],
                line[1194:1201],
                line[1202:1209],
                line[1210:1217],
                line[1218:1225],
                line[1226:1233],
                line[1234:1241],
                line[1242:1249],
                line[1250:1257],
                line[1258:1265],
                line[1266:1273],
                line[1274:1281],
                line[1282:1289],
                line[1290:1297],
                line[1298:1305],
                line[1306:1313],
                line[1314:1321],
                line[1322:1329],
                line[1330:1337],
                line[1338:1345],
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