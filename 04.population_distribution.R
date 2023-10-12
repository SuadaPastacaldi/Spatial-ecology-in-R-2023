#why population disperse over landscape in a certain manner

#GDAL geospastial data abstraction library
# terra package contains gdal data, spacial data 
library(sdm)
library(terra)

#inside sdm folder called external that contains species (rana temporaria) data
system.file("external/species.shp", package="sdm")
file<-system.file("external/species.shp", package="sdm")

#vector files, a series of points(coordinates) in space that indicate movement
#make a vector with info about rana temporaria to get the coordinates
vect(file)
rana<-vect(file)


rana$Occurrence
#gives a sequence of zeros and ones, called precence/absence data
#we need to see data spacially plotting it
plot(rana)
plot(rana, cex=.2)

#select only presencies
#[]to select elements
#, closure of querty

rana[rana$Occurrence==1,]
pres<-rana[rana$Occurrence==1,]

pres$Occurrence
#gives only ones, so if we plot it there is a lower amount of points
plot(pres, cex=0.3)
     

#select only absences
rana[rana$Occurrence!=1,]
abs<-rana[rana$Occurrence!=1,]

abs$Occurrence
#gives only zeros


#visualise presences and absences toghether, making a multiframe
 par(mfrow=c(1,2))
plot(abs)
plot(pres)

#plotting em in the same plot with different colours



