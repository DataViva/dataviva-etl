import click, magic

'''

USAGE EXAMPLE:
python rais/extract/select/get_encoding.py ies/extract/data/RAIS_2002/RAIS2002TOTAL.TXT

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    # Discover encoding type of file
    blob = open(file_path).read()
    m = magic.Magic(mime_encoding=True)
    print m.from_buffer(blob)


if __name__ == "__main__":
    main()