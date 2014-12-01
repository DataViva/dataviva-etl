from helpers import *
import re
import os
""" Apply Map 'MapRetiraMilitares' to ocupation"""


def mapRetiraMilitares(df, header):

    df[header] [df[header] == "010105"]= '-1'
    df[header] [df[header] == "010110"]= '-1'
    df[header] [df[header] == "010115"]= '-1'
    df[header] [df[header] == "010205"]= '-1'
    df[header] [df[header] == "010210"]= '-1'
    df[header] [df[header] == "010215"]= '-1'
    df[header] [df[header] == "010305"]= '-1'
    df[header] [df[header] == "010315"]= '-1'
    df[header] [df[header] == "010310"]= '-1'
    df[header] [df[header] == "020105"]= '-1'
    df[header] [df[header] == "020115"]= '-1'
    df[header] [df[header] == "020110"]= '-1'
    df[header] [df[header] == "020205"]= '-1'
    df[header] [df[header] == "020305"]= '-1'
    df[header] [df[header] == "020310"]= '-1'
    df[header] [df[header] == "021110"]= '-1'
    df[header] [df[header] == "021105"]= '-1'
    df[header] [df[header] == "021205"]= '-1'
    df[header] [df[header] == "021210"]= '-1'
    df[header] [df[header] == "030110"]= '-1'
    df[header] [df[header] == "030105"]= '-1'
    df[header] [df[header] == "030115"]= '-1'
    df[header] [df[header] == "030205"]= '-1'
    df[header] [df[header] == "030305"]= '-1'
    df[header] [df[header] == "031105"]= '-1'
    df[header] [df[header] == "031110"]= '-1'
    df[header] [df[header] == "031205"]= '-1'
    df[header] [df[header] == "031210"]= '-1'
    df[header] [df[header] == "519805"]= '-1'


