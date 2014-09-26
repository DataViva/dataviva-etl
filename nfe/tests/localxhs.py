from helpers import read_from_csv,df_to_csv,left_df,floatvert,printTime
import pandas as pd
import numpy as np
import time
    
run=''
#C:\Python27-64\python -m nfe.tests.localxhs
def main(run):
    
    
    start=time.time()
    
    
    #Prepare
    bl=openBL()
    start=printTime("openBL",start)
    
    if run=='test':
        #Test Data
        entrada="dados/nfe/testegrande.csv"
        delimiter=','
    else:
    #Full Data
        entrada="dados/nfe/2013_01.csv"
        delimiter=';'
    
    dados=openNFe(entrada,delimiter)   
    start=printTime("openNFe",start) 
    
    dados=mergeNfeBL(dados,bl)
    start=printTime("mergeNfeBL",start)
    

    
    dados=groupBYMunHS(dados) 
    start=printTime("groupBYMunHS",start)    
    
    df_to_csv(dados , "dados/nfe/finalLocalxHSgroup.csv")

    dados=dados.reset_index()
    dados['TransactedProduct_ID_HS'][ dados.corte==1] = 0
    df_to_csv(dados , "dados/nfe/finalLocalxHSAntesDrop.csv")
    dados=dados.drop(['corte','empresas','EconomicAtivity_ID_CNAE_Sender','corte'],1)
    dados=dados.set_index('Municipality_ID_Sender')
    df_to_csv(dados , "dados/nfe/finalLocalxHS.csv")
             
 

def groupBYMunHS(dados):
    dados=dados[['Municipality_ID_Sender','TransactedProduct_ID_HS','EconomicAtivity_ID_CNAE_Sender','Product_Value','empresas','corte']]
    return dados.groupby(['Municipality_ID_Sender','TransactedProduct_ID_HS']).agg({"empresas": np.sum, "Product_Value": np.sum, "corte": np.max, "EconomicAtivity_ID_CNAE_Sender": np.max})
    
  
def openBL():
    orig_cols = ['cod_mun','CNAE 2d','concatenar','empresas','corte']
    bl = read_from_csv("dados/nfe/bl/012013.csv",delimiter=';',cols=orig_cols,header=1)
    bl=bl[['concatenar','empresas','corte']]
    #print bl
    #print "-------------------------"
    return bl
    
def openNFe(entrada,delimiter):
    '''
    TransactedProduct_ID_NCM,TransactedProduct_ID_HS,EconomicAtivity_ID_CNAE_Receiver,
    EconomicAtivity_ID_CNAE_Sender,CFOP_ID,CFOP_Reclassification,CFOP_Flow,Receiver_Type,
    Sender_Type,Municipality_ID_Receiver,Municipality_ID_Sender,Year,Monthly,
    Receiver_Situation,Sender_Situation,Cost_Value,ICMS_ST_Value,ICMS_ST_RET_Value,ICMS_Value,
    IPI_Value,PIS_Value,COFINS_Value,II_Value,Product_Value,ISSQN_Value,Origin
    '''
    
    orig_cols = ['TransactedProduct_ID_NCM','TransactedProduct_ID_HS','EconomicAtivity_ID_CNAE_Receiver','EconomicAtivity_ID_CNAE_Sender','CFOP_ID','CFOP_Reclassification','CFOP_Flow','Sender_Type','Sender_Type','Municipality_ID_Receiver','Municipality_ID_Sender','Year','Monthly','Sender_Situation','Sender_Situation','Cost_Value','ICMS_ST_Value','ICMS_ST_RET_Value','ICMS_Value','IPI_Value','PIS_Value','COFINS_Value','II_Value','Product_Value','ISSQN_Value','Origin']
    converters = {"EconomicAtivity_ID_CNAE_Sender": str, "Municipality_ID_Sender": str, "Product_Value": floatvert}
    
    dados = read_from_csv(entrada,delimiter=delimiter,cols=orig_cols,converters=converters,header=1)
    dados=dados[['EconomicAtivity_ID_CNAE_Sender','TransactedProduct_ID_HS','Municipality_ID_Sender','Product_Value']]

    return dados

def mergeNfeBL(dados,bl):
    
    dados['concatenar']=dados['Municipality_ID_Sender']+dados['EconomicAtivity_ID_CNAE_Sender']
    
    dados=pd.merge( dados,bl, on='concatenar',how='left') #, how='outer'
    
    
    dados=dados[['concatenar','TransactedProduct_ID_HS','Municipality_ID_Sender','EconomicAtivity_ID_CNAE_Sender','Product_Value','empresas','corte']]
    
    return dados

    
    '''
    #dados = dados.set_index('Municipality_ID_Sender','EconomicAtivity_ID_CNAE_Sender')
        #dados=dados[(dados['Municipality_ID_Sender']>3100000) & (dados['Municipality_ID_Sender']<3199999)]

    concatenar,corte,empresas,Product_Value
    316260901,1,1,69.24
    316260911,1,1,900.24
    316260947,0,113,9.44
    
    groupy by concatenar sum empresas
    3162609,1,2
    
    if empresas <3
    first order by Product_Value where corte = 0 -> set corte = 1
    
    tips[tips['corte'] == 0].head(1)
    
    
    
    '''




   
main(run)