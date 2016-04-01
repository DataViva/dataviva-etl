from sqlalchemy import create_engine
import MySQLdb
import pandas as pd
#engine = create_engine('dialect://user:pass@host:port/schema', echo=False)
engine = create_engine('mysql://dataviva:D4t4v1v430@dataviva-dev.cr7l9lbqkwhn.sa-east-1.rds.amazonaws.com:3306/dataviva', echo=False)
#f = pd.read_sql_query('SELECT * FROM mytable', engine, index_col = 'ID')
f = pd.read_sql_query('SELECT * FROM attrs_bra', engine)

import pdb; pdb.set_trace()