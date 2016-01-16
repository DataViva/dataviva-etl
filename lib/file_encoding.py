import magic

#Discover encoding type of file reading fist line
def file_encoding(file_path):
    with open(file_path, 'r') as fp:
        first_line = fp.readline()
    m = magic.Magic(mime_encoding=True)
    return m.from_buffer(first_line)

    #Some files need to be fully read to discover right encoding.
    #In this cases use the following code:
    #Discover encoding type of file
    #fp = open(file_path).read()
    #m = magic.Magic(mime_encoding=True)
    #return m.from_buffer(fp)