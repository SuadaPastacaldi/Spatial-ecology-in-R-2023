te # vegetarion index
#the higher the index the healthier the veg
# the index is created with substracting from near infra value (should be higher) the red value (shouldl be low)
# red value if it's higer tells us the capability of photosyntesis is lower
## create indeces

## use mato grosso info brazil forest
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
mato1992<-im.import("matogrosso_l5_1992219_lrg.jpg" )
im.plotRGB(mato1992, r=1, g=2, b=3)
# also
im.plotRGB(mato1992, 1, 2, 3)

#red healthy tropical forest, starts just at bottom to be ruined(greenish)

# put infrared in green
im.plotRGB(mato1992, r=2, g=1, b=3)
#now forest in green 

#put infrared in blue
im.plotRGB(mato1992, r=3, g=2, b=1)


#plot 2006
mato2006<-im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(mato2006, r=2, g=1, b=3)

im.plotRGB(mato2006, r=3, g=2, b=1)
##yellow enhances bare soil
#we get yellow putting nir in blue position

