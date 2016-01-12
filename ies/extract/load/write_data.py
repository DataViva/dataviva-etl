import os, pandas, sqlalchemy

def write_data(table, tuples, columns, chunksize):
    engine = sqlalchemy.create_engine('mysql://'+os.environ["DB_USER"]+":"+os.environ["DB_PW"]+'@'+os.environ["DB_HOST"]+'/'+os.environ["DB_RAW"])
    data_frame = pandas.DataFrame(tuples, columns=columns)
    data_frame.to_sql(table, engine, if_exists='replace', index=False, chunksize=chunksize)