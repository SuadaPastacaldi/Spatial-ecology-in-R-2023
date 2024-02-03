#Final script including all lectures scripts

#-----------------------------------------------
#summary
#01 beginning
#02 population ecology
#03 population distribution 
#04 communities
#05 remote sensing
#06 time series
#07 external data import
#08 classification
#09 variability and pca
#10 Rmarkdown
#11 LaTeX

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
#info from camera traps
#we get where and at what time a certain species passed by
#overlap between two niches

library(overlap)

data(kerinci)
head(kerinci) #to show some data (not all species)
summary(kerinci) #gives the abstract of the data
#3 columns- zone, species(sps), time

#TIGER
#specie tiger, new dataset with only tiger
kerinci[kerinci$Sps=="tiger",] #closure with final coma
tiger<-kerinci[kerinci$Sps=="tiger",]

summary(tiger)
#time is given in linear time
#to pass from linear to circular time (times 2pigreco)
kerinci$Time * 2 * pi
#add a column to kerinci dataframe with circular time
kerinci$timeRad <- kerinci$Time * 2 * pi

head(kerinci)

#object tiger with new column
kerinci$timeRad <- kerinci$Time * 2 * pi
tiger<-kerinci[kerinci$Sps=="tiger",]
head(tiger)

#DENSITY PLOT
#graphical representation of the amount of time a certain species has been seen
#selecting variable time in object tiger
timetig <- tiger$timeRad
#distribution of tiger data during the day
densityPlot(timetig, rug=TRUE)

#MACAQUE
#select macaque as the species
macaque<-kerinci[kerinci$Sps=="macaque",]
#select variable time
timemac <- macaque$timeRad
#distribution of macaque data during the day
densityPlot(timemac, rug=TRUE)

#OVERLAP
#overlapping of the two species
#function overlapPlot, colours the overlapping distribution
overlapPlot(timetig, timemac)


#-----------------------------------------------------------------------------

#05 remote sensing

#SATELLITE DATA
#remote sensing satellite
#powerfull tool to measure climatic variables,
#investigate a certain area in a small amount of time

#use of devtools package
library(devtools) 

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")
library(imageRy)

#list of info in dataset
im.list()
#[23] "sentinel.dolomites.b2.tif"                         
#[24] "sentinel.dolomites.b3.tif"                         
#[25] "sentinel.dolomites.b4.tif"                         
#[26] "sentinel.dolomites.b8.tif"                         
#[27] "sentinel.png"                                      
#[28] "Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"

#use "sentinel.dolomites.b2.tif"
#b2, b3, b4, b8 are the satellite's bends, they reflect different wavelenghts
#we need them at same definition (10 meters)--> just 4 of them
#import 
b2<-im.import("sentinel.dolomites.b2.tif")

#R plots it directly
#to check info in b2
b2
plot(b2)


######REFERENCE SYSTEM
#in b2
#WGS 84, World Geometric System,
#UTM zone 32N (gauss projection of the globe), 
#UTM Universal Transverse Mercator
#world divided in zones numbered from starting point antimeridian of greenwitch
#there are 60 zones 6° broad
#on x axis distance from refernce meridian, y axis distance from equator
#earth's shape is a geode
#a geode is not geometrical so no good to get measures, what we do is approximate it to an ellipsoid
#we need the right ellipsoid (the one matching the geode for the specific zone we are measuring), 
#even latitude and longitude change if the ellipsoid used is different
#to pass from ellipsoid to planar system --> projection

##change color of map
#create palette
clb<-colorRampPalette(c("black", "grey" , "lightgrey")) (100)
plot(b2, col=clb)

#googleing sentinel 2 bands we find the differrnt wavelenghts reflections
#import the green band from sentinel 2 (band 3)
b3<-im.import("sentinel.dolomites.b3.tif")
plot(b3, col=clb)

#import red band
b4<-im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clb)

#high value-> absorbance of red
#low values-> reflectance of red

#import near-infrared
b8<-im.import("sentinel.dolomites.b8.tif")
plot(b8, col=clb)
#many more additional info with infrared vision

