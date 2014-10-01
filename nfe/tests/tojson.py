from helpers import csv_to_json

run=''
#C:\Python27-64\python -m nfe.tests.tojson
def main(run):
    fieldnames = ("EconomicAtivity_ID_CNAE_Sender", "Municipality_ID_Receiver", "Municipio", 
                  "Municipality_ID_Sender", "Product_Value")      
    csv_to_json("dados/nfe/NFE_teste_2013_01.csv","dados/nfe/NFE_teste_2013_01.json",fieldnames)      
     
    
   
main(run)