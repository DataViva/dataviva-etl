### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2014

exp14 <- read.csv("H:\\secex\\Recodificacao HS\\2014\\hs_14_exp.csv", header=TRUE,colClasses="factor")
names(exp14) <- "hs"
exp14$id14 <- 1

codigos2014 <- merge(dadoshs07,exp14,by="hs",all=TRUE)

subset(codigos2014,is.na(id07)==TRUE)


# Os codigos 3826, 9619, 9991, 9992, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2014

imp14 <- read.csv("H:\\secex\\Recodificacao HS\\2014\\hs_14_imp.csv", header=TRUE,colClasses="factor")
names(imp14) <- "hs"
imp14$id14 <- 1

imp2014_total <- merge(dadoshs07,imp14,by="hs",all=TRUE)

subset(imp2014_total,is.na(id07)==TRUE)

# Os códigos 0308 e 9619 não aparecem em 2013
