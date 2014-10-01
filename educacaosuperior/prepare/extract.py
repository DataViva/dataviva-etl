from helpers import *

''' Extract CSV file by year'''
def extract(year):

    source_file = 'dados/importacao/raw/' + 'MDIC_' + str(year) + '.csv'
    export_file = 'dados/importacao/sent/' + str(year) + '_extract.csv'


    if year == 2009:

        # ALUNOS

        colsAlunos = ('CO_IES', 'CO_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'CO_CURSO', 'CO_VINCULO_ALUNO_CURSO', 'CO_ALUNOS', 'CO_ALUNO_SITUACAO', 'CO_GRAU_ACADEMICO', 'CO_MODALIDADE_ENSINO', 'CO_NIVEL_ACADEMICO', 'IN_MATRICULA', 'IN_CONCLUINTE', 'IN_INGRESSO', 'ANO_INGRESSO', 'DT_INGRESSO_CURSO', 'IN_SEXO_ALUNO', 'NU_IDADE_ALUNO', 'CO_COR_RACA_ALUNO')

        dfAlunos = read_from_csv(source_file, 1,"|", colsAlunos, None)

        df_to_csv(dfAlunos, export_file, None)

        print dfAlunos

        # CURSO

        colsCurso = ('CO_IES', 'CO_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'CO_NIVEL_ACADEMICO', 'CO_MODALIDADE_ENSINO', 'CO_GRAU_ACADEMICO', 'CO_CURSO', 'NO_CURSO',
            'CO_MUNICIPIO_CURSO', 'CO_OCDE_AREA_GERAL', 'NO_AREA_GERAL', 'CO_OCDE_AREA_ESPECIFICA', 'NO_AREA_ESPECIFICA', 'CO_OCDE_AREA_DETALHADA', 'NO_AREA_DETALHADA', 'CO_OCDE', 'NO_OCDE', 'IN_MATUTINO', 'IN_VESPERTINO', 'IN_NOTURNO', 'IN_INTEGRAL', 'QT_MATRICULA', 'QT_CONCLUINTE', 'QT_VAGAS_INTEGRAL', 'QT_VAGAS_MATUTINO', 'QT_VAGAS_NOTURNO', 'QT_VAGAS_VESPERTINO')

        dfCurso = read_from_csv(source_file, 1,"|", colsCurso, None)

        df_to_csv(dfCurso, export_file, None)

        print dfCurso




if __name__ == '__main__':
    extract(2011)
