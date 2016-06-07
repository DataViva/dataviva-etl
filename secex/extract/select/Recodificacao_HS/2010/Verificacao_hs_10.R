### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportacao 2010

exp10 <- read.csv("H:\\secex\\Recodificacao HS\\2010\\hs_10_exp.csv", header=TRUE,colClasses="factor")
names(exp10) <- "hs"
exp10$id10 <- 1

codigos2010 <- merge(dadoshs07,exp10,by="hs",all=TRUE)

subset(codigos2010,is.na(id07)==TRUE)


# Apenas os codigos 9991, 9997 e 9998 não aparecem em 2007
# Corrigir no SQL

# Importacao 2010

imp10 <- read.csv("H:\\secex\\Recodificacao HS\\2010\\hs_10_imp.csv", header=TRUE,colClasses="factor")
names(imp10) <- "hs"
imp10$id10 <- 1

imp2010_total <- merge(dadoshs07,imp10,by="hs",all=TRUE)

subset(imp2010_total,is.na(id07)==TRUE)

# Tudo OK com Importacao 2010