# multiframe
par(mfrow=c(2,2))
plot(b2, col=clb)
plot(b3, col=clb)
plot(b4, col=clb)
plot(b8, col=clb)

#####STACK IMAGES
# make a stack of all bands toghether
# 4 bands toghether in same object
# as an array
stacksentinel<-c(b2, b3, b4, b8)

dev.off() #to clear plots

#to see info
stacksentinel
plot(stacksentinel, col=clb)

#just to plot one of the elements (1,2,3,or 4)
plot(stacksentinel[[4]], col=clb) #infrared 

#active sensors, (emit energy and receive it back getting info)
#satellites are passive sensors, they work with Reflectance, 
#ratio between reflected energy and incidence energy
#flusso(R)/flusso(I)   (radiant fluxes)
#if the ratio is zero-> all absorbed
#if ratio is one-> all reflected

###datas are always stored with integer values,
###to not have too many pixels with different values, to avoid images that are too heavy

#plot in multiframe, the bands with different color ramps
blue<-colorRampPalette(c("blue", "lightblue" , "white")) (100)
red<- colorRampPalette(c("red4", "red2" , "coral1")) (100)
green<- colorRampPalette(c("forestgreen", "green" , "lightgreen")) (100)
infrared<- colorRampPalette(c("darkmagenta", "magenta1", "plum1")) (100)

par(mfrow=c(2,2))
plot(b2, col=blue)        ## 1   stacksentinel[[1]]
plot(b3, col=green)       ## 2
plot(b4, col=red)         ## 3
plot(b8, col=infrared)    ## 4

####### RGB
#rgb space, the manner computers compute images
# every pixel has the three color bands at different brightness each 
#3 basic components, green, blue, red-->RGB
#if we assign right color to right element we might recreate "reality"'s colors
dev.off()
im.plotRGB(stacksentinel, r=3, g=2, b=1)
#low resolution when no infrared

#use it in the visualisation process
#include infrared band into plot
im.plotRGB(stacksentinel, r=3, g=4, b=1)
#in this case over the green band


pairs(stacksentinel)
##each plot shows the relationship between a pair of variables
##allows us to see both distributions of a single variable and relationships between two variables


#REMOTE SENSING INDECES

# vegetation index
# higher the index the healthier the vegetation
# the index is created with subtracting from near infrared value (should be higher) the red value (should be lower)
# high reflectance on red band means low photosynthesis capability
# high reflectance on infrared band means high photosynthesis capability
# no infrared reflectance=no vegetation

## create indeces

## use mato grosso info (brazil forest)
## comparison 1992-2006 situation

library(imageRy) 
library(terra)
library(ggplot2)
library(viridis)

im.list()

## [21] "matogrosso_ast_2006209_lrg.jpg"                    
## [22] "matogrosso_l5_1992219_lrg.jpg"                     


im.import("matogrosso_l5_1992219_lrg.jpg" )


## 3 bands to use NIR 1 RED 2 GREEN 3 
#nir put in red band --> vegetation appears red in the plot
mato1992<-im.import("matogrosso_l5_1992219_lrg.jpg" )
im.plotRGB(mato1992, r=1, g=2, b=3)# also im.plotRGB(mato1992, 1, 2, 3)

# infrared in green
im.plotRGB(mato1992, r=2, g=1, b=3)
# infrared in blue
im.plotRGB(mato1992, r=3, g=2, b=1)


#situation 1992
#red healthy tropical forest, starts just at the bottom to be ruined (greenish)




#plot 2006
mato2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(mato2006, r=2, g=1, b=3)

im.plotRGB(mato2006, r=3, g=2, b=1)
#putting nir in blue position
#yellow enhances bare soil, vegetation in blue

#situation 2006
#visible decrease of vegetation


#----------------------------------------------------------------------------

#06 time series



## time series analysis
library(terra)
library(imageRy)

#in sentinel there is a band measuring no2 in atmosphere year long
#we are interested in 2020
#comparison of NO2 concentration before and after covid-19 quarantine
im.list()

#"EN_01.png"


#import "EN_01.png" (europe nitrogen)
#situation in january
EN01<-im.import("EN_01.png")
##situation in march
EN13<-im.import("EN_13.png")


