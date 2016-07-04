create table IES_2009_BIBLIOTECA_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2009/DADOS/BIBLIOTECA.txt'
into table IES_2009_BIBLIOTECA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2009_BIBLIOTECA select 
substring(dados,1,8) as CO_UNIDADE_FUNCIONAMENTO,
substring(dados,9,8) as CO_BIBLIOTECA ,
substring(dados,17,8) as CO_TIPO_BIBLIOTECA ,
substring(dados,25,8) as IN_REDE_WIRELESS ,
substring(dados,33,8) as IN_CATALOGO_ONLINE ,
substring(dados,41,8) as QT_ASSENTO ,
substring(dados,49,8) as QT_EMPRESTIMO_DOMICILIAR ,
substring(dados,57,8) as QT_EMPRESTIMO_BIBLIOTECA ,
substring(dados,65,8) as QT_COMUTACAO ,
substring(dados,73,8) as QT_USUARIO_CAPACITADO ,
substring(dados,81,8) as QT_ACERVO
from IES_2009_BIBLIOTECA_BLOCO;

