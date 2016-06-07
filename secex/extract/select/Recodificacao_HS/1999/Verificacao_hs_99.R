### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1
# Exportacao 1999

exp99 <- read.csv("H:\\secex\\Recodificacao HS\\1999\\hs_99_exp.csv", header=TRUE,colClasses="factor")
names(exp99) <- "hs"
exp99$id99 <- 1

codigos1999 <- merge(dadoshs07,exp99,by="hs",all=TRUE)

subset(codigos1999,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 1999

imp99 <- read.csv("H:\\secex\\Recodificacao HS\\1999\\hs_99_imp.csv", header=TRUE,colClasses="factor")
names(imp99) <- "hs"
imp99$id99 <- 1

imp1999_total <- merge(dadoshs07,imp99,by="hs",all=TRUE)

subset(imp1999_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 1999
