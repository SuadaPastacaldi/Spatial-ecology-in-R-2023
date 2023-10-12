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
vect(file) #to import data
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

#graphical nulling
dev.off()


#plotting em in the same plot with different colours
plot(pres, col="dark blue")
points(abs, col="light blue") 
#points doesn't plot again just adds points at the previous plot

#why is it distributed in that way?
#can use predictors to answer

#elevation predictor
#find the path of the predictor: elevation.asc
system.file("external/elevation.asc", package="sdm") 

path.to.elev<-system.file("external/elevation.asc", package="sdm") 
#to import it, since it's an image we are not using vect function but rast function
rast(path.to.elev)
elev<-rast(path.to.elev) #name it
plot(elev)
points(pres)

#temperature predictor
system.file("external/temperature.asc", package="sdm") 
rast(system.file("external/temperature.asc", package="sdm") )
temp<-rast(system.file("external/temperature.asc", package="sdm") )
plot(temp)
points(pres)

#vegetation predictor
path.to.veg<- system.file("external/temperature.asc", package="sdm") 
rast(path.to.veg)
veg<-rast(system.file("external/vegetation.asc", package="sdm")
plot(veg)
points(pres)

#precipitation predictor
path.to.prec<- system.file("external/precipitation.asc", package="sdm") 
prec<-rast(path.to.prec)
plot(prec)
points(pres)



#new multiframe with all predictors
par(mfrow=c(2,2))
plot(prec)
points(pres)
plot(veg)
points(pres)
plot(temp)
points(pres)
plot(elev)
points(pres)

          
          





