### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 1997

exp97 <- read.csv("H:\\secex\\Recodificacao HS\\1997\\hs_97_exp.csv", header=TRUE,colClasses="factor")
names(exp97) <- "hs"
exp97$id97 <- 1

codigos1997 <- merge(dadoshs07,exp97,by="hs",all=TRUE)

subset(codigos1997,is.na(id07)==TRUE)


# Apenas os codigos 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 1997

imp97 <- read.csv("H:\\secex\\Recodificacao HS\\1997\\hs_97_imp.csv", header=TRUE,colClasses="factor")
names(imp97) <- "hs"
imp97$id97 <- 1

imp1997_total <- merge(dadoshs07,imp97,by="hs",all=TRUE)

subset(imp1997_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 1997