""" Extract CSV file by year """
def transform(year):

    if year == 2002:

        source_file = 'dados/rais/raw/' + str(year) + '/' + 'RAIS2002TOTAL_CORTE' + '.txt'

        cols =  ('CAUSA DESLI', 'CAUSA DESLI_Fonte', 'OCUPACAO', 'OCUPACAO_desc', 'IND CEI VINC', 'CLAS CNAE 95', 'CLAS CNAE 95_Fonte', 'GRAU INSTR', 'GRAU INSTR_Fonte', 'HORAS CONTR', 'IDADE', 'IDENTIFICAD', 'IND PAT', 'IND PAT_Fonte', 'IND SIMPLES', 'IND SIMPLES_Fonte', 'MUNICIPIO', 'MUNICIPIO_Fonte', 'NACIONALIDAD', 'NACIONALIDAD_Fonte', 'NATUR JUR', 'NATUR JUR_Fonte', 'PIS', 'RACA_COR OR', 'RACA_COR OR_Fonte', 'RADIC CNPJ', 'REM DEZ (R$)', 'REM DEZEMBRO', 'REM MED (R$)', 'SUBS IBGE', 'SEXO', 'SEXO_Fonte', 'TAMESTAB', 'TAMESTAB_Fonte', 'TEMP EMPR', 'TIPO ADM', 'TIPO ADM_Fonte', 'TIPO ESTBL', 'TIPO ESTBL_Fonte', 'TP VINCL', 'DT NASCIMENT', 'MES DESLIG', 'MES DESLIG_Fonte', 'DT ADMISSAO' )

        useCols = ('OCUPACAO', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR OR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'SEXO_Fonte', 'TAMESTAB_Fonte')

        separator = "|"

        df = read_from_csv(source_file, 1, separator, cols, None, useCols)

        # MapRetiraMilitares
        mapRetiraMilitares(df, 'OCUPACAO')

        export_file = 'dados/rais/sent/' + str(year) + '_extractCORTE.csv'

        df_to_csv(df, export_file, None)

    elif year == 2003:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'SEXO_Fonte', 'TAMESTAB_Fonte')

            cols = ('CAUSA DESLIG', 'CAUSA DESLIG_Fonte', 'CBO 2002', 'CB0 2002_fonte', 'CEI VINC', 'CLAS CNAE 95', 'CLAS CNAE 95_Fonte', 'EMP  EM 31/12', 'EMP EM 31/12_Fonte', 'GRAU INSTR', 'GRAU INSTR_Fonte', 'HORAS CONTR', 'IDADE', 'IDENTIFICAD', 'IND CEI VINC', 'IND CEI VINC_Fonte', 'IND PAT', 'IND PAT_Fonte', 'IND SIMPLES', 'IND SIMPLES_Fonte', 'MUNICIPIO', 'MUNICIPIO_Fonte', 'NACIONALIDAD', 'NACIONALIDAD_Fonte', 'NATUR JUR', 'NATUR JUR_Fonte', 'PIS', 'RACA_COR', 'RACA_COR_Fonte', 'RADIC CNPJ', 'REM DEZ (R$)', 'REM DEZEMBRO', 'REM MED (R$)', 'REM MEDIA', 'SUBS IBGE', 'SEXO', 'SEXO_Fonte', 'TAMESTAB', 'TAMESTAB_Fonte', 'TEMP EMPR', 'TIPO ADM', 'TIPO ADM_Fonte', 'TIPO ESTBL', 'TIPO ESTBL_Fonte', 'TP VINCULO', 'TP VINCULO_Fonte', 'DT NASCIMENT', 'DT_ADMISSAO', 'MES DESLIG', 'MES DESLIG_Fonte')


            df = read_from_csv(source_file, 2,"|", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            export_file = 'dados/rais/sent/' + str(year) + '_extract.csv'

            df_to_csv(df, export_file, None)


    elif year == 2004:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'SEXO_Fonte', 'TAMESTAB_Fonte')

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO', 'CAUSA DESLIG', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GRAU INSTR', 'SEXO', 'NACIONALIDAD', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NATUR JUR', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MED ($)', 'REM DEZ ($)', 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT NASCIMENT', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTB ID', 'NOME', 'DIA DESL', 'OCUP 2002')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            export_file = 'dados/rais/sent/' + str(year) + '_extract.csv'

            df_to_csv(df, export_file, None)

    elif year == 2005:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'GENERO', 'TAMESTAB_Fonte')

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO', 'CAUSA DESLIG', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GRAU INSTR', 'GENERO', 'NACIONALIDAD', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NATUR JUR', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MEDIA', 'REM MED ($)', 'REM DEZEMBRO', 'REM DEZ (R$)' 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT NASCIMENT', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTB ID', 'NOME', 'DIA DESL', 'OCUP 2002')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            df_to_csv(df, export_file, None)

    elif year == 2006:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 95_Fonte', 'GRAU INSTR_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'GENERO', 'TAMESTAB_Fonte')

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO', 'CAUSA DESLIG', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GRAU INSTR', 'GENERO', 'NACIONALIDAD', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NATUR JUR', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MEDIA', 'REM MED (R$)', 'REM DEZEMBRO', 'REM DEZ (R$)', 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT NASCIMENTO', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTAB ID', 'NOME', 'DIA DESLIG', 'OCUP 2002', 'CLAS CNAE 20', 'SB CLAS 20', 'TP DEFIC')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            df_to_csv(df, export_file, None)

    elif year == 2007:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO', 'CAUSA DESLI', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GR INSTRUCAO', 'GENERO', 'NACIONALIDAD', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NATUR JUR', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM DEZ (R$)', 'REM DEZEMBRO', 'REM MED (R$)', 'REM MEDIA', 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT_NASCIMENT', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTB ID', 'NOME',  'OCUP 2002', 'CLAS CNAE 20', 'SB CLAS 20', 'TP DEFIC', 'CAU AFAST 1', 'DIA INI AF 1', 'DIA INI AF 1', 'MES INI AF 1', 'DIA FIM AF 1', 'MES FIM AF 1', 'CAUS AFAST 2', 'DIA INI AF 2', 'MES INI AF 2', 'DIA FIM AF 2', 'MES FIM AF 2', 'CAUS AFAST 3', 'DIA INI AF 3', 'MES INI AF 3', 'DIA FIM AF 3', 'MES FIM AF 3', 'QT DIAS AFAS', 'IDADE')

            useCols = ('OCUP 2002', 'CLAS CNAE 20', 'GR INSTRUCAO', 'EMP EM 31/12', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR_Fonte', 'REM DEZ (R$)', 'REM MED (R$)', 'GENERO', 'TAMESTAB_Fonte')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'OCUP 2002')

            df_to_csv(df, export_file, None)

    elif year == 2008:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 20_Fonte', 'GR INSTRUCAO_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR', 'REM DEZ (R$)', 'REM MED (R$), GENERO', 'TAMESTAB_Fonte' )

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO', 'CAUSA DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GRAU INSTR', 'GENERO', 'NACIONALIDAD', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NAT JURIDICA', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MEDIA', 'REM MED (R$)', 'REM DEZEMBRO', 'REM DEZ (R$)', 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT NASCIMENT', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTB ID', 'NOME', 'DIA DESL', 'OCUP 2002', 'CLAS CNAE 20', 'SB CLAS 20', 'TP DEFIC', 'CAUS AFAST 1', 'DIA INI AF 1', 'MES INI AF 1', 'DIA FIM AF 1', 'MES FIM AF 1', 'CAUS AFAST 2', 'DIA INI AF 2', 'MES INI AF 2', 'DIM FIM AF 2', 'MES FIM AF 2', 'CAUS AFAST 3', 'DIA INI AF 3', 'MES INI AF 3', 'DIA FIM AF 3', 'MES FIM AF 3', 'QT DIAS AFAS')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            df_to_csv(df, export_file, None)

    elif year == 2009:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 20_Fonte', 'GR INSTRUCAO_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR', 'REM DEZ (R$)', 'REM MED (R$), GENERO', 'TAMESTAB_Fonte' )

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO','CAUSA DESLIG', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GR INSTRUCAO', 'GENERO', 'NACIONALIDADE', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NAT JURIDICA', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MEDIA', 'REM MED (R$)', 'REM DEZEMBRO', 'REM DEZ (R$)', 'TEMP EMPREG', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'PIS', 'DT NASCIMENT', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTB ID', 'NOME', 'DIA DESL', 'OCUP 2002', 'CLAS CNAE 20', 'SB CLAS 20', 'TP DEFIC', 'CAU AFAST 1', 'DIA INI AF 1', 'MES INI AF 1', 'DIA FIM AF 1', 'MES FIM AF1', 'CAUS AFAST 2', 'DIA INI AF 2', 'MES INI AF 2', 'DIA FIM AF 2', 'MES FIM AF 2', 'CAUS AFAST 3', 'DIA INI AF 3', 'MES INI AF 3', 'DIA FIM AF 3', 'MES FIM AF 3', 'QT DIAS AFAS')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            df_to_csv(df, export_file, None)

    elif year == 2010:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO 2002_Fonte', 'CLAS CNAE 20_Fonte', 'GR INSTRUCAO_Fonte', 'IDADE', 'IDENTIFICAD', 'IND SIMPLES_Fonte', 'MUNICIPIO_Fonte', 'PIS', 'RACA_COR', 'REM DEZ (R$)', 'REM MED (R$), GENERO', 'TAMESTAB_Fonte' )

            cols = ('MUNICIPIO', 'CLAS CNAE 95', 'EMP EM 31/12', 'TP VINCULO','CAUSA DESLIG', 'MES DESLIG', 'IND ALVARA', 'TIPO ADM', 'TIPO SAL', 'OCUPACAO 94', 'GR INSTRUCAO', 'GENERO', 'NACIONALIDADE', 'RACA_COR', 'PORT DEFIC', 'TAMESTAB', 'NAT JURIDICA', 'IND CEI VINC', 'TIPO ESTBL', 'IND PAT', 'IND SIMPLES', 'DT ADMISSAO', 'REM MEDIA', 'REM MED (R$)', 'REM DEZEMBRO', 'REM DEZ (R$)', 'TEMP EMPR', 'HORAS CONTR', 'ULT REM', 'SAL CONTR', 'DT NASCIMENT', 'NUME CTPS', 'CPF', 'CEI VINC', 'IDENTIFICAD', 'RADIC CNPJ', 'TIPO ESTB ID', 'NOME', 'DIA DESL', 'OCUP 2002', 'CLAS CNAE 20', 'SB CLAS 20', 'TP DEFIC', 'CAU AFAST 1', 'DIA INI AF 1', 'MES INI AF 1', 'DIA FIM AF 1', 'MES FIM AF1', 'CAUS AFAST 2', 'DIA INI AF 2', 'MES INI AF 2', 'DIA FIM AF 2', 'MES FIM AF 2', 'CAUS AFAST 3', 'DIA INI AF 3', 'MES INI AF 3', 'DIA FIM AF 3', 'MES FIM AF 3', 'QT DIAS AFAS')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO 2002_Fonte')

            df_to_csv(df, export_file, None)

    elif year == 2011:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO Ocupação 2002', 'CNAE 2.0 Classe', 'Escolaridade após 2005', 'Vínculo Ativo 31/12', 'Idade', 'CNPJ / CEI', 'Ind Simples', 'Município', 'PIS', 'Raça Cor', 'Vl Remun Dezembro Nom', 'Vl Remun Média Nom', 'Sexo Trabalhador', 'Tamanho Estabelecimento')

            cols = ('Município', 'CNAE 95 Classe', 'Vínculo Ativo 31/12', 'Tipo Vinculo','Motivo Desligamento', 'Mês Desligamento', 'Ind Vínculo Alvará', 'Tipo Admissão', 'Tipo Salário', 'CBO 94 Ocupação', 'Escolaridade após 2005', 'Sexo trabalhador', 'Nacionalidade', 'Raça Cor', 'Ind Portador Defic', 'Tamanho Estabelecimento', 'Natureza Jurídica', 'Ind CEI Vinculado', 'Tipo Estab', 'Ind Estab Participa PAT', 'Ind Simples', 'Data Admissão Declarada', 'Vl Remun Média Nom', 'Vl Remun Média (SM)', 'Vl Remun Dezembro Nom ', 'Vl Remun Dezembro (SM)', 'Tempo Emprego', 'Qtd Hora Contr', 'Vl Última Remuneração Ano', 'Vl Salário Contratual', 'PIS', 'Número CTPS', 'CPF', 'CEI Vinculado', 'CNPJ / CEI', 'CNPJ Raiz', 'Nome Trabalhador', 'CBO Ocupação 2002', 'CNAE 2.0 Classe', 'CNAE 2.0 Subclasse', 'Tipo Defic', 'Causa Afastamento 1', 'Dia Ini AF 1', 'Mês Ini AF1', 'Dia Fim AF1', 'Mês Fim AF1', 'Causa Afastamento 2', 'Dia Ini AF2', 'Mês Ini AF2', 'Dia Fim AF2', 'Mês Fim AF2', 'Causa Afastamento 3', 'Dia Ini AF3', 'Mês Ini AF3', 'Dia Fim AF3', 'Mês Fim AF3', 'Qtd Dias Afastamento', 'Idade')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO Ocupação 2002')

            df_to_csv(df, export_file, None)

    elif year == 2012:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO Ocupação 2002', 'CNAE 2.0 Classe', 'Escolaridade após 2005', 'Vínculo Ativo 31/12', 'Idade', 'CNPJ / CEI', 'Ind Simples', 'Município', 'PIS', 'Raça Cor', 'Vl Remun Dezembro Nom', 'Vl Remun Média Nom', 'Sexo Trabalhador', 'Tamanho Estabelecimento')

            cols = ('Município', 'CNAE 95 Classe', 'Vínculo Ativo 31/12', 'Tipo Vinculo','Motivo Desligamento', 'Mês desligamento', 'Ind Vínculo Alvará', 'Tipo Admissão', 'Tipo Salário', 'CBO 94 Ocupação', 'Escolaridade após 2005', 'Sexo trabalhador', 'Nacionalidade', 'Raça Cor', 'Ind Portador Defic', 'Tamanho Estabelecimento', 'Natureza Jurídica', 'Ind CEI Vinculado', 'Tipo Estab', 'Ind Estab Participa PAT', 'Ind Simples', 'Data Admissão Declarada', 'Vl Remun Média Nom', 'Vl Remun Média (SM)', 'Vl Remun Dezembro Nom ', 'Vl Remun Dezembro (SM)', 'Tempo Emprego', 'Qtd Hora Contr', 'Vl Última Remuneração Ano', 'Vl Salário Contratual', 'PIS', 'Número CTPS', 'CPF', 'CEI Vinculado', 'CNPJ / CEI', 'CNPJ Raiz', 'Nome Trabalhador', 'CBO Ocupação 2002', 'CNAE 2.0 Classe', 'CNAE 2.0 Subclasse', 'Tipo Defic', 'Causa Afastamento 1', 'Dia Ini AF 1', 'Mês Ini AF1', 'Dia Fim AF1', 'Mês Fim AF1', 'Causa Afastamento 2', 'Dia Ini AF2', 'Mês Ini AF2', 'Dia Fim AF2', 'Mês Fim AF2', 'Causa Afastamento 3', 'Dia Ini AF3', 'Mês Ini AF3', 'Dia Fim AF3', 'Mês Fim AF3', 'Qtd Dias Afastamento', 'Idade')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO Ocupação 2002')

            df_to_csv(df, export_file, None)

    elif year == 2013:

        folder = "dados/rais/raw/" + str(year) + '/'

        arr = get_files_in_folder(folder, 'TXT')

        for x in arr:

            source_file = x
            export_file =  os.path.splitext(x)[0] + '.csv'

            useCols = ('CBO Ocupação 2002', 'CNAE 2.0 Classe', 'Escolaridade após 2005', 'Vínculo Ativo 31/12', 'Idade', 'CNPJ / CEI', 'Ind Simples', 'Município', 'PIS', 'Raça Cor', 'Vl Remun Dezembro Nom', 'Vl Remun Média Nom', 'Sexo Trabalhador', 'Tamanho Estabelecimento')

            cols = ('Município', 'CNAE 95 Classe', 'Vínculo Ativo 31/12', 'Tipo Vinculo','Motivo Desligamento', 'Mês desligamento', 'Ind Vínculo Alvará', 'Tipo Admissão', 'Tipo Salário', 'CBO 94 Ocupação', 'Escolaridade após 2005', 'Sexo trabalhador', 'Nacionalidade', 'Raça Cor', 'Ind Portador Defic', 'Tamanho Estabelecimento', 'Natureza Jurídica', 'Ind CEI Vinculado', 'Tipo Estab', 'Ind Estab Participa PAT', 'Ind Simples', 'Data Admissão Declarada', 'Vl Remun Média Nom', 'Vl Remun Média (SM)', 'Vl Remun Dezembro Nom ', 'Vl Remun Dezembro (SM)', 'Tempo Emprego', 'Qtd Hora Contr', 'Vl Última Remuneração Ano', 'Vl Salário Contratual', 'PIS', 'Número CTPS', 'CPF', 'CEI Vinculado', 'CNPJ / CEI', 'CNPJ Raiz', 'Nome Trabalhador', 'CBO Ocupação 2002', 'CNAE 2.0 Classe', 'CNAE 2.0 Subclasse', 'Tipo Defic', 'Causa Afastamento 1', 'Dia Ini AF 1', 'Mês Ini AF1', 'Dia Fim AF1', 'Mês Fim AF1', 'Causa Afastamento 2', 'Dia Ini AF2', 'Mês Ini AF2', 'Dia Fim AF2', 'Mês Fim AF2', 'Causa Afastamento 3', 'Dia Ini AF3', 'Mês Ini AF3', 'Dia Fim AF3', 'Mês Fim AF3', 'Qtd Dias Afastamento', 'Idade')

            df = read_from_csv(source_file, 2,";", cols, None, useCols)

            # MapRetiraMilitares
            mapRetiraMilitares(df, 'CBO Ocupação 2002')

            df_to_csv(df, export_file, None)


if __name__ == '__main__':
    start = time.time()
    extract(2003)
    total_run_time = time.time() - start
    print "Total runtime: " + format_runtime(total_run_time)
