-- load data local infile '/Users/r13/Documents/attrs_stat.txt'
load data local infile './static_tables/load/attrs_stat.txt'
into table teste_table
fields terminated by '|'
lines terminated by '\n'
ignore 1 lines;     