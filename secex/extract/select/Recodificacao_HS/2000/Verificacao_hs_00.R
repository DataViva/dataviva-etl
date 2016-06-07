### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1
# Exportacao 2000

exp00 <- read.csv("H:\\secex\\Recodificacao HS\\2000\\hs_00_exp.csv", header=TRUE,colClasses="factor")
names(exp00) <- "hs"
exp00$id00 <- 1

codigos2000 <- merge(dadoshs07,exp00,by="hs",all=TRUE)

subset(codigos2000,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2000

imp00 <- read.csv("H:\\secex\\Recodificacao HS\\2000\\hs_00_imp.csv", header=TRUE,colClasses="factor")
names(imp00) <- "hs"
imp00$id00 <- 1

imp2000_total <- merge(dadoshs07,imp00,by="hs",all=TRUE)

subset(imp2000_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2000
