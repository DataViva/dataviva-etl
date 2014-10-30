#DataViva ETL

Extract / Transform / Load Scripts  for databases used in [Dataviva Project](http://www.dataviva.info).

The sources of Dataviva can be found at [Dataviva GitHub](https://github.com/DataViva/dataviva-site).

##How it Works

Databases are released by Brazil government as raw data and there is some analysis to extract the information needed for the project.

For each database we have a Wiki documentation that explain all the ETL process and Qlikview as a BI tool to make this process.

##Tests

each database has a folder with a file called "test.py", file can be test with the command:

```python
python -m unittest {{FOLDER}}.check.test
```



See the [Wiki](https://github.com/DataViva/datavivaetl/wiki) for more information.