#multiframe

par(mfrow=c(1,2))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#take just first band and make a difference
#to see how the data changed in time
#from january to march
diff=EN01[[1]]-EN13[[1]]

dev.off()
plot(diff)

#change palette
cldif<-colorRampPalette(c("blue", "white", "red"))(100)
plot(diff, col=cldif)

#interpretation
#red --> big difference, higher concentration in january
#white --> more or less same concentration
#blue --> less difference, higher concentration in march

dev.off()

#info about surface temperature in greenland
#ice melting

im.list()
#4 single layers
g2000<-im.import( "greenland.2000.tif")
g2005<-im.import("greenland.2005.tif")
g2010<-im.import("greenland.2010.tif")
g2015<-im.import("greenland.2015.tif" )

clg<-colorRampPalette(c("black","blue", "white", "red"))(100)
plot(g2000,col=clg)
#wide inner area with perennial ice

plot(g2015,col=clg)
#deep blue area is restricting, lost of ice

par(mfrow=c(1,2))
plot(g2000,col=clg)
plot(g2015,col=clg)

#stack all images toghether
stackg<-c(g2000, g2005, g2010, g2015)
plot(stackg,col=clg)


dev.off()

#difference between first and final element of file
gdiff=stackg[[1]]-stackg[[4]] #or gdiff=g2000-g2015
plot(gdiff, col=clg)


#use three of the images to do an rgb 
im.plotRGB(stackg, r=1, g=2, b=4)


#interpretation
#the inner part is increasing temperature, on coastside the situation is inverted 

#if we have high values in 2015 everything is --> blueish/blackish
#if it was higher in the first band it would have been red and green for the second

#-------------------------------------------------------------------------

#07 external data import


## EXTERNAL DATA IMPORT
#download and import data

library(terra)
#to get function rast

#vedi code ducciorocchini per link ai siti

#sentinel data for small scale
#landstat for long time period (1972-)


##### EARTH OBSERVATORY


#set working directory
#to let R know where data is stored
#seleziona elemento, proprietà, percorso, copy in function setwd()
setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/R")
setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop")
#quotes for exiting R to get data from the pc
#windows uses c:\\ but --> need to change it in / (every slash)
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

#comparison by comparing layers,
#multivariate analysis to pick a layer
dev.off()
#multitemporal change detection
najadif=naja2003[[1]]-naja2023[[1]]
cl<-colorRampPalette(c("brown","grey", "orange"))(100)
plot(najadif, col=cl)
#higher values--> higher difference in the two images

#other download
elba<-rast("italy_oli_2019360_lrg.jpg")
plot(elba)

#put rgb bands in different order
plotRGB(elba, r=2,g=1,b=3)
plotRGB(elba, r=3,g=2,b=1)

##### COPERNICUS
#worldwide
#variables in 4 different frameworks

# https://land.copernicus.eu/global/

# download image, 
# .nc format

library(terra)

#need of a tool to read .nc files
library(ncdf4)

# set working directory
setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/R")

## rast function to import image
ceuro<-rast("c_gls_SSM1km_202310310000_CEURO_S1CSAR_V1.2.1.nc")

#info about the file
ceuro

plot(ceuro)
#2 images,
#first one is the actual image,
#the other one (noise) is measure of the error

plot(ceuro[[1]])
c<-colorRampPalette(c("red", "orange","yellow")) (100)
plot(ceuro[[1]], col=c)

# crop function 
#specify extention of raster c(minlong, maxlong, minlat, maxlat)
ext<- c(20, 40, 55,60)

#function to cut image crop(name, ext)
cut<-crop(ceuro[[1]], ext)
plot(cut, col=c)


#from copernicus
#download other image, same extention, different day/year
#ext has already been set, 
#compare them 


#--------------------------------------------------------------------

#08 classification

#Classify satellite images and estimate the amount of change

#using frequencies of pixels, to see a change in time
#vegetation --> no reflection of red it's absorbed, high reflectance in near infrared
#water --> high reflection of red, near infrared absorbed

#training sized
#to explain the server what are the clusters (set of objects with the same characteristics)
#ex. of clusters in our case ( lake, forest, city, agro field) more or less same kind of reflection in a particular area

