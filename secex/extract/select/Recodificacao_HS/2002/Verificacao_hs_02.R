### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1
# Exportacao 2001

exp02 <- read.csv("H:\\secex\\Recodificacao HS\\2002\\hs_02_exp.csv", header=TRUE,colClasses="factor")
names(exp02) <- "hs"
exp02$id02 <- 1

codigos2002 <- merge(dadoshs07,exp02,by="hs",all=TRUE)

subset(codigos2002,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9992, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2002

imp02 <- read.csv("H:\\secex\\Recodificacao HS\\2002\\hs_02_imp.csv", header=TRUE,colClasses="factor")
names(imp02) <- "hs"
imp02$id02 <- 1

imp2002_total <- merge(dadoshs07,imp02,by="hs",all=TRUE)

subset(imp2002_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2002
