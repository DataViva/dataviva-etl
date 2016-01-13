import os, pandas, sqlalchemy

def write_data(table, chunksize, df):
    engine = sqlalchemy.create_engine('mysql://'+os.environ["DB_USER"]+":"+os.environ["DB_PW"]+'@'+os.environ["DB_HOST"]+'/'+os.environ["DB_RAW"])
    df.to_sql(table, engine, if_exists='replace', index=False, chunksize=chunksize)