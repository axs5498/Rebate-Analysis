# rebate analysis 
rm(list=ls())
#load the files and save as list 

library(openxlsx)

setwd("~/Dropbox/Candidacy_exam/rebate_analysis/seearpfinalrebatereports")

myFilenames <- list.files(pattern=".*xlsx")

dataList<-list()
names<-list()
dimension<-data.frame(matrix(nrow = length(myFilenames),ncol = 2))
colnames(dimension)<-c('rows','cols')
colnames_allfiles<-data.frame(matrix(nrow = 56,ncol = 24))

for (i in 1:length(myFilenames))
{
  chk<-read.xlsx(myFilenames[i],3)
  dataList[[i]]<-chk
  dimension[i,]<-dim(chk)
  
  names[[i]]<-colnames(chk)
  
}


dataList[[2]]$Rebate.Number<-NULL
dataList[[11]][,23]<-NULL
dataList[[31]][,24]<-NULL
#dataFile<-data.frame(matrix(nrow = sum(dimension$rows),ncol = unique(dimension$cols)))

#from first look all the colnames are the same? 

col_names<-c('State','PType','PBrand','PBrand2','MNumber','AHRICert',
             'SRCCCert','PurcDate','Retailer','DateofAppl','DateofRebatePay',
             'PurcPrice','RebatePay','Zip','Hauled','Recyled','RecRebatePaid',
             'AmntRecRebate','NonSEEARP','BrandofRepProd','ModelNoRepProd',
             'EffRatingReplaced','ClaimID')


dataFile<-data.frame()
for (i in 1:length(myFilenames))
{
  colnames(dataList[[i]])<-col_names 
  dataFile<-rbind(dataFile,dataList[[i]])
}


#doing maps 
library(choroplethr)
library(zipcode)
install.packages("choroplethrMaps")


nData<-dataFile[,c('Zip','RebatePay')]
colnames(nData)<-c('region','value')
nData_new<-nData[-which(nchar(nData$region)!=5),]

nData_new_numeric<-as.numeric(as.character(nData_new$region))

nData_new_new<-nData_new[-which(is.na(nData_new_numeric)),]


new<-data.frame(table(nData_new_new$region)

colnames(new)<-c('region','value') 
                
 zip_map(new)
                
save.image()
