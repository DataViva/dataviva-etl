CREATE TABLE `dataviva_client`.`stat_ybi`(
    `year` varchar(4),
    `bra_id` varchar(9),
    `cnae_id` varchar(6),
    `wage` float,
    `num_jobs` int(9),
    `num_est` int(9),
    `wage_avg` float(18,2),
    `rca` float(18,2),
    `distance` float(18,2),
    `opp_gain` float(18,2));

CREATE TABLE `dataviva_client`.`stat_ybsc` (
  `year` YEAR NOT NULL COMMENT '',
  `bra_id` VARCHAR(11) NULL COMMENT '',
  `course_sc_id` VARCHAR(9) NULL COMMENT '',
  `enrollments` INT(10) NULL COMMENT '',
  `classes` INT(10) NULL COMMENT '',
  `total_school` INT(9) NULL COMMENT '',
  `average_class_size` DECIMAL(8,3) NULL COMMENT '',
  `average_age` DECIMAL(8,3) NULL COMMENT '',
  `top_school_enrollments` INT(11) NULL COMMENT '',
  `school_enrollments` INT(10) NULL COMMENT '',
  `top_municipality_enrollments` VARCHAR(11) NULL COMMENT '',
  `municipality_enrollments` INT(10) NULL COMMENT '');

CREATE TABLE `dataviva_client`.`stat_ybhedu` (
  `year` YEAR NOT NULL COMMENT '',
  `bra_id` VARCHAR(11) NULL COMMENT '',
  `course_hedu_id` VARCHAR(9) NULL COMMENT '',
  `enrollments` INT(11) NULL COMMENT '',
  `entrants` INT(11) NULL COMMENT '',
  `graduates` INT(11) NULL COMMENT '',
  `top_university_enrollments` VARCHAR(8) NULL COMMENT '',
  `university_enrollments` INT(10) NULL COMMENT '',
  `top_municipality_enrollments` VARCHAR(11) NULL COMMENT '',
  `municipality_enrollments` INT(10) NULL COMMENT '',
  `top_university_entrants` VARCHAR(8) NULL COMMENT '',
  `university_entrants` INT(10) NULL COMMENT '',
  `top_municipality_entrants` VARCHAR(11) NULL COMMENT '',
  `municipality_entrants` INT(10) NULL COMMENT '',
  `top_university_graduates` VARCHAR(8) NULL COMMENT '',
  `university_graduates` INT(10) NULL COMMENT '',
  `top_municipality_graduates` VARCHAR(11) NULL COMMENT '',
  `municipality_graduates` INT(10) NULL COMMENT '');

CREATE TABLE `dataviva_client`.`stat_ybu` (
  `year` YEAR NOT NULL COMMENT '',
  `bra_id` VARCHAR(11) NULL COMMENT '',
  `university_id` VARCHAR(9) NULL COMMENT '',
  `enrollments` INT(10) NULL COMMENT '',
  `entrants` INT(10) NULL COMMENT '',
  `graduates` INT(10) NULL COMMENT '',
  `top_course_enrollments` VARCHAR(9) NULL COMMENT '',
  `course_enrollments` INT(10) NULL COMMENT '',
  `top_course_entrants` VARCHAR(9) NULL COMMENT '',
  `course_entrants` INT(10) NULL COMMENT '',
  `top_course_graduates` VARCHAR(9) NULL COMMENT '',
  `course_graduates` INT(10) NULL COMMENT '');