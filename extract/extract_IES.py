import sys, os, click, magic

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
@click.argument('output_path', type=click.Path(), required=True)
def main(file_path, output_path):
​
    # This should create the folder if it's not there yet
    if not os.path.exists(output_path): os.makedirs(output_path)
​
    with open(file_path) as fp:
        for line in fp:
            CO_IES = line[0:8]
            CO_MANTENEDORA = line[8:16]
            CO_CATEGORIA_ADMINISTRATIVA = line[16:24]
            DS_CATEGORIA_ADMINISTRATIVA = line[24:74]
            CO_ORGANIZACAO_ACADEMICA = line[74:82]
            NO_ORGANIZACAO_ACADEMICA = line[82:182]
            CO_MUNICIPIO_IES = line[182:190]
            NO_MUNICIPIO_IES = line[190:340]
            CO_UF = line[340:348]
            SGL_UF = line[348:350]
            NO_REGIAO = line[350:380]
            IN_CAPITAL = line[380:388]
            IN_ENTIDADE_BENEFICENTE = line[388:396]
            QT_TEC_TOTAL = line[396:404]
            QT_TEC_FUND_INCOMP_FEM = line[404:412]
            QT_TEC_FUND_INCOMP_MASC = line[412:420]
            QT_TEC_FUND_COMP_FEM = line[420:428]
            QT_TEC_FUND_COMP_MASC = line[428:436]
            QT_TEC_MEDIO_FEM = line[436:444]
            QT_TEC_MEDIO_MASC = line[444:452]
            QT_TEC_SUPERIOR_FEM = line[452:460]
            QT_TEC_SUPERIOR_MASC = line[460:468]
            QT_TEC_ESPECIALISTA_FEM = line[468:476]
            QT_TEC_ESPECIALISTA_MASC = line[476:484]
            QT_TEC_MESTRADO_FEM = line[484:492]
            QT_TEC_MESTRADO_MASC = line[492:500]
            QT_TEC_DOUTORADO_FEM = line[500:508]
            QT_TEC_DOUTORADO_MASC = line[508:516]
​
            connection = MySQLdb.connect(host='localhost', user='root', passwd='', db='dataviva_raw')
            cursor = connection.cursor()
            cursor.executemany('''
                           INSERT INTO IES (CO_IES, CO_MANTENEDORA, CO_CATEGORIA_ADMINISTRATIVA,
                           DS_CATEGORIA_ADMINISTRATIVA, CO_ORGANIZACAO_ACADEMICA, NO_ORGANIZACAO_ACADEMICA,
                           CO_MUNICIPIO_IES, NO_MUNICIPIO_IES, CO_UF, SGL_UF, NO_REGIAO, IN_CAPITAL,
                           IN_ENTIDADE_BENEFICENTE, QT_TEC_TOTAL, QT_TEC_FUND_INCOMP_FEM, QT_TEC_FUND_INCOMP_MASC,
                           QT_TEC_FUND_COMP_FEM, QT_TEC_FUND_COMP_MASC, QT_TEC_MEDIO_FEM, QT_TEC_MEDIO_MASC,
                           QT_TEC_SUPERIOR_FEM, QT_TEC_SUPERIOR_MASC, QT_TEC_ESPECIALISTA_FEM, QT_TEC_ESPECIALISTA_MASC,
                           QT_TEC_MESTRADO_FEM, QT_TEC_MESTRADO_MASC, QT_TEC_DOUTORADO_FEM, QT_TEC_DOUTORADO_MASC)
                           VALUES ('%s', '%s', '%s')''', listadetuplas)
            connection.commit()
            close()
​
    # Discover enconding type of file
    blob = open(file_path).read()
    m = magic.Magic(mime_encoding=True)
    encoding = m.from_buffer(blob)
​
    # Reading the csv, getting a dataframe from pd.read_csv
    data_frame = to_df(sys.argv[1], encoding)
​
    # Filtering data, where Municipality_ID column = 310620
    #data_frame = data_frame[(data_frame.Month == 1)]
​
    # Write output
    new_file_path = os.path.abspath(os.path.join(output_path, "fout.csv"))
    data_frame.to_csv(open(new_file_path, 'wb+'), sep=";", index=False, float_format="%.3f", encoding="utf-8")
​
if __name__ == "__main__":
    main()