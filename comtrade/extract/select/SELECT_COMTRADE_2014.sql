-- Select COMTRADE_2014

use dataviva_raw;

drop table if exists COMTRADE_2014_STEP1;

create table COMTRADE_2014_STEP1 
select  year, reporter_code as wld_id,
    commodity_code as hs_id, trade_value as val_usd
from COMTRADE_2014;

-- Exporte os dados da tabela anterior executando o 
-- seguinte comando no terminal:
/* 
    mysql -u dataviva -p -h 
    etl.cuydh8dsqzfr.us-east-1.rds.amazonaws.com dataviva_raw -e 
    "select * from COMTRADE_2014_STEP1" > comtrade_2014.csv
*/

-- Com os dados gerados no paso anterior, execute o script (format_raw_data.py)
-- para calcular o PCI, ECI e a tabela YPW para o ano 2014. Disponível em:
-- github.com/DataViva/dataviva-scripts/blob/master/scripts/comtrade/format_raw
-- _data.py

-- O script gera três arquivos compactados que correspondem a estes dados. 
-- Após extrair os dados, execute os seguintes passos para criar as tabelas
-- correspondente e carregar os dados no banco ETL:

CREATE TABLE IF NOT EXISTS comtrade_eci (
    wld_id char(6),
    eci numeric(10,3)
);

CREATE TABLE IF NOT EXISTS comtrade_pci (
    hs_id char(6),
    pci numeric(10,3)
);

CREATE TABLE IF NOT EXISTS comtrade_ypw (
    year numeric(4),
    hs_id char(6),
    wld_id char(5),
    val_usd numeric(20),
    rca numeric(10,3),
    distance numeric(20),
    opp_gain numeric(20)
);

load data local infile '/comtrade/2014/comtrade_eci.tsv'
into table comtrade_eci
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

load data local infile '/comtrade/2014/comtrade_pci.tsv'
into table comtrade_pci
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines;

load data local infile '/comtrade/2014/comtrade_ypw.tsv'
into table comtrade_ypw
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n'
ignore 1 lines
(@vyear, @vhs_id, @vwld_id, @vval_usd, @vrca, @vdistance, @vopp_gain)
SET year = @vyear, hs_id = @vhs_id, wld_id = @vwld_id,
    val_usd = nullif(@vval_usd,''), rca = nullif(@vrca,''),
    distance = nullif(@vdistance,''), opp_gain = nullif(@vopp_gain,'');
