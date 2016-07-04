use dataviva_raw;

drop table if exists IES_2012_LOCAL_OFERTA_POLO_BLOCO;
create table IES_2012_LOCAL_OFERTA_POLO_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2012/DADOS/LOCAL_OFERTA.txt'
into table IES_2012_LOCAL_OFERTA_POLO_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2012_LOCAL_OFERTA_POLO select 
substring(dados,1,8) as CO_LOCAL_OFERTA_IES,
substring(dados,9,8) as CO_IES,
substring(dados,17,8) as CO_MUNICIPIO_LOCAL_OFERTA,
substring(dados,25,150) as NO_MUNICIPIO_LOCAL_OFERTA,
substring(dados,175,8) as CO_UF_LOCAL_OFERTA,
substring(dados,183,2) as SGL_UF_LOCAL_OFERTA,
substring(dados,185,2) as IN_SEDE,
substring(dados,187,8) as CO_CURSO_POLO,
substring(dados,195,8) as CO_CURSO,
substring(dados,203,8) as IN_LOCAL_OFERTA_NEAD,
substring(dados,211,8) as IN_LOCAL_OFERTA_UAB,
substring(dados,219,8) as IN_LOCAL_OFERTA_REITORIA,
substring(dados,227,8) as IN_LOCAL_OFERTA_POLO,
substring(dados,235,8) as IN_LOCAL_OFERTA_UNID_ACADEMICA
from IES_2012_LOCAL_OFERTA_POLO_BLOCO;


select * from IES_2012_LOCAL_OFERTA_POLO;




