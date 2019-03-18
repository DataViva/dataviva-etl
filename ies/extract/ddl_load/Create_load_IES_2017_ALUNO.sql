use dataviva_raw;

/* 
    Tabela IES_2016_ALUNO é removida, caso exista. 
    Uma nova tabela IES_2016_ALUNO é criada.
*/
drop table if exists IES_2017_ALUNO;
create table IES_2017_ALUNO(
NU_ANO_CENSO VARCHAR (4),
CO_IES VARCHAR (8),
TP_CATEGORIA_ADMINISTRATIVA VARCHAR (1),
TP_ORGANIZACAO_ACADEMICA VARCHAR (1),
CO_CURSO VARCHAR (8),
CO_CURSO_POLO VARCHAR (8),
TP_TURNO VARCHAR (1),
TP_GRAU_ACADEMICO VARCHAR (1),
TP_MODALIDADE_ENSINO VARCHAR (1),
TP_NIVEL_ACADEMICO VARCHAR (1),
CO_OCDE_AREA_GERAL VARCHAR (1),
CO_OCDE_AREA_ESPECIFICA VARCHAR (2),
CO_OCDE_AREA_DETALHADA VARCHAR (3),
CO_OCDE VARCHAR (6),
CO_ALUNO VARCHAR (12),
CO_ALUNO_CURSO VARCHAR (8),
CO_ALUNO_CURSO_ORIGEM VARCHAR (8),
TP_COR_RACA VARCHAR (1),
TP_SEXO VARCHAR (1),
NU_ANO_NASCIMENTO VARCHAR (4),
NU_MES_NASCIMENTO VARCHAR (2),
NU_DIA_NASCIMENTO VARCHAR (2),
NU_IDADE VARCHAR (3),
TP_NACIONALIDADE VARCHAR (1),
CO_PAIS_ORIGEM VARCHAR (3),
CO_UF_NASCIMENTO VARCHAR (2),
CO_MUNICIPIO_NASCIMENTO VARCHAR (7),
TP_DEFICIENCIA VARCHAR (1),
IN_DEFICIENCIA_AUDITIVA VARCHAR (1),
IN_DEFICIENCIA_FISICA VARCHAR (1),
IN_DEFICIENCIA_INTELECTUAL VARCHAR (1),
IN_DEFICIENCIA_MULTIPLA VARCHAR (1),
IN_DEFICIENCIA_SURDEZ VARCHAR (1),
IN_DEFICIENCIA_SURDOCEGUEIRA VARCHAR (1),
IN_DEFICIENCIA_BAIXA_VISAO VARCHAR (1),
IN_DEFICIENCIA_CEGUEIRA VARCHAR (1),
IN_DEFICIENCIA_SUPERDOTACAO VARCHAR (1),
IN_TGD_AUTISMO_INFANTIL VARCHAR (1),
IN_TGD_SINDROME_ASPERGER VARCHAR (1),
IN_TGD_SINDROME_RETT VARCHAR (1),
IN_TGD_TRANSTOR_DESINTEGRATIVO VARCHAR (1),
TP_SITUACAO VARCHAR (1),
QT_CARGA_HORARIA_TOTAL VARCHAR (8),
QT_CARGA_HORARIA_INTEG VARCHAR (8),
DT_INGRESSO_CURSO VARCHAR (12),
IN_INGRESSO_VESTIBULAR VARCHAR (1),
IN_INGRESSO_ENEM VARCHAR (1),
IN_INGRESSO_AVALIACAO_SERIADA VARCHAR (1),
IN_INGRESSO_SELECAO_SIMPLIFICA VARCHAR (1),
IN_INGRESSO_OUTRO_TIPO_SELECAO VARCHAR (1),
IN_INGRESSO_VAGA_REMANESC VARCHAR (1),
IN_INGRESSO_VAGA_PROG_ESPECIAL VARCHAR (1),
IN_INGRESSO_TRANSF_EXOFFICIO VARCHAR (1),
IN_INGRESSO_DECISAO_JUDICIAL VARCHAR (1),
IN_INGRESSO_CONVENIO_PECG VARCHAR (1),
IN_INGRESSO_EGRESSO VARCHAR (1),
IN_INGRESSO_OUTRA_FORMA VARCHAR (1),
IN_RESERVA_VAGAS VARCHAR (1),
IN_RESERVA_ETNICO VARCHAR (1),
IN_RESERVA_DEFICIENCIA VARCHAR (1),
IN_RESERVA_ENSINO_PUBLICO VARCHAR (1),
IN_RESERVA_RENDA_FAMILIAR VARCHAR (1),
IN_RESERVA_OUTRA VARCHAR (1),
IN_FINANCIAMENTO_ESTUDANTIL VARCHAR (1),
IN_FIN_REEMB_FIES VARCHAR (1),
IN_FIN_REEMB_ESTADUAL VARCHAR (1),
IN_FIN_REEMB_MUNICIPAL VARCHAR (1),
IN_FIN_REEMB_PROG_IES VARCHAR (1),
IN_FIN_REEMB_ENT_EXTERNA VARCHAR (1),
IN_FIN_REEMB_OUTRA VARCHAR (1),
IN_FIN_NAOREEMB_PROUNI_INTEGR VARCHAR (1),
IN_FIN_NAOREEMB_PROUNI_PARCIAL VARCHAR (1),
IN_FIN_NAOREEMB_ESTADUAL VARCHAR (1),
IN_FIN_NAOREEMB_MUNICIPAL VARCHAR (1),
IN_FIN_NAOREEMB_PROG_IES VARCHAR (1),
IN_FIN_NAOREEMB_ENT_EXTERNA VARCHAR (1),
IN_FIN_NAOREEMB_OUTRA VARCHAR (1),
IN_APOIO_SOCIAL VARCHAR (1),
IN_APOIO_ALIMENTACAO VARCHAR (1),
IN_APOIO_BOLSA_PERMANENCIA VARCHAR (1),
IN_APOIO_BOLSA_TRABALHO VARCHAR (1),
IN_APOIO_MATERIAL_DIDATICO VARCHAR (1),
IN_APOIO_MORADIA VARCHAR (1),
IN_APOIO_TRANSPORTE VARCHAR (1),
IN_ATIVIDADE_EXTRACURRICULAR VARCHAR (1),
IN_COMPLEMENTAR_ESTAGIO VARCHAR (1),
IN_COMPLEMENTAR_EXTENSAO VARCHAR (1),
IN_COMPLEMENTAR_MONITORIA VARCHAR (1),
IN_COMPLEMENTAR_PESQUISA VARCHAR (1),
IN_BOLSA_ESTAGIO VARCHAR (1),
IN_BOLSA_EXTENSAO VARCHAR (1),
IN_BOLSA_MONITORIA VARCHAR (1),
IN_BOLSA_PESQUISA VARCHAR (1),
TP_ESCOLA_CONCLUSAO_ENS_MEDIO VARCHAR (1),
IN_ALUNO_PARFOR VARCHAR (1),
TP_SEMESTRE_CONCLUSAO VARCHAR (1),
TP_SEMESTRE_REFERENCIA VARCHAR (1),
IN_MOBILIDADE_ACADEMICA VARCHAR (1),
TP_MOBILIDADE_ACADEMICA VARCHAR (1),
TP_MOBILIDADE_ACADEMICA_INTERN VARCHAR (1),
CO_IES_DESTINO VARCHAR (8),
CO_PAIS_DESTINO VARCHAR (3),
IN_MATRICULA VARCHAR (1),
IN_CONCLUINTE VARCHAR (1),
IN_INGRESSO_TOTAL VARCHAR (1),
IN_INGRESSO_VAGA_NOVA VARCHAR (1),
IN_INGRESSO_PROCESSO_SELETIVO VARCHAR (1),
NU_ANO_INGRESSO VARCHAR (1)
);
/* 
    Dados de alunos de instituições de ensino
    superior obtidos junto ao INEP são carregados
    na tabela IES_2016_ALUNO.
*/
load data local infile 'C:/Users/E003004/Desktop/DM_ALUNO.csv'
into table IES_2017_ALUNO
character set 'latin1'
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;
