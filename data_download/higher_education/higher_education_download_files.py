# -*- coding: utf-8 -*-
'''
 python data_download/higher_education/higher_education_download_files.py
 The files will be saved in /data/files_hedu
'''
from collections import namedtuple
from sqlalchemy import create_engine
import pandas as pd
import zipfile
import os


# hedu_yb, hedu_yc, hedu_ybc


def select_table(conditions):
    s = 'y'
    # 0 year, 1 location, 3 major
    if conditions[1] != ' 1 = 1 ':
        s += 'b'

    if conditions[1] == ' 1 = 1 ' and conditions[2] == ' 1 = 1 ':
        s += 'b'

    if conditions[2] != ' 1 = 1 ':
        s += 'c'

    return 'hedu_' + s


def get_colums(table, engine):
    column_rows = engine.execute("SELECT COLUMN_NAME FROM information_schema.columns WHERE TABLE_NAME='"+table+"' AND COLUMN_NAME NOT LIKE %s", "%_len")
    return [row[0] for row in column_rows]


def zip_file(name_file):
    zf = zipfile.ZipFile(name_file.split('.')[0]+'.zip', 'w')
    zf.write(name_file)
    zf.close()
    os.system("rm "+name_file)


def save(engine, years, locations, majors):
    conditions = [' 1 = 1', ' 1 = 1', ' 1 = 1']  # 5 condicoes
    table_columns = {}

    for year in years:
        conditions[0] = year.condition
        for location in locations:
            conditions[1] = location.condition
            for major in majors:
                conditions[2] = major.condition
                table = select_table(conditions)
                name_file = 'data/files_hedu/hedu-'+str(year.name)+'-'+str(location.name)+'-'+str(major.name)+'.csv'

                if table not in table_columns.keys():
                        table_columns[table] = get_colums(table, engine)

                f = pd.read_sql_query('SELECT '+','.join(table_columns[table])+' FROM '+table+' WHERE '+' and '.join(conditions), engine)
                f.to_csv(name_file, index=False)

                zip_file(name_file=name_file)


Condition = namedtuple('Condition', ['condition', 'name'])


years = [
    Condition('year=2009', '2009'),
    Condition('year=2010', '2010'),
    Condition('year=2011', '2011'),
    Condition('year=2012', '2012'),
    Condition('year=2013', '2013')]

locations = [
    Condition(' 1 = 1 ', 'all'),
    Condition('bra_id_len=1', 'regions'),
    Condition('bra_id_len=3', 'states'),
    Condition('bra_id_len=5', 'mesoregions'),
    Condition('bra_id_len=7', 'microregions'),
    Condition('bra_id_len=9', 'municipalities')]

majors = [
    Condition(' 1 = 1 ', 'all'),
    Condition('course_hedu_id_len=2', 'field'),
    Condition('course_hedu_id_len=6', 'majors')]

engine = create_engine(
    'mysql://dataviva-dev:D4t4v1v4-d3v@dataviva-dev.cr7l9lbqkwhn.'
    'sa-east-1.rds.amazonaws.com:3306/dataviva', echo=False)


save(engine=engine, years=years, locations=locations, majors=majors)
