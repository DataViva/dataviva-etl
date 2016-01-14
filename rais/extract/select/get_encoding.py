import click, magic

'''

USAGE EXAMPLE:
python rais/extract/select/get_encoding.py data/RAIS_2002/RAIS2002TOTAL.TXT

'''

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    # Discover encoding type of file
    with open(file_path, 'r') as fp:
        first_line = fp.readline()
    m = magic.Magic(mime_encoding=True)
    print m.from_buffer(first_line)


if __name__ == "__main__":
    main()