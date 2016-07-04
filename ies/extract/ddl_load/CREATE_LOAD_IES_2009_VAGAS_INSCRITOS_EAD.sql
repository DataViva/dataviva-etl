create table IES_2009_VAGAS_INSCRITOS_EAD_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2009/DADOS/VAGAS_INSCRITOS_EAD.txt'
into table IES_2009_VAGAS_INSCRITOS_EAD_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2009_VAGAS_INSCRITOS_EAD select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,17,50) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,67,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,75,100) as NO_ORGANIZACAO_ACADEMICA,
substring(dados,175,8) as CO_MUNICIPIO_IES,
substring(dados,183,150) as NO_MUNICIPIO_IES,
substring(dados,333,2) as SGL_UF_IES,
substring(dados,335,8) as CO_CURSO_EAD,
substring(dados,343,200) as NO_CURSO_EAD,
substring(dados,543,8) as CO_GRAU_ACADEMICO,
substring(dados,551,8) as CO_NIVEL_ACADEMICO,
substring(dados,559,12) as CO_OCDE,
substring(dados,571,8) as NU_VAGAS_OFERECIDAS_EAD,
substring(dados,579,8) as QT_INSCRITOS_ANO_EAD
from IES_2009_VAGAS_INSCRITOS_EAD_BLOCO;
