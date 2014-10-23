from os import environ


DATA_DIR='dados/'

try:
    DATAVIVA_DB_USER=environ["DATAVIVA_DB_USER"]
    DATAVIVA_DB_PW=environ["DATAVIVA_DB_PW"]
    DATAVIVA_DB_NAME=environ["DATAVIVA_DB_NAME"]
except Exception, e:
    False


DATAVIVA_DB_USER="root"
DATAVIVA_DB_NAME="dataviva2"
DATAVIVA_DB_PW=""
