-- Fixando schema
SET search_path TO comtrade;

-- Carregando os dados
copy comtrade_1999_step3
from 's3://dataviva-etl/transferencia/comtrade/step3/comtrade_1999_step3.csv'
credentials 'aws_iam_role=arn:aws:iam::414114490516:role/Redshift'
CSV
ignoreheader 1;

select * from comtrade_1999_step3;
