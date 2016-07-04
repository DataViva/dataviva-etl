use dataviva_raw;

drop table if exists IES_2010_ALUNO_BLOCO;
create table IES_2010_ALUNO_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/HEDU/Dados/2010/DADOS/ALUNO.txt'
into table IES_2010_ALUNO_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

drop table if exists IES_2010_ALUNO;
create table IES_2010_ALUNO select 
substring(dados,1,8) as CO_IES,
substring(dados,9,8) as CO_CATEGORIA_ADMINISTRATIVA,
substring(dados,17,100) as DS_CATEGORIA_ADMINISTRATIVA,
substring(dados,117,8) as CO_ORGANIZACAO_ACADEMICA,
substring(dados,125,100) as DS_ORGANIZACAO_ACADEMICA,
substring(dados,225,8) as CO_CURSO,
substring(dados,233,200) as NO_CURSO,
substring(dados,433,8) as CO_GRAU_ACADEMICO,
substring(dados,441,8) as CO_MODALIDADE_ENSINO,
substring(dados,449,8) as CO_NIVEL_ACADEMICO,
substring(dados,457,8) as CO_ALUNO_CURSO,
substring(dados,465,14) as CO_ALUNO,
substring(dados,479,8) as CO_COR_RACA_ALUNO,
substring(dados,487,24) as DS_COR_RACA_ALUNO,
substring(dados,511,8) as IN_SEXO_ALUNO,
substring(dados,519,9) as DS_SEXO_ALUNO,
substring(dados,528,4) as NU_ANO_ALUNO_NASC,
substring(dados,532,2) as NU_DIA_ALUNO_NASC,
substring(dados,534,2) as NU_MES_ALUNO_NASC,
substring(dados,536,8) as NU_IDADE_ALUNO,
substring(dados,544,8) as CO_NACIONALIDADE_ALUNO,
substring(dados,552,8) as CO_PAIS_ORIGEM_ALUNO,
substring(dados,560,8) as CO_UF_NASCIMENTO,
substring(dados,568,8) as CO_MUNICIPIO_NASCIMENTO,
substring(dados,576,8) as CO_ALUNO_SITUACAO,
substring(dados,584,8) as IN_ALUNO_DEFICIENCIA,
substring(dados,592,8) as IN_DEF_AUDITIVA,
substring(dados,600,8) as IN_DEF_FISICA,
substring(dados,608,8) as IN_DEF_INTELECTUAL,
substring(dados,616,8) as IN_DEF_MULTIPLA,
substring(dados,624,8) as IN_DEF_SURDEZ,
substring(dados,632,8) as IN_DEF_SURDOCEGUEIRA,
substring(dados,640,8) as IN_DEF_BAIXA_VISAO,
substring(dados,648,8) as IN_DEF_CEGUEIRA,
substring(dados,656,10) as DT_INGRESSO_CURSO,
substring(dados,666,8) as IN_ATIVIDADE_COMPLEMENTAR,
substring(dados,674,8) as IN_RESERVA_VAGAS,
substring(dados,682,8) as IN_FINANC_ESTUDANTIL,
substring(dados,690,8) as IN_APOIO_SOCIAL,
substring(dados,698,8) as CO_CURSO_POLO,
substring(dados,706,8) as CO_TURNO_ALUNO,
substring(dados,714,8) as IN_ING_VESTIBULAR,
substring(dados,722,8) as IN_ING_ENEM,
substring(dados,730,8) as IN_ING_OUTRA_FORMA_SELECAO,
substring(dados,738,8) as IN_ING_CONVENIO_PEC_G,
substring(dados,746,8) as IN_ING_OUTRA_FORMA,
substring(dados,754,8) as IN_RESERVA_ETNICO,
substring(dados,762,8) as IN_RESERVA_DEFICIENCIA,
substring(dados,770,8) as IN_RESERVA_ENSINO_PUBLICO,
substring(dados,778,8) as IN_RES_RENDA_FAMILIAR,
substring(dados,786,8) as IN_RESERVA_OUTROS,
substring(dados,794,8) as IN_FIN_REEMB_FIES,
substring(dados,802,8) as IN_FIN_REEMB_ESTADUAL,
substring(dados,810,8) as IN_FIN_REEMB_MUNICIPAL,
substring(dados,818,8) as IN_FIN_REEMB_PROG_IES,
substring(dados,826,8) as IN_FIN_REEMB_ENT_EXTERNA,
substring(dados,834,8) as IN_FIN_REEMB_OUTRA,
substring(dados,842,8) as IN_FIN_NAOREEMB_PROUNI_INTEGR,
substring(dados,850,8) as IN_FIN_NAOREEMB_PROUNI_PARCIAL,
substring(dados,858,8) as IN_FIN_NAOREEMB_ESTADUAL,
substring(dados,866,8) as IN_FIN_NAOREEMB_MUNICIPAL,
substring(dados,874,8) as IN_FIN_NAOREEMB_PROG_IES,
substring(dados,882,8) as IN_FIN_NAOREEMB_ENT_EXTERNA,
substring(dados,890,8) as IN_FIN_NAOREEMB_OUTRA,
substring(dados,898,8) as IN_APOIO_ALIMENTACAO,
substring(dados,906,8) as IN_APOIO_BOLSA_PERMANENCIA,
substring(dados,914,8) as IN_APOIO_BOLSA_TRABALHO,
substring(dados,922,8) as IN_APOIO_MATERIAL_DIDATICO,
substring(dados,930,8) as IN_APOIO_MORADIA,
substring(dados,938,8) as IN_APOIO_TRANSPORTE,
substring(dados,946,8) as IN_COMPL_ESTAGIO,
substring(dados,954,8) as IN_COMPL_EXTENSAO,
substring(dados,962,8) as IN_COMPL_MONITORIA,
substring(dados,970,8) as IN_COMPL_PESQUISA,
substring(dados,978,8) as IN_BOLSA_ESTAGIO,
substring(dados,986,8) as IN_BOLSA_EXTENSAO,
substring(dados,994,8) as IN_BOLSA_MONITORIA,
substring(dados,1002,8) as IN_BOLSA_PESQUISA,
substring(dados,1010,8) as TP_PROCEDE_EDUC_PUBLICA,
substring(dados,1018,8) as IN_MATRICULA,
substring(dados,1026,8) as IN_CONCLUINTE,
substring(dados,1034,8) as IN_INGRESSO,
substring(dados,1042,8) as IN_ING_PROCESSO_SELETIVO,
substring(dados,1050,8) as IN_ING_OUTRAS_FORMAS,
substring(dados,1058,4) as ANO_INGRESSO
from IES_2010_ALUNO_BLOCO;


select * from IES_2010_ALUNO_BLOCO;
select * from IES_2010_ALUNO;




