## Select EQUI_2009	

use cnes_equi;

create table EQUI_2009_STEP1
select  cnes, codufmun, regsaude, micr_reg, pf_pj, cpf_cnpj, niv_dep, cnpj_man, esfera_a, retencao, tp_unid, niv_hier, tipequip, codequip, qt_exist, qt_uso, ind_sus, ind_nsus, competen  
from equi_2009;