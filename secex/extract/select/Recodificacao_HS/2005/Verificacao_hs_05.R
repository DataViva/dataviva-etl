### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2005

exp05 <- read.csv("H:\\secex\\Recodificacao HS\\2005\\hs_05_exp.csv", header=TRUE,colClasses="factor")
names(exp05) <- "hs"
exp05$id05 <- 1

codigos2005 <- merge(dadoshs07,exp05,by="hs",all=TRUE)

subset(codigos2005,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2005

imp05 <- read.csv("H:\\secex\\Recodificacao HS\\2005\\hs_05_imp.csv", header=TRUE,colClasses="factor")
names(imp05) <- "hs"
imp05$id05 <- 1

imp2005_total <- merge(dadoshs07,imp05,by="hs",all=TRUE)

subset(imp2005_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2005
