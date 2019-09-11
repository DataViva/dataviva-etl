#!/bin/bash


# Export final table 
mysqldump -h <database_host> -u dataviva -p --database=dataviva attrs_ybs > attrs_ybs.sql

# Import to destination host
mysql -h <database_host> -u dataviva -p --database=dataviva  < attrs_ybs.sql