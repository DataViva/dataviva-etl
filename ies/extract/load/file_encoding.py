import magic
# Discover encoding type of file reading fist line
def file_encoding(file_path):
    with open(file_path, 'r') as fp:
        first_line = fp.readline()
    m = magic.Magic(mime_encoding=True, magic_file="magic")
    return m.from_buffer(first_line)