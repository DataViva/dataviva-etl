create table stat_ybi(
    year varchar(4),
    bra_id varchar(9),
    cnae_id varchar(6),
    wage float,
    num_jobs int,
    num_est int,
    wage_avg float,
    rca float,
    distance float,
    opp_gain float
);

CREATE TABLE `dataviva_client`.`stat_yb` (
  `year` YEAR NOT NULL COMMENT '',
  `bra_id` VARCHAR(45) NULL COMMENT '',
  `course_sc_id` VARCHAR(45) NULL COMMENT '',
  `course_enrollemnts` INT NULL COMMENT '',
  `classes` INT NULL COMMENT '',
  `total_school` INT NULL COMMENT '',
  `average_class_size` DECIMAL NULL COMMENT '',
  `average_age` DECIMAL NULL COMMENT '',
  `top_school_enrollments` VARCHAR(45) NULL COMMENT '',
  `school_enrollments` INT NULL COMMENT '',
  `top_municipality_enrollments` VARCHAR(255) NULL COMMENT '',
  `municipality_enrollments` VARCHAR(255) NULL COMMENT '');

CREATE TABLE `dataviva_client`.`stat_ybhedu` (
  `year` YEAR NOT NULL COMMENT '',
  `bra_id` VARCHAR(45) NULL COMMENT '',
  `course_hedu_id` VARCHAR(45) NULL COMMENT '',
  `enrollemnts` INT NULL COMMENT '',
  `entrants` INT NULL COMMENT '',
  `graduates` INT NULL COMMENT '',
  `top_university_enrollments` VARCHAR (255) NULL COMMENT '',
  `university_enrollments` INT NULL COMMENT '',
  `top_municipality_enrollments` VARCHAR(255) NULL COMMENT '',
  `municipality_enrollments` INT NULL COMMENT '',
  `top_university_entrants` VARCHAR (255) NULL COMMENT '',
  `university_entrants` INT NULL COMMENT '',
  `top_municipality_entrants` VARCHAR(255) NULL COMMENT '',
  `municipality_entrants` INT NULL COMMENT '',
  `top_university_graduates` VARCHAR (255) NULL COMMENT '',
  `university_graduates` INT NULL COMMENT '',
  `top_municipality_graduates` VARCHAR(255) NULL COMMENT '',
  `municipality_graduates` INT NULL COMMENT '');