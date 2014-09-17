from helpers import read_from_csv,df_to_csv,left_df,floatvert
import pandas as pd
import numpy as np


def main():
    #Prepare
    bl=openBL()
    entrada="dados/nfe/teste.csv"
    delimiter=','
    
    entrada="dados/nfe/2013_01.csv"
    delimiter=';'
    
    dados=openNFe(entrada,delimiter)    
    dados=mergeNfeBL(dados,bl)
        
    
    dados=groupBYMunCNAE(dados) 
    dadosSave=dados.drop(['corte','empresas'],1)
    df_to_csv(dadosSave , "dados/nfe/finalgroup.csv")
    #dadosSave.to_json("dados/nfe/finalgroup.json")
    
    dadosNovoBL=novoCorte(dados)
    dadosNovoBL = marcarCorteMenorFaturamento(dadosNovoBL)
    
    
    dadosFinal = corteFinal(dados,dadosNovoBL)
    
    dadosFinal['EconomicAtivity_ID_CNAE_Receiver'][ dadosFinal.cortar==1] = 0
    dadosFinal=dadosFinal.drop(['corte','empresas','cortar','cortefinal'],1)
    dadosFinal=dadosFinal.set_index('Municipality_ID_Receiver')
    df_to_csv(dadosFinal , "dados/nfe/final.csv")
    #dadosFinal.to_json("dados/nfe/final.json")
             
    
def corteFinal(dados,dadosNovoBL):    

    dados=dados.reset_index()
    dadosFinal=pd.merge( dados,dadosNovoBL, on=['Municipality_ID_Receiver','EconomicAtivity_ID_CNAE_Receiver'], how='left') 
    dadosFinal['cortar']=0
    dadosFinal['cortar'][ dadosFinal.corte==1.0] = 1
    dadosFinal['cortar'][ dadosFinal.cortefinal==1.0] = 1
    #dadosFinal['cortar']=1
    #dadosFinal=dadosFinal.drop(["corte_x","empresas_x","corte_y",'empresas_y'],1)
    return dadosFinal
    #,Municipality_ID_Receiver,EconomicAtivity_ID_CNAE_Receiver,corte_x,empresas_x,Product_Value_x,corte_y,empresas_y,Product_Value_y,cortenovo,cortefinal,cortar
    
        
def marcarCorteMenorFaturamento(dadosNovoBL):
    dadosNovoBL=dadosNovoBL.sort(['Product_Value'],ascending=[1])
    dadosNovoBL=dadosNovoBL.groupby(['Municipality_ID_Receiver']).first()
    dadosNovoBL['cortefinal']=1
    dadosNovoBL=dadosNovoBL.reset_index()        
    dadosNovoBL=dadosNovoBL.drop(["empresas","cortenovo","Product_Value","corte"],1)
    return dadosNovoBL

       
def novoCorte(dados):
    dadosEmp=menosEmpresas(dados)  
    
    dados=dados.reset_index()

    dadosNovoBL=pd.merge( dados,dadosEmp, on='Municipality_ID_Receiver')    
    return dadosNovoBL

def menosEmpresas(dadosNovo):
    dadosMun=dadosNovo[['empresas','corte']]
    dadosMun=dadosMun[(dadosMun['corte']==1)]
    dadosMun = dadosMun.groupby(level=['Municipality_ID_Receiver']).agg({"empresas": np.sum})    
    dadosMun = dadosMun[(dadosMun['empresas']<3)]
    dadosMun['cortenovo']=1
    
    dadosMun=dadosMun.drop('empresas', 1)
    return dadosMun.reset_index()

def groupBYMunCNAE(dados):
    dados=dados[['Municipality_ID_Receiver','EconomicAtivity_ID_CNAE_Receiver','Product_Value','empresas','corte']]
    return dados.groupby(['Municipality_ID_Receiver','EconomicAtivity_ID_CNAE_Receiver']).agg({"empresas": np.sum, "Product_Value": np.sum, "corte": np.max})
    
  
def openBL():
    orig_cols = ['cod_mun','CNAE 2d','concatenar','empresas','corte']
    bl = read_from_csv("dados/nfe/bl/012013.csv",delimiter=';',cols=orig_cols,header=1)
    bl=bl[['concatenar','empresas','corte']]
    #print bl
    #print "-------------------------"
    return bl
    
def openNFe(entrada,delimiter):
    
    orig_cols = ['TransactedProduct_ID_NCM','TransactedProduct_ID_HS','EconomicAtivity_ID_CNAE_Receiver','EconomicAtivity_ID_CNAE_Sender','CFOP_ID','CFOP_Reclassification','CFOP_Flow','Receiver_Type','Sender_Type','Municipality_ID_Receiver','Municipality_ID_Sender','Year','Monthly','Receiver_Situation','Sender_Situation','Cost_Value','ICMS_ST_Value','ICMS_ST_RET_Value','ICMS_Value','IPI_Value','PIS_Value','COFINS_Value','II_Value','Product_Value','ISSQN_Value','Origin']
    converters = {"EconomicAtivity_ID_CNAE_Receiver": str, "Municipality_ID_Receiver": str, "Product_Value": floatvert}
    
    dados = read_from_csv(entrada,delimiter=delimiter,cols=orig_cols,converters=converters,header=1)
    dados=dados[['EconomicAtivity_ID_CNAE_Receiver','Municipality_ID_Receiver','Product_Value']]
    
    dados['EconomicAtivity_ID_CNAE_Receiver'][ dados.EconomicAtivity_ID_CNAE_Receiver=='1'] = 0
    dados['EconomicAtivity_ID_CNAE_Receiver'][ dados.EconomicAtivity_ID_CNAE_Receiver=='2'] = 0
    #dados.EconomicAtivity_ID_CNAE_Receiver = dados.EconomicAtivity_ID_CNAE_Receiver.apply(lambda x: str(x).zfill(2))
    dados = left_df(dados,'EconomicAtivity_ID_CNAE_Receiver',2) 
    return dados

def mergeNfeBL(dados,bl):
        
    dados['concatenar']=dados['Municipality_ID_Receiver']+dados['EconomicAtivity_ID_CNAE_Receiver']
    
    dados=pd.merge( dados,bl, on='concatenar',how='left') #, how='outer'
    
    
    dados=dados[['concatenar','Municipality_ID_Receiver','EconomicAtivity_ID_CNAE_Receiver','Product_Value','empresas','corte']]
    
    return dados

    
    '''
    #dados = dados.set_index('Municipality_ID_Receiver','EconomicAtivity_ID_CNAE_Receiver')
        #dados=dados[(dados['Municipality_ID_Receiver']>3100000) & (dados['Municipality_ID_Receiver']<3199999)]

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




   
main()