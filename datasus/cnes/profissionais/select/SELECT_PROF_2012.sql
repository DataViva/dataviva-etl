#SELECT PROFISSIONAIS

use cnes_profissionais;

create table PROF_2012_STEP1
select cnes, codufmun, regsaude, micr_reg, pf_pj, cpf_cnpj, niv_dep, cnpj_man, esfera_a, retencao, tp_unid, niv_hier, cbo, cbounico,
cns_prof, vinculac, vincul_c, vincul_a, vincul_n, prof_sus, profnsus, horaoutr, horahosp, hora_amb, competen, ufmunres
from prof_2012;