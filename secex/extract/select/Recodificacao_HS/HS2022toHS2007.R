setwd('~/Documents/Econ/DataViva/SECEX/select')
h = read.csv('HS2022toHS2007.csv',sep='\t',colClasses=c('character','character'))
head(h)
h$hs22 = substr(h$From.HS.2022,1,4)
h$hs07 = substr(h$From.HS.2007,1,4)
h = h[,3:4]
h = unique(h)
head(h)
tail(h)
which(h$hs22 != h$hs07)
# [1]   23   25   26   27   28   29  203  204  205  321  323  363  373  449  450  455
# [17]  456  943  985 1028 1056 1057 1058 1083 1099 1102 1110 1111 1141 1142 1143 1242
# [33] 1243
write.table(h,'HS22_HS07.txt',sep=',',quote=F,row.names=F)
h$hs22[which(duplicated(h$hs22))]
tab = h[h$hs22 %in% h$hs22[which(duplicated(h$hs22))],]
write.table(tab,'HS22_HS07_dupl.tsv',sep='\t',quote=F,row.names=F)

h = read.csv('HS22_HS07.txt')
head(h)
any(duplicated(h$hs22))