#minimum distance from class 
#method to distinguish in which class a particular pixel is 
#(for any kind of pixel in my image that is not a training size)

####Classify
library(terra)
library(imageRy)
library(ggplot2)

install.packages("patchwork")
library(patchwork)

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#directly plotted by R 
plotRGB(sun, 1, 2, 3)
#3 levels of energy, black, yellow, white
#created by the algorithm that selects pixels similar to each other
#classify the image
#im.classify(image, number of clusters)

sun1<-im.classify(sun, num_clusters = 3)
sun1


##plot un 1
plot(sun1)
#gives tree images exactly the same replicated
plot(sun1[[1]])

#white has the highest energy down to yellow, green has the lowest


#Mato grosso forest
#apply it to the mato grosso forest to quantify the amount of change in the forest over time

#import images
im.list()
#[21] "matogrosso_ast_2006209_lrg.jpg"                    
#[22] "matogrosso_l5_1992219_lrg.jpg"   
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg" )

#plotrgb
plotRGB(m1992)
#water in combination with the infrared shuld be black since it absorbs all infrared
#in this image we can not distinguish 

#create a classification with 2 clusters 1 for forest 1 for all others(water, urban, deforested)
m1992c<-im.classify(m1992, 2)
plot(m1992c[[1]])

#CLASSES:
#1=bare soil, water, 
#2=forest

#classify second image
m2006c<-im.classify(m2006,2)
plot(m2006c[[1]])
#same classes

par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

#quantify change
#freq(image)
#function calculating the frequency of a certain class

f1992<-freq(m1992c)
f2006<-freq(m2006c)
f1992

#compute percentage of pixel class
#ncell() calculate n of pixels in an image
ncell(m1992c)

tot19992<-ncell(m1992c)

#percentage
#frequency/tot pixels * 100

#1992
p1992<-f1992/tot19992*100
p1992
#3 columns, percentages under "count"
#       layer        value    count
#1 5.555556e-05 5.555556e-05 16.91317
#2 5.555556e-05 1.111111e-04 83.08683

#forest=83%
#humans=17%

#2006
tot2006<-ncell(m2006c)

p2006<-f2006/tot2006*100
p2006
#forest=45%
#humans=55%


#graphical representation of data 
#build a dataframe with all the data --> forest, human, percentages, 2006, 1992
#function data.frame()

#build columns of table
class<- c("forest", "humans")
y1992<-c(83,17)
y2006<-c(45,55)

tabella<-data.frame(class,y1992, y2006)
tabella

#to graph package ggplot2 needed
library(ggplot2)

# final plot
#function ggplot(object, aes()+ geom_bar())
#aes, aesthetics
#fill, colour of filling


