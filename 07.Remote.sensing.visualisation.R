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
