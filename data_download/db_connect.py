# -*- coding: utf-8 -*-
'''
python data_download/db_connect.py
Os arquivos serão salvos em /data
'''
from collections import namedtuple
from sqlalchemy import create_engine
import pandas as pd


def save_all(engine, rais):
    # all
    f = pd.read_sql_query('SELECT * FROM rais_yb LIMIT 100', engine)
    f.to_csv('data/files_rais/rais_all.csv')


def save_year(engine, rais):
    # Por anos
    for year in range(2002, 2014):
        f = pd.read_sql_query('SELECT * FROM rais_yb WHERE year='+str(year)+' LIMIT 100', engine)
        f.to_csv('data/files_rais/years/rais_'+str(year)+'.csv')


def save_locations(engine, rais, locations):
    # year
    for year in range(2002, 2014):
        for location in locations:
            f = pd.read_sql_query('SELECT * FROM rais_yb WHERE bra_id_len='+str(location.condition)+' and year='+str(year)+' LIMIT 100', engine)
            f.to_csv('data/files_rais/locations/rais_'+str(year)+'_'+location.name+'.csv')

    for location in locations:
        f = pd.read_sql_query('SELECT * FROM rais_yb WHERE bra_id_len='+str(location.condition)+' LIMIT 100', engine)
        f.to_csv('data/files_rais/locations/rais_all_'+location.name+'.csv')


def save_industrys(engine, rais, locations, industrys):
    # all year and all locations 
    for industry in industrys:
        f = pd.read_sql_query('SELECT * FROM rais_yi WHERE cnae_id_len='+str(industry.condition)+' LIMIT 100', engine)
        f.to_csv('data/files_rais/industrys/rais_all_all_'+industry.name+'.csv')

    # with year and all locations 
    for year in range(2002, 2014):
        for industry in industrys:
            f = pd.read_sql_query('SELECT * FROM rais_ybi WHERE cnae_id_len='+str(industry.condition)+' and year='+str(year)+' LIMIT 100', engine)
            f.to_csv('data/files_rais/industrys/rais_'+str(year)+'_all_'+industry.name+'.csv')

    # with year and with locations 
    for year in range(2002, 2014):
        for location in locations:
            for industry in industrys:
                f = pd.read_sql_query('SELECT * FROM rais_ybi WHERE cnae_id_len='+str(industry.condition)+' and year='+str(year)+' LIMIT 100', engine)
                f.to_csv('data/files_rais/industrys/rais_'+str(year)+'_'+location.name+'_'+industry.name+'.csv')




def save(engine, years, locations, industrys, occupations):
    conditions = []

    for year in years:
        conditions.append(year.condition)
        for location in locations:
            conditions.append(location.condition)
            for industry in industrys:
                conditions.append(industry.condition)
                for occupation in occupations:
                    conditions.append(occupation.condition)
                    print ' and '.join(conditions)
                print '\n\n\n\n\n'
                    #f = pd.read_sql_query('SELECT * FROM rais_yb WHERE '+' and '.join(conditions)+ ' LIMIT 100', engine)
                    #f.to_csv('data/files_rais/rais_'+str(year)+'.csv')  
                



'1 = 1'

Condition = namedtuple('Condition', ['condition', 'name'])

rais = ['rais_yb', 'rais_yi', 'rais_yo', 'rais_ybi', 'rais_ybo', 'rais_yio', 'rais_ybio']

years=[
    Condition('year=2002','2002'),
    Condition('year=2003','2003'),
    Condition('year=2004','2004'),
    Condition('year=2005','2005'),
    Condition('year=2006','2006'),
    Condition('year=2007','2007'),
    Condition('year=2008','2008'),
    Condition('year=2009','2009'),
    Condition('year=2010','2010'),
    Condition('year=2011','2011'),
    Condition('year=2012','2012'),
    Condition('year=2013','2013'),
    Condition(' 1 = 1 ' , 'all')]

locations = [
    Condition('bra_id_len=1', 'regions'),
    Condition('bra_id_len=3', 'states'),
    Condition('bra_id_len=5', 'mesoregions'),
    Condition('bra_id_len=7', 'microregions'),
    Condition('bra_id_len=9', 'municipalities'),
    Condition(' 1 = 1 ' , 'all')]

industrys = [
    Condition('cnae_id_len=1', 'sections'),
    Condition('cnae_id_len=3', 'divisions'),
    Condition('cnae_id_len=6', 'classes'),
    Condition(' 1 = 1 ' , 'all')]

occupations = [
    Condition('cbo_id_len=1', 'main_groups'),
    Condition('cbo_id_len=4', 'families'),
    Condition(' 1 = 1 ' , 'all')]

engine = create_engine(
    'mysql://dataviva-dev:D4t4v1v4-d3v@dataviva-dev.cr7l9lbqkwhn.'
    'sa-east-1.rds.amazonaws.com:3306/dataviva', echo=False)


# save_all(engine=engine, rais=rais)

# save_year(engine=engine, rais=rais)

# save_locations(engine=engine, rais=rais, locations=locations)

#save_industrys(engine=engine, rais=rais, locations=locations, industrys=industrys)

save(engine=engine, years=years, locations=locations, industrys=industrys, occupations=occupations)

