import os, sys, click, magic, codecs, time, itertools, math
from os.path import splitext, basename
from df_to_sql import write_sql

'''

USAGE EXAMPLE:
python ies/extract/load/extract_ALUNO.py ies/extract/data/IES_2009/ALUNO.txt

'''

def input_data(table, tuples, columns, chuncksize):
    start = time.time()
    write_sql(table, tuples, columns, chuncksize)
    print "%s minutes to insert" % str((time.time() - start)/60)
    tuples = []

@click.command()
@click.argument('file_path', type=click.Path(exists=True), required=True)
def main(file_path):
    #Set table by file_path
    file_name = basename(file_path)
    file_desc, file_ext = splitext(file_name)
    folder = file_path.split('/')[-2]
    table = folder+'_'+file_desc

    # Discover encoding type of file reading fist line
    with open(file_path, 'r') as fp:
        first_line = fp.readline()
    m = magic.Magic(mime_encoding=True)
    encoding = m.from_buffer(first_line)

    # Set encoding to this python file
    reload(sys)
    sys.setdefaultencoding(encoding)

    tuples = []
    columns = ['CO_IES', 'CO_CATEGORIA_ADMINISTRATIVA', 'DS_CATEGORIA_ADMINISTRATIVA', 'CO_ORGANIZACAO_ACADEMICA', 'NO_ORGANIZACAO_ACADEMICA', 'CO_CURSO', 'NO_CURSO', 'CO_VINCULO_ALUNO', 'CO_ALUNOS_CURSO', 'CO_ALUNO_SITUACAO', 'CO_GRAU_ACADEMICO', 'CO_MODALIDADE_ENSINO', 'CO_NIVEL_ACADEMICO', 'IN_MATRICULA', 'IN_CONCLUINTE', 'IN_INGRESSO', 'ANO_INGRESSO', 'DT_INGRESSO_CURSO', 'IN_ING_PROCESSO_SELETIVO', 'IN_ING_VESTIBULAR', 'IN_ING_ENEM', 'IN_ING_OUTRA_FORMA_SELECAO', 'IN_ING_PROCESSO_OUTRAS_FORMAS', 'IN_ING_CONVENIO_PEC_G', 'IN_ING_OUTRAS_FORMAS_INGRESSO', 'CO_NACIONALIDADE_ALUNO', 'CO_PAIS_ORIGEM_ALUNO', 'IN_SEXO_ALUNO', 'NU_ANO_ALUNO_NASC', 'NU_MES_ALUNO_NASC', 'NU_DIA_ALUNO_NASC', 'NU_IDADE_ALUNO', 'CO_COR_RACA_ALUNO', 'IN_ALUNO_DEFICIENCIA', 'IN_CEGUEIRA', 'IN_BAIXA_VISAO', 'IN_SURDEZ', 'IN_DEF_AUDITIVA', 'IN_DEF_FISICA', 'IN_SURDOCEGUEIRA', 'IN_DEF_MULTIPLA', 'IN_DEF_MENTAL', 'IN_APOIO_SOCIAL', 'IN_APOIO_ALIMENTACAO', 'IN_APOIO_MORADIA', 'IN_APOIO_TRANSPORTE', 'IN_APOIO_MATERIAL_DIDATICO', 'IN_ATIVIDADE_COMPLEMENTAR', 'IN_APOIO_BOLSA_TRABALHO', 'IN_APOIO_BOLSA_PERMANENCIA', 'IN_FINANC_ESTUDANTIL', 'IN_FINANC_EXTERNAS', 'IN_FINANC_EXTERNAS_REEMB', 'IN_FINANC_IES', 'IN_FINANC_IES_REEMB', 'IN_FINANC_MUNICIPAL', 'IN_FINANC_MUNICIPAL_REEMB', 'IN_FINANC_OUTROS', 'IN_FINANC_OUTROS_REEMB', 'IN_FINANC_ESTADUAL', 'IN_FINANC_ESTADUAL_REEMB', 'IN_PROUNI_INTEGRAL', 'IN_PROUNI_PARCIAL', 'IN_FIES', 'IN_RESERVA_VAGAS', 'IN_RESERVA_ENSINO_PUBLICO', 'IN_RESERVA_ETNICO', 'IN_RESERVA_DEFICIENCIA', 'IN_RESERVA_RENDA_FAMILIAR', 'IN_RESERVA_OUTROS', 'IN_ATIV_PESQUISA_REM', 'IN_ATIV_PESQUISA_NAO_REM', 'IN_ATIV_EXTENSAO_REM', 'IN_ATIV_EXTENSAO_NAO_REM', 'IN_ATIV_MONITORIA_REM', 'IN_ATIV_MONITORIA_NAO_REM', 'IN_ATIV_ESTAG_N_OBRIG_REM', 'IN_ATIV_ESTAG_N_OBRIG_NAO_REM']

    chuncksize = 10000
    block_size = 1000000

    with codecs.open(file_path, mode='r', encoding=encoding) as fp:
        for line in fp:
            row = (
                line[0:8],
                line[8:16],
                line[16:66],
                line[66:74],
                line[74:174],
                line[174:182],
                line[182:382],
                line[382:390],
                line[390:403],
                line[403:411],
                line[411:419],
                line[419:427],
                line[427:435],
                line[435:443],
                line[443:451],
                line[451:459],
                line[459:467],
                line[467:475],
                line[475:483],
                line[483:491],
                line[491:499],
                line[499:507],
                line[507:515],
                line[515:523],
                line[523:531],
                line[531:539],
                line[539:547],
                line[547:555],
                line[555:563],
                line[563:571],
                line[571:579],
                line[579:587],
                line[587:595],
                line[595:603],
                line[603:611],
                line[611:619],
                line[619:627],
                line[627:635],
                line[635:643],
                line[643:651],
                line[651:659],
                line[659:667],
                line[667:675],
                line[675:683],
                line[683:691],
                line[691:699],
                line[699:707],
                line[707:715],
                line[715:723],
                line[723:731],
                line[731:739],
                line[739:747],
                line[747:755],
                line[755:763],
                line[763:771],
                line[771:779],
                line[779:787],
                line[787:795],
                line[795:803],
                line[803:811],
                line[811:819],
                line[819:827],
                line[827:835],
                line[835:843],
                line[843:851],
                line[851:859],
                line[859:867],
                line[867:875],
                line[875:883],
                line[883:891],
                line[891:899],
                line[899:907],
                line[907:915],
                line[915:923],
                line[923:931],
                line[931:939],
                line[939:947],
                line[947:955]
            )

            tuples.append(tuple([None if not str(x).strip() else x for x in row]))

            if sys.getsizeof(tuples) > block_size:
                input_data(table, tuples, columns, chuncksize)
                tuples = []

    input_data(table, tuples, columns, chuncksize)
        
if __name__ == "__main__":
    main()