### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2007

exp07 <- read.csv("H:\\secex\\Recodificacao HS\\2007\\hs_07_exp.csv", header=TRUE,colClasses="factor")
names(exp07) <- "hs"
exp07$id071 <- 1

codigos2007 <- merge(dadoshs07,exp07,by="hs",all=TRUE)

subset(codigos2007,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2007

imp07 <- read.csv("H:\\secex\\Recodificacao HS\\2007\\hs_07_imp.csv", header=TRUE,colClasses="factor")
names(imp07) <- "hs"
imp07$id07 <- 1

imp2007_total <- merge(dadoshs07,imp07,by="hs",all=TRUE)

subset(imp2007_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2007
