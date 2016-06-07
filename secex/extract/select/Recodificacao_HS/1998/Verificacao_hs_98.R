### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1
# Exportacao 1998

exp98 <- read.csv("H:\\secex\\Recodificacao HS\\1998\\hs_98_exp.csv", header=TRUE,colClasses="factor")
names(exp98) <- "hs"
exp98$id98 <- 1

codigos1998 <- merge(dadoshs07,exp98,by="hs",all=TRUE)

subset(codigos1998,is.na(id07)==TRUE)


# Apenas os codigos 9991 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 1998

imp98 <- read.csv("H:\\secex\\Recodificacao HS\\1998\\hs_98_imp.csv", header=TRUE,colClasses="factor")
names(imp98) <- "hs"
imp98$id98 <- 1

imp1998_total <- merge(dadoshs07,imp98,by="hs",all=TRUE)

subset(imp1998_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 1998



