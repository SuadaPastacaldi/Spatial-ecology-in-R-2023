#Final script including all lectures scripts

#-----------------------------------------------
#summary
#01 beginning
#02 population ecology
#03 population distribution 
#04 communities

#------------------------------------------------
# program doesn't read anything following a #
# R as a calculator
4+4

# Assignment <- (or =)
zina<-4+4
duccio<-5+1
final<- zina*duccio

# Array (vettore)
sophie <- c(10,20,30,40) #number of units
paula <- c(100,200,300,500) #number of people

#Plot graphic representation of the link between the two
plot(paula, sophie) graphic representation of the link between the two
plot(paula, sophie, xlab="number of people", ylab="number of microplastics")

#or
paula<-people
sophie<-microplastics
plot(people, microplastic)

# changing graphic's layout
plot(people, microplastic, pch=19)
plot(people, microplastic, pch=19, cex=2)
plot(people, microplastic, pch=19, cex=2, col="blue")

# Functions: commands with parenthesis, 
# Arguments: inside function's parenthesis
# Instal packages
instal.packages("sp")

#installment succeded
library(sp)

#------------------------------------------------


#02 population ecology

#################### POINT PATTERN ANALYSIS


# package needed for point pattern analysis is spatstat
install.packages("spatstat") #quotes are needed every time you get out of R and back
# to check if it's there
library(spatstat) #no quotes needed cause inside R

# bei data, already in R
# data description
bei #(trees disposition data)
#Planar point pattern: 3604 points
#window: rectangle = [0, 1000] x [0, 500] metres

# plot data 
plot(bei)

#changing dimention with character exageration (cex)
plot(bei, cex=0.5)
plot(bei, cex=0.2)

#changing the symbol, shape (pch)
plot(bei, cex=0.3, pch=19)

# additional data set bei.extra
bei.extra
#List of pixel images

#elev:
#  real-valued pixel image
#101 x 201 pixel array (ny, nx)
#enclosing rectangle: [-2.5, 1002.5] x [-2.5, 502.5] 
#metres

#grad:
#  real-valued pixel image
#101 x 201 pixel array (ny, nx)
#enclosing rectangle: [-2.5, 1002.5] x [-2.5, 502.5] 
#metres

#plot
plot(bei.extra)
# raster file images (elev and grad),
# filtering info, we only need one part of the two, the elevation. 2 ways to do that
plot(bei.extra$elev) # $ link between objects
#or
elevation<-bei.extra$elev
plot(elevation)
#or 
#other method to select only one element
elevation1<- bei.extra[[1]] #double [] because we are on 2 dimensions, 2d image
plot(elevation1)

############# INTERPOLATION

bei 
plot(bei)

#density map
#from points to continuous surface --> interpolation
density(bei)

#assign it to an object
treedensitymap<-density(bei)

#from points to pixels, now it's an image
#plot
plot(treedensitymap)

#put points on top of density map
points(bei, cex=.2)


#change colors
#array of colors(function c),
#specify how many color shades in between (100)
#first color=lowest value
colorRampPalette(c("black", "red", "orange", "yellow"))(100)
cl<-colorRampPalette(c("black", "red", "orange", "yellow"))(100)

#plot with new color palette
plot(treedensitymap, col = cl)
points(bei, cex=.2, col="white")

#additional variables, bei.extra, contains 2 variables
plot(bei.extra)
#first element
elev<-bei.extra[[1]]
#or
bei.extra$elev

#plot
plot(elev)

################# MULTIFRAME
# visualising data toghther

par(mfrow=c(1,2)) #1 is row, 2 is columns

plot(treedensitymap)
plot(elev)

#multiframe with 3 plots
#bei
#densitymap
#elev

par(mfrow=c(1,3))
plot(bei, cex=.1)
plot(treedensitymap)
plot(elev)



#------------------------------------------------

#03 population distribution

#investigate why population disperse over landscape in a certain manner

