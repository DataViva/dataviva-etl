from helpers import *

''' Extract CSV file by year'''
def extract(year):

    files = {
            2002 : 'RAIS2002TOTAL',

        }

    source_file = 'dados/rais/raw/' + str(year) + '/' + files[year] + '.txt'
    export_file = 'dados/rais/sent/' + str(year) + '_extract.csv'



    if year == 2002:

        #MAP OCUPACAO
        cbo_file = 'docs/classificacao/CBO/Conversion_CBO94_CBO2002.csv'

        cols_cbo = ['CBO94', 'CBO2002']

        cbo = read_from_csv(cbo_file, 1, ';', cols_cbo, converters={"CBO94": str, "CBO2002": str})

        f = lambda x: cbo['CBO2002'][cbo.CBO94 == str(x)]


        cols = ('CAUSA DESLI', 'CAUSA DESLI_Fonte', 'OCUPACAO', 'OCUPACAO_desc', 'IND CEI VINC', 'CLAS CNAE 95', 'CLAS CNAE 95_Fonte', 'GRAU INSTR', 'GRAU INSTR_Fonte', 'HORAS CONTR', 'IDADE', 'IDENTIFICAD', 'IND PAT', 'IND PAT_Fonte', 'IND SIMPLES', 'IND SIMPLES_Fonte', 'MUNICIPIO', 'MUNICIPIO_Fonte', 'NACIONALIDAD', 'NACIONALIDAD_Fonte', 'NATUR JUR', 'NATUR JUR_Fonte', 'PIS', 'RACA_COR OR', 'RACA_COR OR_Fonte', 'RADIC CNPJ', 'REM DEZ (R$)', 'REM DEZEMBRO', 'REM MED (R$)', 'SUBS IBGE', 'SEXO', 'SEXO_Fonte', 'TAMESTAB', 'TAMESTAB_Fonte', 'TEMP EMPR', 'TIPO ADM', 'TIPO ADM_Fonte', 'TIPO ESTBL', 'TIPO ESTBL_Fonte', 'TP VINCL', 'DT NASCIMENT', 'MES DESLIG', 'MES DESLIG_Fonte', 'DT ADMISSAO' )

        useCols = ('OCUPACAO', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR OR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'SEXO_Fonte', 'TAMESTAB')

        df = read_from_csv(source_file, 1,"|", cols, None, useCols)
        df.apply(f)

        print df

        df_to_csv(df, export_file, None)


if __name__ == '__main__':
    start = time.time()
    extract(2002)
    total_run_time = time.time() - start
    print "Total runtime: " + format_runtime(total_run_time)
