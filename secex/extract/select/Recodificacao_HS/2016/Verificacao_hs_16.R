### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("Z:\\secex\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2016

exp16 <- read.csv("Z:\\secex\\hs_16_exp.csv", header=TRUE,colClasses="factor")
names(exp16) <- "hs"
exp16$id16 <- 1

codigos2016 <- merge(dadoshs07,exp16,by="hs",all=TRUE)

subset(codigos2016,is.na(id07)==TRUE)

# Corrigir no SQL

# Importacao 2015

imp16<- read.csv("Z:\\secex\\hs_16_imp.csv", header=TRUE,colClasses="factor")
names(imp16) <- "hs"
imp16$id16 <- 1

imp2016_total <- merge(dadoshs07,imp16,by="hs",all=TRUE)

subset(imp2016_total,is.na(id07)==TRUE)

# Os códigos 0308 e 9619 não aparecem em 2013
