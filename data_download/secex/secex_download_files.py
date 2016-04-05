# -*- coding: utf-8 -*-
'''
python data_download/secex/secex_download_files.py 
Os arquivos serão salvos em /data
'''
from collections import namedtuple
from sqlalchemy import create_engine
import pandas as pd
import zipfile
import os


def select_table(conditions):
    s = 'ym'
    # 0 year, 1 mes, 2 location, 3 product, 4 trade-partner
    if conditions[2] != ' 1 = 1 ':
        s += 'b'

    if conditions[2] == ' 1 = 1 ' and conditions[3] == ' 1 = 1 ' and conditions[4] == ' 1 = 1 ':
        s += 'b'

    if conditions[3] != ' 1 = 1 ':
        s += 'p'

    if conditions[4] != ' 1 = 1 ':
        s += 'w'

    return 'secex_' + s


def get_colums(table, engine):
    column_rows = engine.execute("SELECT COLUMN_NAME FROM information_schema.columns WHERE TABLE_NAME='"+table+"' AND COLUMN_NAME NOT LIKE %s", "%_len")
    return [row[0] for row in column_rows]


def save(engine, years, months, locations, products, trade_partners):
    conditions = [' 1 = 1', ' 1 = 1', ' 1 = 1', ' 1 = 1', ' 1 = 1']  # 5 condicoes
    table_columns = {}

    for year in years:
        conditions[0] = year.condition
        for month in months:
            conditions[1] = month.condition
            for location in locations:
                conditions[2] = location.condition
                for product in products:
                    conditions[3] = product.condition
                    for trade_partner in trade_partners:
                        conditions[4] = trade_partner.condition
                        table = select_table(conditions)
                        name_file='data/files_secex/secex-'+str(year.name)+'-'+str(month.name)+'-'+str(location.name)+'-'+str(product.name)+'-'+str(trade_partner.name)+'.csv'

                        if table not in table_columns.keys():
                            table_columns[table] = get_colums(table, engine)

                        f = pd.read_sql_query('SELECT '+','.join(table_columns[table])+' FROM '+table+' WHERE '+' and '.join(conditions), engine)
                        f.to_csv(name_file, index = False)

                        zf=zipfile.ZipFile(name_file.split('.')[0]+'.zip','w')
                        zf.write(name_file)
                        zf.close()
                        os.system("rm "+name_file)



Condition = namedtuple('Condition', ['condition', 'name'])


years = [
    Condition('year=2002', '2002'),
    Condition('year=2003', '2003'),
    Condition('year=2004', '2004'),
    Condition('year=2005', '2005'),
    Condition('year=2006', '2006'),
    Condition('year=2007', '2007'),
    Condition('year=2008', '2008'),
    Condition('year=2009', '2009'),
    Condition('year=2010', '2010'),
    Condition('year=2011', '2011'),
    Condition('year=2012', '2012'),
    Condition('year=2013', '2013'),
    Condition('year=2014', '2014')]

months = [
    Condition('month=0', 'all'),
    Condition('month=1', '1'),
    Condition('month=2', '2'),
    Condition('month=3', '3'),
    Condition('month=4', '4'),
    Condition('month=5', '5'),
    Condition('month=6', '6'),
    Condition('month=7', '7'),
    Condition('month=8', '8'),
    Condition('month=9', '9'),
    Condition('month=10', '10'),
    Condition('month=11', '11'),
    Condition('month=12', '12')]

locations = [
    Condition(' 1 = 1 ', 'all'),
    Condition('bra_id_len=1', 'regions'),
    Condition('bra_id_len=3', 'states'),
    Condition('bra_id_len=5', 'mesoregions'),
    Condition('bra_id_len=7', 'microregions'),
    Condition('bra_id_len=9', 'municipalities')]

products = [
    Condition(' 1 = 1 ', 'all'),
    Condition('hs_id_len=2', 'sections'),
    Condition('hs_id_len=6', 'position')]

trade_partners = [
    Condition(' 1 = 1 ', 'all'),
    Condition('wld_id_len=2', 'continents'),
    Condition('wld_id_len=5', 'countries')]

engine = create_engine(
    'mysql://dataviva-dev:D4t4v1v4-d3v@dataviva-dev.cr7l9lbqkwhn.'
    'sa-east-1.rds.amazonaws.com:3306/dataviva', echo=False)


save(engine=engine, years=years, months=months, locations=locations, products=products, trade_partners=trade_partners)
