-- Fixando schema
SET search_path TO comtrade;

-- Carregando os dados
copy comtrade_2002
from 's3://dataviva-etl/transferencia/comtrade/comtrade_2002.csv'
credentials 'aws_iam_role=arn:aws:iam::414114490516:role/Redshift'
CSV
ignoreheader 1;

select * from comtrade_2002;
