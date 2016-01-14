import os, pandas, sqlalchemy

def write_sql(table, tuples, columns, if_exists, chunksize):
    engine = sqlalchemy.create_engine('mysql://'+os.environ["DB_USER"]+":"+os.environ["DB_PW"]+'@'+os.environ["DB_HOST"]+'/'+os.environ["DB_RAW"])
    data_frame = pandas.DataFrame(tuples, columns=columns)
    #if_exists='replace' table is droped and recreate it, all columns type receive text
    #schema parameter is needed
    data_frame.to_sql(table, engine, schema=None, if_exists=if_exists, index=False, chunksize=chunksize)