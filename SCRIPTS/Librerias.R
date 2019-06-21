#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("lubridate")
#install.packages("RCurl")
#install.packages("ggplot2")
#install.packages("leaflet")
library(dplyr)
library(lubridate)
library(tidyr)

IGV<-read.csv2( "DataSets/IGV.csv",fileEncoding = "ISO-8859-1")
TribInt<-read.csv2( "DataSets/Tributo-interno.csv",fileEncoding = "ISO-8859-1")
IR<-read.csv2("DataSets/IR.csv",fileEncoding = "ISO-8859-1")
ADUANAS<-read.csv2("DataSets/ADUANAS.csv",fileEncoding = "ISO-8859-1")
IGV<-IGV[-307,]
IGV<-IGV[,c(-28,-17,-8)]
TribInt<-TribInt[,c(-28,-17,-8)]
IR<-IR[-307,]
IR<-IR[,c(-28,-17,-8)]
ADUANAS<-ADUANAS[-307,-26]
