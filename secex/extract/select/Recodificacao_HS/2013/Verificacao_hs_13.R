### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2013

exp13 <- read.csv("H:\\secex\\Recodificacao HS\\2013\\hs_13_exp.csv", header=TRUE,colClasses="factor")
names(exp13) <- "hs"
exp13$id13 <- 1

codigos2013 <- merge(dadoshs07,exp13,by="hs",all=TRUE)

subset(codigos2013,is.na(id07)==TRUE)


# Os codigos 3826, 9619, 9991, 9992, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2013

imp13 <- read.csv("H:\\secex\\Recodificacao HS\\2013\\hs_13_imp.csv", header=TRUE,colClasses="factor")
names(imp13) <- "hs"
imp13$id13 <- 1

imp2013_total <- merge(dadoshs07,imp13,by="hs",all=TRUE)

subset(imp2013_total,is.na(id07)==TRUE)

# Os códigos 0308 e 9619 não aparecem em 2013
