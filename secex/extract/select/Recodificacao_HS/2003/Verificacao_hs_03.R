### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1
# Exportacao 2003

exp03 <- read.csv("H:\\secex\\Recodificacao HS\\2003\\hs_03_exp.csv", header=TRUE,colClasses="factor")
names(exp03) <- "hs"
exp03$id03 <- 1

codigos2003 <- merge(dadoshs07,exp03,by="hs",all=TRUE)

subset(codigos2003,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2002

imp03 <- read.csv("H:\\secex\\Recodificacao HS\\2003\\hs_03_imp.csv", header=TRUE,colClasses="factor")
names(imp03) <- "hs"
imp03$id03 <- 1

imp2003_total <- merge(dadoshs07,imp03,by="hs",all=TRUE)

subset(imp2003_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2003
