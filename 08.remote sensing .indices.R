## use mato grosso info brazil forest

library(imageRy) # beloved package developed at unibo
library(terra)
library(ggplot2)
library(viridis)

im.list()

im.import("matogrosso_l5_1992219_lrg.jpg" )


## 3 bands to use NIR 1 RED 2 GREEn 3 
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
##yellow enhances
#we get yellow putting inr in blue position
