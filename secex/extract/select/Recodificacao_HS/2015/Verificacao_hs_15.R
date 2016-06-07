### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2014

exp15 <- read.csv("H:\\secex\\Recodificacao HS\\2015\\hs_15_exp.csv", header=TRUE,colClasses="factor")
names(exp15) <- "hs"
exp15$id15 <- 1

codigos2015 <- merge(dadoshs07,exp15,by="hs",all=TRUE)

subset(codigos2015,is.na(id07)==TRUE)

# Corrigir no SQL

# Importacao 2015

imp15 <- read.csv("H:\\secex\\Recodificacao HS\\2015\\hs_15_imp.csv", header=TRUE,colClasses="factor")
names(imp15) <- "hs"
imp15$id15 <- 1

imp2015_total <- merge(dadoshs07,imp15,by="hs",all=TRUE)

subset(imp2015_total,is.na(id07)==TRUE)

# Os códigos 0308 e 9619 não aparecem em 2013
