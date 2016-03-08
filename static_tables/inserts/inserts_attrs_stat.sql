use dataviva_client;

-- OCUPAÇÃO E ATIVIDADES ECONÔMICAS 

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("wage_avg", NULL, NULL,"Renda Média Mensal", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("wage", NULL, NULL,"Massa Salarial", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("num_jobs", NULL, NULL,"Total de Empregos", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("num_est", NULL, NULL,"Estabelecimentos", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_employment", NULL, NULL,"Principal Município por empregos", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_monthly_wage", NULL, NULL,"Município com maior renda média mensal", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("industy_highest_jobs", NULL, NULL,"Atividade com maior renda média mensal", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("industy_highest_monthly_wage", NULL, NULL,"Principal Atividade por Empregos", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("rca", NULL, NULL,"RCA", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("distance", NULL, NULL,"Distância", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("opp_gain", NULL, NULL,"Ganho de Oportunidade", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("occupation_highest_jobs", NULL, NULL,"Ocupação com maior número de empregos", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("occupation_highest_monthly_wage", NULL, NULL,"Ocupação com maior renda média mensal", NULL, NULL, NULL);


-- PRODUTOS E PARCEIROS COMERCIAIS

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("trade_balance", NULL, NULL,"Saldo da Balança Comercial", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("export_val", NULL, NULL,"Valor Total Exportado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("weight_value_export", NULL, NULL,"Relação Peso Líquido(kg)/Valor Total Exportado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("import_val", NULL, NULL,"Valor Total Importado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("weight_value_import", NULL, NULL,"Relação Peso Líquido(kg)/Valor Total Importado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_export", NULL, NULL,"Principal Município por valor total exportado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_import", NULL, NULL,"Principal Município por valor total importado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_product_export", NULL, NULL,"Principal Produto por valor total exportado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_product_import", NULL, NULL,"Principal Produto por valor total importado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("product_higher_trade_balance", NULL, NULL,"Produto com maior Saldo da Balança Comercial", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("product_lower_trade_balance", NULL, NULL," Produto com menor Saldo da Balança Comercial", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_export_destiny", NULL, NULL,"Principal Destino por valor total exportado", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_import_origin", NULL, NULL,"Principal Origem por valor total importado", NULL, NULL, NULL);


-- UNIVERSIDADES, CURSOS DE ENSINO SUPERIOR, EDUCAÇÃO BÁSICA E ENSINO TÉCNICO

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("enrollment", NULL, NULL,"Número de Matrículas", NULL,NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("entrant", NULL, NULL,"Número de Ingressantes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("graduates", NULL, NULL,"Número de Concluintes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_course_enrollment", NULL, NULL,"Principal Curso por Número de Alunos Matriculados", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_course_entrant", NULL, NULL,"Principal Curso por Número de Alunos Ingressantes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_course_graduates", NULL, NULL,"Principal Curso por Número de Alunos Concluintes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_enrollment", NULL, NULL,"Principal Município por Número de Alunos Matriculados", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_entrant", NULL, NULL,"Principal Município por Número de Alunos Ingressantes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_municipality_graduates", NULL, NULL,"Principal Município por Número de Alunos Concluintes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_university_enrollment", NULL, NULL,"Principal Universidade por Número de Alunos Matriculados", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_university_entrant", NULL, NULL,"Principal Universidade por Número de Alunos Ingressantes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_university_graduates", NULL, NULL,"Principal Universidade por Número de Alunos Concluintes", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("classes", NULL, NULL,"Número de Turmas", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("school", NULL, NULL,"Número de Escolas", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("average_class_size", NULL, NULL,"Tamanho Médio das Turmas", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("average_age", NULL, NULL,"Idade Média", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_school_enrollment", NULL, NULL,"Principal Escola por Número de Alunos Matriculados", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("economic_complexity_index", NULL, NULL,"Índice de Complexidade Econômica", NULL, NULL, NULL);


-- LOCATIONS

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("industy_less_distance", NULL, NULL,"Atividade Econômica com menor distância", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("product_less_distance", NULL, NULL,"Produto com menor distância", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("product_highest_opp_gain", NULL, NULL,"Produto com maior ganho de oportunidade", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("industy_opp_gain", NULL, NULL,"Atividade Econômica com maior ganho de oportunidade", NULL, NULL, NULL);

INSERT INTO attrs_stat (id, name_en,desc_en, name_pt, desc_pt, plural_pt, article_pt)
VALUES ("top_course_enrollments", NULL, NULL,"Principal Curso por Número de Alunos Matriculados", NULL, NULL, NULL);





