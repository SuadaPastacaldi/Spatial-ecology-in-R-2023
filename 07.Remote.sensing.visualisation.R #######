#visualise satellite data
#remote sensing satellite

#use of devtools package
library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")
library(imageRy)
#use package
im.list() #gives list of info in dataset
[23] "sentinel.dolomites.b2.tif"                         
[24] "sentinel.dolomites.b3.tif"                         
[25] "sentinel.dolomites.b4.tif"                         
[26] "sentinel.dolomites.b8.tif"                         
[27] "sentinel.png"                                      
[28] "Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"

#we use "sentinel.dolomites.b2.tif"
# b2 means bends, they reflect different wavelenghts
#we need those at same definition of 10 meters--> just 4 of them
#import them
b2<-im.import("sentinel.dolomites.b2.tif")

#it plots it directly
#to check info in b2
b2


######Reference System
#in b2 (WGS 84) World Geometric System, UTM zone 32N (gauss projection of globe)
#there are 60 zones 6° broad
#on x axis distance from refernce meridian, y axis distance from eqautor

#geoids is not geometrical so no good to get measures, what we do is approximate it to an ellipsoid
#we need tho to get the right ellipsoid (matching the geode), for the specific zone we are measuring
#even latitude and longitude change if the ellipsoid used is different
# we should pass from ellipsoid to planar system --> projection
#UTM Universal Transverse Mercator
# world divided in zones numbered from starting point antimeridian of greenwitch


##change color of map
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
#low values-> reflectance of re

#import near-infrared
b8<-im.import("sentinel.dolomites.b8.tif")
plot(b8, col=clb)
#many more additional info with infrared vision

### multiframe
par(mfrow=c(2,2))
plot(b2, col=clb)
plot(b3, col=clb)
plot(b4, col=clb)
plot(b8, col=clb)

#####stack images
# make a  stack of all plots toghether
# 4 bands all toghether in same object
#we can think about them as an array
stacksentinel<-c(b2, b3, b4, b8)

dev.off() #to clear plots

#to see info
stacksentinel
plot(stacksentinel, col=clb)

#just to plot one of the elements (1,2,3,or 4)
plot(stacksentinel[[4]], col=clb) #infrared

#active sensors, like sonars emit energy and then get it back
#satellites are passive sensors, they work with Reflectance, ratio between reflected energy and incidence energy
#flusso(R)/flusso(I)   (radiant fluxes)
#if the ratio is zero-> all absorbed
#if ratio is one-> all reflected

###datas are always stored with integer values, to not have too many pixels with different values, to avoid overweught images

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
#rgb space, the mannar computers see images
#3 basic components, green, blue, red-->RGB
#if we assign right color to right element we might recreate "reality"'s color
dev.off()
im.plotRGB(stacksentinel, r=3, g=2, b=1)
#low resolution when no infrared
#we can tho use it in the visualisation process

# to include infrared
im.plotRGB(stacksentinel, r=3, g=4, b=1)



########manca roba  stacksent
pairs(stacksentinel)
##each plot shows the relationship between a pair of variables
##allows us to see both distributions of a single variable and relationships between two variables



