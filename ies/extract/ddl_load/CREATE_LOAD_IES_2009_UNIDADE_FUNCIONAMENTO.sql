create table IES_2009_UNIDADE_FUNCIONAMENTO_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2009/DADOS/UNIDADE_FUNCIONAMENTO.txt'
into table IES_2009_UNIDADE_FUNCIONAMENTO_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table IES_2009_UNIDADE_FUNCIONAMENTO select 
substring(dados,1,8) as CO_UNIDADE_FUNCIONAMENTO,
substring(dados,9,8) as CO_TIPO_UNIDADE ,
substring(dados,17,8) as IN_POLO_EXTERIOR,
substring(dados,25,8) as IN_POSSUI_NEAD,
substring(dados,33,8) as IN_POLO_COMPARTILHADO,
substring(dados,41,8) as IN_SUBTIPO_UNIDADE,
substring(dados,49,8) as CO_IES ,
substring(dados,57,8) as CO_UNIDADE_IES ,
substring(dados,65,8) as CO_MUNICIPIO ,
substring(dados,73,8) as QT_SALA_AULA,
substring(dados,81,8) as IN_AC_RAMPAS,
substring(dados,89,8) as IN_AC_EQUIP_ELETROMECANICO,
substring(dados,97,8) as IN_AC_BANHEIRO_ADAPTADO,
substring(dados,105,8) as IN_AC_MOBILIARIO_ADAPTADO,
substring(dados,113,8) as IN_INST_NENHUMA,
substring(dados,121,8) as IN_INST_RESTAURANTE_UNIV,
substring(dados,129,8) as IN_INST_QUADRA,
substring(dados,137,8) as IN_INST_TEATRO,
substring(dados,145,8) as IN_INST_CINEMA,
substring(dados,153,8) as IN_INST_SERVICOS,
substring(dados,161,8) as IN_COND_ACESSIBILIDADE,
substring(dados,169,8) as IN_POSSUI_LABORATORIO,
substring(dados,177,8) as IN_POSSUI_BIBLIOTECA ,
substring(dados,185,8) as DT_CADASTRO,
substring(dados,193,8) as DT_ATUALIZACAO
from IES_2009_UNIDADE_FUNCIONAMENTO_BLOCO;