#spacial data needed
#GDAL (geospastial data abstraction library)
#GDAL data contained in packages
#terra
#species distribution models (sdm)
library(sdm)
library(terra)

#find a file in a package by name
#in sdm a folder called external that contains species (rana temporaria) data
#package=sdm
#folder=externl
#name=species.shp
system.file("external/species.shp", package="sdm")
file<-system.file("external/species.shp", package="sdm")

#vector files, 
#a series of points(coordinates) in space that indicate movement
#make a vector with info about rana temporaria to get the coordinates
#function vect
vect(file) #to import data
rana<-vect(file)
rana
rana$Occurrence #sequence of zeros and ones, called precence/absence data

#plot points in 2d
plot(rana)
plot(rana, cex=.5)

#select only presences
#[]to select elements
#, closure of querty
rana[rana$Occurrence==1,]
pres<-rana[rana$Occurrence==1,]
pres$Occurrence
#only ones, so if we plot, only plotting ones
plot(pres, cex=0.5)

#select only absences
rana[rana$Occurrence!=1,]
abs<-rana[rana$Occurrence!=1,]
abs$Occurrence
#only zeros
plot(abs, cex=0.5)

#Multiframe presence, absence
par(mfrow=c(1,2))
plot(abs, cex=0.5)
plot(pres, cex=0.5)

#graphical nulling
dev.off()


#Same plot with different colours
plot(pres, col="dark blue", cex=0.5)
points(abs, col="light blue", cex=0.5) 
#function points doesn't plot again just adds points at the previous plot


#why is the specie distributed that way?
#use of predictors to answer

#elevation predictor
#find the path of the predictor: elevation.asc
system.file("external/elevation.asc", package="sdm") 
path.to.elev<-system.file("external/elevation.asc", package="sdm") 

#import it, since it's an image we are not using vect function but rast function
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
veg<-rast(system.file("external/vegetation.asc", package="sdm"))
plot(veg)
points(pres)
      
#precipitation predictor
path.to.prec<- system.file("external/precipitation.asc", package="sdm") 
prec<-rast(path.to.prec)
plot(prec)
points(pres)
          
          
          
#multiframe with all predictors
par(mfrow=c(2,2))
          plot(prec)
          points(pres)
          plot(veg)
          points(pres)
          plot(temp)
          points(pres)
          plot(elev)
          points(pres)

#----------------------------------------------

#04 communities

#SPACIAL RELATIONSHIP
#spacial relationship between different species

#MULTIVARIATE ANALYSIS
#rescale multidimentional data in two dimentions 
#to get spacial info we need to visualize data in 2d 
#more methods to do so
#ORDINATION METHOD
##other methods, pc,correspondence analysis...


#vegetation analysis
#vegan package
library(vegan)


#dune dataset 
#recall data
data("dune")
dune #shows data
summary(dune)
#head function, shows only first 6 rows
head(dune)
#same for tail function
tail(dune)





#ORDINATION METHOD
#decorana function, detrended correspondence analysis
ord<-decorana(dune)
ord #to see data

#4 axes,
#use two to scale the whole data,
#which two?
#the two with longest axis lenght (represet the amount of data that it covers)
#measure lenght of pc1 

#Axis lengths    ->     3.7004 3.1166 1.30055 1.47888
ldc1=3.7004
ldc2=3.1166 
ldc3=1.30055
ldc4=1.47888

total<- ldc1+ldc2+ldc3+ldc4

#percentages of data in each of the 4 axis
pldc1<-ldc1*100/total
pldc2<-ldc2*100/total
pldc3<-ldc3*100/total
pldc4<-ldc4*100/total

#lenght of each axis in %
pldc1
pldc2
pldc3
pldc4


#use the biggest for principal component 1 (pc1)

#ex ppldc1+pldc2 contains 71% of the information
pldc1+pldc2

#r already plots with the two longest axes as principal components
plot(ord)


#TIME RELATIONSHIP
