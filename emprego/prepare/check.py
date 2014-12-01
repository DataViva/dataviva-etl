from helpers import *
import re
import os
""" Check data """

def check(year):

    if year == 2006:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        valRem = 0
        valInd = 0

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('IDENTIFICAD', 'MUNICIPIO', 'PIS', 'REM MED (R$)')


            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO', 'CAUSA DESLIG', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GRAU INSTR', 'GENERO', 'NACIONALIDAD', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NATUR JUR', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MEDIA', 'REM MED (R$)', 'REM DEZEMBRO', 'REM DEZ (R$)', 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT NASCIMENTO', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTAB ID', 'NOME', 'DIA DESLIG', 'OCUP 2002', 'CLAS CNAE 20', 'SB CLAS 20', 'TP DEFIC')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            SumRem = df['REM MED (R$)'].sum(axis=1)
            CountInd = df['IDENTIFICAD'].count()
            valRem = valRem + SumRem
            print valRem
            print '\n'
            valInd = valInd + CountInd
            print valInd
            print '\n'

        print 'Total REM' + str(valRem)
        print 'Total IDENTIFICAD' + str(valInd)


if __name__ == '__main__':
    start = time.time()
    check(2006)
    total_run_time = time.time() - start
    print "Total runtime: " + format_runtime(total_run_time)
