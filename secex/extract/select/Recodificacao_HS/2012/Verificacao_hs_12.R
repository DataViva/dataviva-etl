### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2012

exp13 <- read.csv("H:\\secex\\Recodificacao HS\\2013\\hs_13_exp.csv", header=TRUE,colClasses="factor")
names(exp13) <- "hs"
exp13$id13 <- 1

codigos2013 <- merge(dadoshs07,exp13,by="hs",all=TRUE)

subset(codigos2013,is.na(id07)==TRUE)


# Os codigos 3826, 9619, 9991, 9992, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2012

imp12 <- read.csv("H:\\secex\\Recodificacao HS\\2012\\hs_12_imp.csv", header=TRUE,colClasses="factor")
names(imp12) <- "hs"
imp12$id12 <- 1

imp2012_total <- merge(dadoshs07,imp12,by="hs",all=TRUE)

subset(imp2012_total,is.na(id07)==TRUE)

# Os códigos 0308 e 9619 não aparecem em 2012
