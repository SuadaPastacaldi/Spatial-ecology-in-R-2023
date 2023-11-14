## time series analysis
library(terra)
library(imageRy)

#in sentinel there is a band measuring no2 in atmosphere
im.list()

#different nitrogen situation in europe
#import EN 01 (europe nitrogen)
#situation in january
EN01<-im.import("EN_01.png")
##situation in march
EN13<-im.import("EN_13.png")


#make a multiframe

par(mfrow=c(1,2))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

##take just first band and make a difference
#to see how the data changed in time
#from january to march
diff=EN01[[1]]-EN13[[1]]

dev.off()
plot(diff)

#change palette
cldif<-colorRampPalette(c("blue", "white", "red"))(100)
plot(diff, col=cldif)

#red d be higher values in january, blue higher in march
dev.off()

## temperature in greenland (of surface)
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

#stck all images toghether
stackg<-c(g2000, g2005, g2010, g2015)
plot(stackg,col=clg)


dev.off()
#make difference between first and final element of file
gdiff=stackg[[1]]-stackg[[4]]
plot(gdiff, col=clg)

#or gdiff=g2000-g2015

#use three of the images to do an rgb 
im.plotRGB(stackg, r=1, g=2, b=3)
#if we have high values in 2015 everything is gonna be blueish/blackish
#if it was higher in the first band it would have been red and green for the second

#the inner part is increasing temperature, on coast is inverted situation

