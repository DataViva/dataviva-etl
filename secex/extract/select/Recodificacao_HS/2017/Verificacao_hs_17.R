### Recodificação HS

rm(list = ls(all = TRUE))

dadoshs07 <- read.csv("hs_2007.csv", header = TRUE, colClasses = "factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# Exportação 2017

exp17 <- read.csv("hs_17_exp.csv", header = TRUE, colClasses = "factor")
names(exp17) <- "hs"
exp17$id17 <- 1

codigos_exp_2017 <- merge(dadoshs07, exp17, by = "hs", all = TRUE)

subset(codigos_exp_2017, is.na(id07) == TRUE)

# Importação 2017

imp17 <- read.csv("hs_17_imp.csv", header = TRUE, colClasses = "factor")
names(imp17) <- "hs"
imp17$id17 <- 1

codigos_imp_2017 <- merge(dadoshs07, imp17, by = "hs", all = TRUE)

subset(codigos_imp_2017, is.na(id07) == TRUE)


