### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2009

exp09 <- read.csv("H:\\secex\\Recodificacao HS\\2009\\hs_09_exp.csv", header=TRUE,colClasses="factor")
names(exp09) <- "hs"
exp09$id09 <- 1

codigos2009 <- merge(dadoshs07,exp09,by="hs",all=TRUE)

subset(codigos2009,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2009

imp09 <- read.csv("H:\\secex\\Recodificacao HS\\2009\\hs_09_imp.csv", header=TRUE,colClasses="factor")
names(imp09) <- "hs"
imp09$id09 <- 1

imp2009_total <- merge(dadoshs07,imp09,by="hs",all=TRUE)

subset(imp2009_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2009
