from helpers import *
import re
import os

COLS_2002 =  ('CAUSA DESLI', 'CAUSA DESLI_Fonte', 'OCUPACAO', 'OCUPACAO_desc', 'IND CEI VINC', 'CLAS CNAE 95', 'CLAS CNAE 95_Fonte', 'GRAU INSTR', 'GRAU INSTR_Fonte', 'HORAS CONTR', 'IDADE', 'IDENTIFICAD', 'IND PAT', 'IND PAT_Fonte', 'IND SIMPLES', 'IND SIMPLES_Fonte', 'MUNICIPIO', 'MUNICIPIO_Fonte', 'NACIONALIDAD', 'NACIONALIDAD_Fonte', 'NATUR JUR', 'NATUR JUR_Fonte', 'PIS', 'RACA_COR OR', 'RACA_COR OR_Fonte', 'RADIC CNPJ', 'REM DEZ (R$)', 'REM DEZEMBRO', 'REM MED (R$)', 'SUBS IBGE', 'SEXO', 'SEXO_Fonte', 'TAMESTAB', 'TAMESTAB_Fonte', 'TEMP EMPR', 'TIPO ADM', 'TIPO ADM_Fonte', 'TIPO ESTBL', 'TIPO ESTBL_Fonte', 'TP VINCL', 'DT NASCIMENT', 'MES DESLIG', 'MES DESLIG_Fonte', 'DT ADMISSAO' )

COLS_2003 = ('CAUSA DESLIG', 'CAUSA DESLIG_Fonte', 'CBO 2002', 'CB0 2002_fonte', 'CEI VINC', 'CLAS CNAE 95', 'CLAS CNAE 95_Fonte', 'EMP  EM 31/12', 'EMP EM 31/12_Fonte', 'GRAU INSTR', 'GRAU INSTR_Fonte', 'HORAS CONTR', 'IDADE', 'IDENTIFICAD', 'IND CEI VINC', 'IND CEI VINC_Fonte', 'IND PAT', 'IND PAT_Fonte', 'IND SIMPLES', 'IND SIMPLES_Fonte', 'MUNICIPIO', 'MUNICIPIO_Fonte', 'NACIONALIDAD', 'NACIONALIDAD_Fonte', 'NATUR JUR', 'NATUR JUR_Fonte', 'PIS', 'RACA_COR', 'RACA_COR_Fonte', 'RADIC CNPJ', 'REM DEZ (R$)', 'REM DEZEMBRO', 'REM MED (R$)', 'REM MEDIA', 'SUBS IBGE', 'SEXO', 'SEXO_Fonte', 'TAMESTAB', 'TAMESTAB_Fonte', 'TEMP EMPR', 'TIPO ADM', 'TIPO ADM_Fonte', 'TIPO ESTBL', 'TIPO ESTBL_Fonte', 'TP VINCULO', 'TP VINCULO_Fonte', 'DT NASCIMENT', 'DT_ADMISSAO', 'MES DESLIG', 'MES DESLIG_Fonte')


