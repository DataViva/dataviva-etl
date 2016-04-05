# -*- coding: utf-8 -*-
'''
 python data_download/rais/rais_download_files.py
Os arquivos serão salvos em /data
'''
from collections import namedtuple
from sqlalchemy import create_engine
import pandas as pd
import zipfile
import os


# sc_yb, sc_yc, sc_ybc


def select_table(conditions):
    s = 'ym'
    # 0 year, 1 location, 3 course
    if conditions[1] != ' 1 = 1 ':
        s += 'b'

    if conditions[1] == ' 1 = 1 ' and conditions[2] == ' 1 = 1 ':
        s += 'b'

    if conditions[2] != ' 1 = 1 ':
        s += 'c'

    return 'sc_' + s

def get_colums(table, engine):
    column_rows = engine.execute("SELECT COLUMN_NAME FROM information_schema.columns WHERE TABLE_NAME='"+table+"' AND COLUMN_NAME NOT LIKE %s", "%_len")
    return [row[0] for row in column_rows]



def save(engine, years, locations, courses):
    conditions = [' 1 = 1', ' 1 = 1', ' 1 = 1']  # 5 condicoes
    table_columns = {}

    for year in years:
        conditions[0] = year.condition
        for location in locations:
            conditions[1] = location.condition
            for course in courses:
                conditions[2] = course.condition
                print select_table(conditions)
                print conditions
                import pdb; pdb.set_trace()


Condition = namedtuple('Condition', ['condition', 'name'])

years = [
    Condition('year=2007', '2007'),
    Condition('year=2008', '2008'),
    Condition('year=2009', '2009'),
    Condition('year=2010', '2010'),
    Condition('year=2011', '2011'),
    Condition('year=2012', '2012'),
    Condition('year=2013', '2013'),
    Condition('year=2014', '2014')]

locations = [
    Condition(' 1 = 1 ', 'all'),
    Condition('bra_id_len=1', 'regions'),
    Condition('bra_id_len=3', 'states'),
    Condition('bra_id_len=5', 'mesoregions'),
    Condition('bra_id_len=7', 'microregions'),
    Condition('bra_id_len=9', 'municipalities')]

courses = [
    Condition(' 1 = 1 ', 'all'),
    Condition('course_sc_id_len=2', 'field'),
    Condition('course_sc_id_len=5', 'course')]

engine = create_engine(
    'mysql://dataviva-dev:D4t4v1v4-d3v@dataviva-dev.cr7l9lbqkwhn.'
    'sa-east-1.rds.amazonaws.com:3306/dataviva', echo=False)


save(engine=engine, years=years, locations=locations, courses=courses)
