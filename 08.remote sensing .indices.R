## use mato grosso info brazil forest
## comparison 1992-2006 situation

library(imageRy) 
library(terra)
library(ggplot2)
library(viridis)

im.list()
 [1] "dolansprings_oli_2013088_canyon_lrg.jpg"           
 [2] "EN_01.png"                                         
 [3] "EN_02.png"                                         
 [4] "EN_03.png"                                         
 [5] "EN_04.png"                                         
 [6] "EN_05.png"                                         
 [7] "EN_06.png"                                         
 [8] "EN_07.png"                                         
 [9] "EN_08.png"                                         
[10] "EN_09.png"                                         
[11] "EN_10.png"                                         
[12] "EN_11.png"                                         
[13] "EN_12.png"                                         
[14] "EN_13.png"                                         
[15] "greenland.2000.tif"                                
[16] "greenland.2005.tif"                                
[17] "greenland.2010.tif"                                
[18] "greenland.2015.tif"                                
[19] "info.md"                                           
[20] "iss063e039892_lrg.jpg"                             
[21] "matogrosso_ast_2006209_lrg.jpg"                    
[22] "matogrosso_l5_1992219_lrg.jpg"                     
[23] "NDVI_rainbow.png"                                  
[24] "NDVI_rainbow_legend.png"                           
[25] "sentinel.dolomites.b2.tif"                         
[26] "sentinel.dolomites.b3.tif"                         
[27] "sentinel.dolomites.b4.tif"                         
[28] "sentinel.dolomites.b8.tif"                         
[29] "sentinel.png"                                      
[30] "Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg"

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
##yellow enhances
#we get yellow putting inr in blue position
