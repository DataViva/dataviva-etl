### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2004

exp04 <- read.csv("H:\\secex\\Recodificacao HS\\2004\\hs_04_exp.csv", header=TRUE,colClasses="factor")
names(exp04) <- "hs"
exp04$id04 <- 1

codigos2004 <- merge(dadoshs07,exp04,by="hs",all=TRUE)

subset(codigos2004,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2004

imp04 <- read.csv("H:\\secex\\Recodificacao HS\\2004\\hs_04_imp.csv", header=TRUE,colClasses="factor")
names(imp04) <- "hs"
imp04$id04 <- 1

imp2004_total <- merge(dadoshs07,imp04,by="hs",all=TRUE)

subset(imp2004_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2004
