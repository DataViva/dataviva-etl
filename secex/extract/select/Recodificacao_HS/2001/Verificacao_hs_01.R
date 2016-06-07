### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1
# Exportacao 2001

exp01 <- read.csv("H:\\secex\\Recodificacao HS\\2001\\hs_01_exp.csv", header=TRUE,colClasses="factor")
names(exp01) <- "hs"
exp01$id01 <- 1

codigos2001 <- merge(dadoshs07,exp01,by="hs",all=TRUE)

subset(codigos2001,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2001

imp01 <- read.csv("H:\\secex\\Recodificacao HS\\2001\\hs_01_imp.csv", header=TRUE,colClasses="factor")
names(imp01) <- "hs"
imp01$id01 <- 1

imp2001_total <- merge(dadoshs07,imp01,by="hs",all=TRUE)

subset(imp2001_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2001
