## EXTERNAL DATA IMPORT
#download and import data

library(terra)

#vedi code ducciorocchini per link ai siti
#to work on small scale is better to work on sentinel data
#landsat has a very long time period from 1972



#tell R where we stored the data, the folder

#set working directory
# seleziona elemento, proprietà, percorso, copia in funzione
setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/R")
# setwd("C:/Users/suada/Downloads/R")

#quotes for exiting R to get data from the pc
#windows uses c:\\ but instead need to change it in / (every slash)
#we use the function raster from terra 

#like in im.import we tell R the name of the image we need to import from the folder
#use quotes
#add the file type (ex. .jpg)
naja2003<-rast("najafiraq_etm_2003140_lrg.jpg")
plot(naja2023)
naja2023<-rast("najafiraq_oli_2023219_lrg.jpg")
plot(naja2003)


par(mfrow=c(1,2))
plot(naja2003)
plot(naja2023)

#we can compare them by comparing layers, whic one to use we are told by multivariate analysis
dev.off()
#multitemporal chamge detection
najadif=naja2003[[1]]-naja2023[[1]]
cl<-colorRampPalette(c("brown","grey", "orange"))(100)
plot(najadif, col=cl)

#other download
elba<-rast("italy_oli_2019360_lrg.jpg")
plot(elba)

#put rgb bands in different order

plotRGB(elba, r=2,g=1,b=3)
plotRGB(elba, r=3,g=2,b=1)
