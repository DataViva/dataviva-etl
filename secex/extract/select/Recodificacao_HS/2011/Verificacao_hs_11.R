### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2011

exp11 <- read.csv("H:\\secex\\Recodificacao HS\\2011\\hs_11_exp.csv", header=TRUE,colClasses="factor")
names(exp11) <- "hs"
exp11$id11 <- 1

codigos2011 <- merge(dadoshs07,exp11,by="hs",all=TRUE)

subset(codigos2011,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2011

imp11 <- read.csv("H:\\secex\\Recodificacao HS\\2011\\hs_11_imp.csv", header=TRUE,colClasses="factor")
names(imp11) <- "hs"
imp11$id11 <- 1

imp2011_total <- merge(dadoshs07,imp11,by="hs",all=TRUE)

subset(imp2011_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2011
