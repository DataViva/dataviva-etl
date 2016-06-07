### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2008

exp08 <- read.csv("H:\\secex\\Recodificacao HS\\2008\\hs_08_exp.csv", header=TRUE,colClasses="factor")
names(exp08) <- "hs"
exp08$id08 <- 1

codigos2008 <- merge(dadoshs07,exp08,by="hs",all=TRUE)

subset(codigos2008,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2008

imp08 <- read.csv("H:\\secex\\Recodificacao HS\\2008\\hs_08_imp.csv", header=TRUE,colClasses="factor")
names(imp08) <- "hs"
imp08$id08 <- 1

imp2008_total <- merge(dadoshs07,imp08,by="hs",all=TRUE)

subset(imp2008_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2008