""" Extract CSV file by year """
def extract(year):



    """ Convert CBO094 to CBO2002 """
    if year == 2002:

        files = {
            2002 : 'RAIS2002TOTAL_CORTE',

        }

        source_file = 'dados/rais/raw/' + str(year) + '/' + files[year] + '.txt'
        export_file = 'dados/rais/sent/' + str(year) + '_extractCORTE.csv'



        """CBO CONVERSION"""
        cbo_file = 'docs/classificacao/CBO/Conversion_CBO94_CBO2002.csv'

        cols_cbo = ['CBO94', 'CBO2002']

        cbo = read_from_csv(cbo_file, 1, ';', cols_cbo)

        """MapIgnorado"""
        cbo['CBO94'] [cbo['CBO94'] == "IGNORADO"]= '-1'


        def convert(row):
            return int(row['CBO94'])

        def convert2(row):
            return int(row['CBO2002'])

        cbo['CB0094'] = cbo.apply(convert, axis=1)
        cbo['CBO2002'] = cbo.apply(convert2, axis=1)

        def cboConversion(row):
            converted = cbo['CBO2002'][cbo['CB0094'] == row['OCUPACAO']]
            if len(converted) > 1:
                converted = converted.head(1)

            return to_int(converted)

        """CNAE CONVERSION"""

        cnae_file = 'docs/classificacao/CNAE/CNAE20_Correspondencia10x20.csv'

        cols_cnae = ['CNAE 10', 'CNAE 20']

        cnae = read_from_csv(cnae_file, 1, ';', cols_cnae)

        def cnaeConversion(row):
            converted = cnae['CNAE 20'][cnae['CNAE 10'] == row['CLAS CNAE 95_Fonte']]
            if len(converted) > 1:
                converted = converted.head(1)

            return to_int(converted)

        def cnaeConversion(row):
            converted = cnae['CNAE 20'][cnae['CNAE 10'] == row['CLAS CNAE 95_Fonte']]
            if len(converted) > 1:
                converted = converted.head(1)

            return to_int(converted)

        useCols = ('ID',  'OCUPACAO', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR OR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'SEXO_Fonte', 'TAMESTAB_Fonte')

        df = read_from_csv(source_file, 2,"|", COLS_2002, None, useCols)

        def toString(row):
            return str(row['SEXO_Fonte'])

        df['SEXO_Fonte'] = df.apply(toString, axis=1)

        """MapGenero"""
        df['SEXO_Fonte'] [df['SEXO_Fonte'] == "MASCULINO"]= 1
        df['SEXO_Fonte'] [df['SEXO_Fonte'] == "FEMININO"]= 0
        df['SEXO_Fonte'] [df['SEXO_Fonte'] == "2" ]= 0
        df['SEXO_Fonte'] [df['SEXO_Fonte'] == "02" ]= 0
        df['SEXO_Fonte'] [df['SEXO_Fonte'] == "01" ]= 1

        """ remove string from field ocupacao"""
        def toIntCBO(row):
            cbo_digit = re.findall('\d+', row['OCUPACAO'])
            return str(cbo_digit[0])

        df['OCUPACAO'] [df['OCUPACAO'] == "0000-1"]= '-1'
        df['OCUPACAO'] = df.apply(toIntCBO, axis=1)

        df['OCUPACAO'] = df.apply(lambda f : to_number(f['OCUPACAO']) , axis = 1)

        df['OCUPACAO'] = df.apply(cboConversion, axis=1)

        df['CLAS CNAE 95_Fonte'] = df.apply(cnaeConversion, axis=1)

        df_to_csv(df, export_file, None)

    elif year > 2002 and year < 2005:
    """ Maps: CNAE, MapGenero """

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'SEXO_Fonte', 'TAMESTAB_Fonte')

            df = read_from_csv(source_file, 2,"|", COLS_2003, None, useCols)

            """ CNAE CONVERSION """
            def cnaeConversion(row):
                converted = cnae['CNAE 20'][cnae['CNAE 10'] == row['CLAS CNAE 95_Fonte']]
                if len(converted) > 1:
                    converted = converted.head(1)

            def toString(row):
                return str(row['SEXO_Fonte'])

            df['SEXO_Fonte'] = df.apply(toString, axis=1)

            """MapGenero"""
            df['SEXO_Fonte'] [df['SEXO_Fonte'] == "MASCULINO"]= 1
            df['SEXO_Fonte'] [df['SEXO_Fonte'] == "FEMININO"]= 0
            df['SEXO_Fonte'] [df['SEXO_Fonte'] == "2" ]= 0
            df['SEXO_Fonte'] [df['SEXO_Fonte'] == "02" ]= 0
            df['SEXO_Fonte'] [df['SEXO_Fonte'] == "01" ]= 1

            df['CLAS CNAE 95_Fonte'] = df.apply(cnaeConversion, axis=1)


            df_to_csv(df, export_file, None)

if __name__ == '__main__':
    start = time.time()
    extract(2003)
    total_run_time = time.time() - start
    print "Total runtime: " + format_runtime(total_run_time)
