### Recodificacao HS

rm(list=ls(all=TRUE))

dadoshs07 <- read.csv("H:\\secex\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(dadoshs07) <- "hs"
dadoshs07$id07 <- 1

# COMTRADE 1997

COMTRADE97 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_1997.csv", header=TRUE,colClasses="factor")
names(COMTRADE97) <- "hs"
COMTRADE97$id97 <- 1

codigos1997 <- merge(dadoshs07,COMTRADE97,by="hs",all=TRUE)

subset(codigos1997,is.na(id07)==TRUE)


# COMTRADE 1998

COMTRADE98 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_1998.csv", header=TRUE,colClasses="factor")
names(COMTRADE98) <- "hs"
COMTRADE98$id98 <- 1

codigos1998 <- merge(dadoshs07,COMTRADE98,by="hs",all=TRUE)

subset(codigos1998,is.na(id07)==TRUE)

# COMTRADE 1999

COMTRADE99 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_1999.csv", header=TRUE,colClasses="factor")
names(COMTRADE99) <- "hs"
COMTRADE99$id99 <- 1

codigos1999 <- merge(dadoshs07,COMTRADE99,by="hs",all=TRUE)

subset(codigos1999,is.na(id07)==TRUE)

# COMTRADE 2000

COMTRADE00 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2000.csv", header=TRUE,colClasses="factor")
names(COMTRADE00) <- "hs"
COMTRADE00$id00 <- 1

codigos2000 <- merge(dadoshs07,COMTRADE00,by="hs",all=TRUE)

subset(codigos2000,is.na(id07)==TRUE)


# COMTRADE 2001

COMTRADE01 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2001.csv", header=TRUE,colClasses="factor")
names(COMTRADE01) <- "hs"
COMTRADE01$id01 <- 1

codigos2001 <- merge(dadoshs07,COMTRADE01,by="hs",all=TRUE)

subset(codigos2001,is.na(id07)==TRUE)

# COMTRADE 2002

COMTRADE02 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2002.csv", header=TRUE,colClasses="factor")
names(COMTRADE02) <- "hs"
COMTRADE02$id02 <- 1

codigos2002 <- merge(dadoshs07,COMTRADE02,by="hs",all=TRUE)

subset(codigos2002,is.na(id07)==TRUE)

# COMTRADE 2003

COMTRADE03 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2003.csv", header=TRUE,colClasses="factor")
names(COMTRADE03) <- "hs"
COMTRADE03$id03 <- 1

codigos2003 <- merge(dadoshs07,COMTRADE03,by="hs",all=TRUE)

subset(codigos2003,is.na(id07)==TRUE)

# COMTRADE 2004

COMTRADE04 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2004.csv", header=TRUE,colClasses="factor")
names(COMTRADE04) <- "hs"
COMTRADE04$id04 <- 1

codigos2004 <- merge(dadoshs07,COMTRADE04,by="hs",all=TRUE)

subset(codigos2004,is.na(id07)==TRUE)

# COMTRADE 2005

COMTRADE05 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2005.csv", header=TRUE,colClasses="factor")
names(COMTRADE05) <- "hs"
COMTRADE05$id05 <- 1

codigos2005 <- merge(dadoshs07,COMTRADE05,by="hs",all=TRUE)

subset(codigos2005,is.na(id07)==TRUE)

# COMTRADE 2006

COMTRADE06 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2006.csv", header=TRUE,colClasses="factor")
names(COMTRADE06) <- "hs"
COMTRADE06$id06 <- 1

codigos2006 <- merge(dadoshs07,COMTRADE06,by="hs",all=TRUE)

subset(codigos2006,is.na(id07)==TRUE)

# COMTRADE 2007

COMTRADE07 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2007.csv", header=TRUE,colClasses="factor")
names(COMTRADE07) <- "hs"
COMTRADE07$id072 <- 1

codigos2007 <- merge(dadoshs07,COMTRADE07,by="hs",all=TRUE)

subset(codigos2007,is.na(id07)==TRUE)


# COMTRADE 2008

COMTRADE08 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2008.csv", header=TRUE,colClasses="factor")
names(COMTRADE08) <- "hs"
COMTRADE08$id08 <- 1

codigos2008 <- merge(dadoshs07,COMTRADE08,by="hs",all=TRUE)

subset(codigos2008,is.na(id07)==TRUE)


# COMTRADE 2009

COMTRADE09 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2009.csv", header=TRUE,colClasses="factor")
names(COMTRADE09) <- "hs"
COMTRADE09$id09 <- 1

codigos2009 <- merge(dadoshs07,COMTRADE09,by="hs",all=TRUE)

subset(codigos2009,is.na(id07)==TRUE)


# COMTRADE 2010

COMTRADE10 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2010.csv", header=TRUE,colClasses="factor")
names(COMTRADE10) <- "hs"
COMTRADE10$id10 <- 1

codigos2010 <- merge(dadoshs07,COMTRADE10,by="hs",all=TRUE)

subset(codigos2010,is.na(id07)==TRUE)


# COMTRADE 2011

COMTRADE11 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2011.csv", header=TRUE,colClasses="factor")
names(COMTRADE11) <- "hs"
COMTRADE11$id11 <- 1

codigos2011 <- merge(dadoshs07,COMTRADE11,by="hs",all=TRUE)

subset(codigos2011,is.na(id07)==TRUE)

# COMTRADE 2012

COMTRADE12 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2012.csv", header=TRUE,colClasses="factor")
names(COMTRADE12) <- "hs"
COMTRADE12$id12 <- 1

codigos2012 <- merge(dadoshs07,COMTRADE12,by="hs",all=TRUE)

subset(codigos2012,is.na(id07)==TRUE)

# 0308 3826 9619

# COMTRADE 2013

COMTRADE13 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2013.csv", header=TRUE,colClasses="factor")
names(COMTRADE13) <- "hs"
COMTRADE13$id13 <- 1

codigos2013 <- merge(dadoshs07,COMTRADE13,by="hs",all=TRUE)

subset(codigos2013,is.na(id07)==TRUE)

# COMTRADE 2014

COMTRADE14 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2014.csv", header=TRUE,colClasses="factor")
names(COMTRADE14) <- "hs"
COMTRADE14$id14 <- 1

codigos2014 <- merge(dadoshs07,COMTRADE14,by="hs",all=TRUE)

subset(codigos2014,is.na(id07)==TRUE)

# COMTRADE 2015

COMTRADE15 <- read.csv("H:\\comtrade\\Recodificacao HS\\hs_2015.csv", header=TRUE,colClasses="factor")
names(COMTRADE15) <- "hs"
COMTRADE15$id15 <- 1

codigos2015 <- merge(dadoshs07,COMTRADE15,by="hs",all=TRUE)

subset(codigos2015,is.na(id07)==TRUE)
