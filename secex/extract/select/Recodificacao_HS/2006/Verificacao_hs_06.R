### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2006

exp06 <- read.csv("H:\\secex\\Recodificacao HS\\2006\\hs_06_exp.csv", header=TRUE,colClasses="factor")
names(exp06) <- "hs"
exp06$id06 <- 1

codigos2006 <- merge(dadoshs07,exp06,by="hs",all=TRUE)

subset(codigos2006,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2004

imp06 <- read.csv("H:\\secex\\Recodificacao HS\\2006\\hs_06_imp.csv", header=TRUE,colClasses="factor")
names(imp06) <- "hs"
imp06$id06 <- 1

imp2006_total <- merge(dadoshs07,imp06,by="hs",all=TRUE)

subset(imp2006_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2006
