#SELECT LEITOS

use cnes_leitos;

create table LEITOS_2009_STEP1
select cnes, codufmun, regsaude, micr_reg, pf_pj, cpf_cnpj, niv_dep, cnpj_man, esfera_a, retencao, tp_unid, niv_hier, tp_leito, codleito, qt_exist, qt_contr, qt_sus, qt_nsus, competen
from leitos_2009;


