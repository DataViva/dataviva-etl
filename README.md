#DataViva ETL

Extract / Transform / Load Scripts  for databases used in [Dataviva Project](http://www.dataviva.info).

The sources of Dataviva can be found at [Dataviva GitHub](https://github.com/DataViva/dataviva-site).

##How it Works

Databases are released by Brazil government as raw data and there is some analysis to extract the information needed for the project.

For each database we have a Wiki documentation that explain all the ETL process.

##Setup

1. You'll need [libmagic](https://github.com/threatstack/libmagic) for this project:

Mac installation

```bash
brew install libmagic
```

Ubuntu (BSD Linux) installation

```bash
apt-get install libmagic
```
2. Install requirements

```bash
pip install -r requirements.txt
```

See the [Wiki](https://github.com/DataViva/datavivaetl/wiki) for more information.
