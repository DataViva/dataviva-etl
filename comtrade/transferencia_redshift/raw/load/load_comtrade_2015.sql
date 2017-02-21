-- Fixando schema
SET search_path TO comtrade;

-- Carregando os dados
copy comtrade_2015
from 's3://dataviva-etl/transferencia/comtrade/comtrade_2015_full.csv'
credentials 'aws_iam_role=arn:aws:iam::414114490516:role/Redshift'
CSV
ignoreheader 1;