# final plot
p1 <- ggplot(tabella, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabella, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1
p2
#[error] Don't know how to automatically pick scale for object of type <data.frame>. Defaulting
#to continuous.
#merge the 2 graphs
p1+p2

##different scales in the 2 graphs
#rescale
p1 <- ggplot(tabella, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabella, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1
p2

p1+p2


#------------------------------------------------------------------


#09 variability and pca

#measuring of RS based variability 
#variability analysis beacause it's measure of biodiversity
#important in abiotic and biotic component
#best method is getting standard deviation from mean
#measuring of RS based variability 
#important in abiotic and biotic component

#libraries we need
library(imageRy)
library(terra) #to get function focal
library(viridis)

im.list()
sent<-im.import("sentinel.png")
#in this case, 
#band1=NIR,
#band2=red,
#band3=green
im.plotRGB(sent,r=1,g=2,b=3) #vegetation is red
im.plotRGB(sent,r=2,g=1,b=3) #vegetation is green

#sd can only be calculated on one band
nir<-sent[[1]]
plot(nir)
nir

#function tells what function we want to use, that in this case is sd.
#matrix describes the dimension of the moving windows. it is composed of 9 pixels, from 1 to 9, 3 by 3 pixels
#function that makes the calculation of the sd with moving window 
#3x3 pixels
sd3<-focal(nir, matrix(1/9,3,3), fun=sd) 
sd3
plot(sd3)
#let's change the legend by using the package called virisid 
#we are using the 7 colours of the viridis legend
viridisc<-colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)

##higher variability in north west 
#by watching where the sd is higher, we can see where the variability is higher
#in this case is north-west as there are some glaciers and geomorphological uncertaintanties
#calculate variability in 7x7 pixel moving window
sd7<-focal(nir, matrix(1/49,7,7), fun=sd) #function that makes the calculation of the sd with moving window
plot(sd7, col=viridisc)

#plot sd3 and sd7 together
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

#calculating in 3 by 3 moving window is very local
#enlarging the moving window we include additional pixels, increasing the variability 
par(mfrow=c(1,2))
im.plotRGB(sent,r=2,g=1,b=3) 
plot(sd7, col=viridisc)

#we can see high variability (geological in this case)
#when analysing ecosistems we might see higher variability in ecosystems with high biodiversity

#we did chose the infrared but 
#can we get the info from the 3 bands?
#with multivariate analysis

#since sd can be calculated only on one band
#show data in few axis to show it in 2dimantions
#using the principal component analysis
#the axis with the hghest number of data--> pc1
#the second is gonna be one perpedicular to first with smaller range
#we chose 2 principal components, we will only use the first one(just one band)
#we project every component to the axis of pc1 that we found


dev.off()
##########################            PCA                ###########################################
#with sentinel data we perform pca and then perform the calculation of sd
#to see how much the 3 bands are related with each other
#going to make a plot
pairs(sent)
#sentinel 2 and 3 (red and green) are very related to each other (0.98)
# nir is less correlated
#last raw sent 4 is just a control layer

sentpc<-im.pca2(sent)
#     Standard deviations (1, .., p=4):
#[1] 76.76374 57.23045  4.76155  0.00000
#the 1 is the the band with the highest possible range
sentpc


#it is called PC1
pc1<-sentpc$PC1
plot(pc1, col=viridisc)

pc1sd3<-focal(pc1, matrix(1/9, 3, 3), sd)
plot(pc1sd3, col=viridisc)

#on 7 by 7
pc1sd7<-focal(pc1, matrix(1/49, 7, 7), sd)
plot(pc1sd7, col=viridisc)

#to plot everything all toghether
#2 ways, par() or stack

#par()
#2 rows , 3 cols
par(mfrow=c(2,3))
im.plotRGB(sent,r=2,g=1,b=3) 
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)


#stack
#stack all layers, concatenates elements
sdstack<-c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridisc)

names(sdstack)<-c("sd3","sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)

#first row calculation only with nir
#second row calculation on all bands

#focal can also be used to do any stathistics computation, mean...

#------------------------------------------------------------------

#10 Rmarkdown

---
title: "Markdown Report"
author: "Suada Pastacaldi"
date: "2024-01-09"
output: html_document

---

# My first markdown document
to open markdown document, 
new file, .Rmd

eval is "evaluation" if we want the text to be avaluated or not
if it is-> code is in grey boxes and undernith we have the results in withe box

```{r, eval=T}
2+3
```
 
if not result 
```{r, eval=F}
2+3
```

Using proper packages:
library for remote sensing
```{r, eval=T}
library(imageRy)
```

Import data 
```{r, eval=T}
im.list()
```
```{r, eval=T, warning=FALSE}
mato<-im.import("matogrosso_ast_2006209_lrg.jpg")
```

```{r, eval=T}
mato 
```

im.plotRGB
new plot with nir on top of green 
```{r, eval=T}
im.plotRGB(mato, 2,1,3)
```

Avvertimento: [rast] unknown extent
use echoing=F
or in this case warning=F


plot images toghether
```{r, eval=T}
par(mfrow=c(2,2))
im.plotRGB(mato, 2,1,3)
im.plotRGB(mato, 1,2,3)
im.plotRGB(mato, 2,3,1)
im.plotRGB(mato, 3,1,2)
```


compute spectral indeces
```{r, eval=T, warning=F}
library(viridis)
library(terra)
viridisc <- colorRampPalette(viridis(7))(255)
#dvi<-mato[1]-mato[2]

```

