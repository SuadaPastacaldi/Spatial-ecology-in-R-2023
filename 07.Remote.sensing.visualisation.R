#visualise satellite data
#remote sensing satellite

#use of devtools package
#library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")

#use package
im.list() #gives list of info in dataset

#we use "sentinel.dolomites.b2.tif"
# b2 means bends, they reflect different wavelenghts
#we need those at same definition of 10 meters--> just 4 of them
#import them
b2<-im.import("sentinel.dolomites.b2.tif")

#it plots it directly
#to check info in b2
b2




######Reference System
#in b2 (WGS 84) World Geometric System, UTM zone 32N

#geoids is not geometrical so no good to get measures, what we do is approximate it to an ellipsoid
#we need tho to get the right ellipsoid (matching the geode), for the specific zone we are measuring
#even latitude and longitude change if the ellipsoid used is different
# we should pass from ellipsoid to planar system --> projection
#UTM Universal Transverse Mercator
# world divided in zones numbered from starting point antimeridian of greenwitch


##change color of map
clb<-colorRampPalette(c("darkgrey", "grey" , "lightgrey")) (100)
plot(b2, col=clb)

#import the green band from sentinel 2 (band 3)
b3<-im.import("sentinel.dolomites.b3.tif")
plot(b3, col=clb)


