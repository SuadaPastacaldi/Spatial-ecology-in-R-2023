library(terra)
library(imageRy)

library(viridis)
vir<-colorRampPalette(viridis(7))(255)
mako<-colorRampPalette(mako(7))(255)
magma<-colorRampPalette(magma(7))(255)
#############################################################################################################

#Analysis of 3 areas
#1 Mugello
#2 Lago di bilancino
#3 Cave di Brento

##############################################################################################################
#1 Mugello

################################### 2024 ##############################

setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/Spacial project/2024")

#tiff for georeference ( get coordinates and extent)
tiff<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L2A_True_color.tiff")
tiff



#created color palettes for sentinel-2 bands
# 2- blue
cb<-colorRampPalette(c("blue", "lightblue", "white")) (100)
# 3- green
cg<-colorRampPalette(c("darkgreen", "green", "white")) (100)
# 4- red
cr<-colorRampPalette(c("red", "orange", "white")) (100)
# 8- nir
cn<-colorRampPalette(c("purple", "pink", "white")) (100)

#import bands
b2.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B02_(Raw).jpg")
b3.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B03_(Raw).jpg")
b4.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B04_(Raw).jpg")
b8.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B08_(Raw).jpg")


plot(b2.24, col=cb)
plot(b3.24, col=cg)
plot(b4.24, col=cr)
plot(b8.24, col=cn)

#put the 4 bands in a frame
par(mfrow=c(2,2))
plot(b2.24, col=cb)
plot(b3.24, col=cg)
plot(b4.24, col=cr)
plot(b8.24, col=cn)

dev.off()

#extent of b8 doesn't match the other 3
b2.24
b3.24
b4.24
b8.24

#change extent of b8 image using b2's extents
ext(b8.24)<-ext(b2.24)
b8.24_disagg<-disagg(b8.24, 2) 
b8.24_resampled<-resample(b8.24_disagg, b2.24) 
b8.24_resampled
plot(b8.24_resampled)

stack24 <- c(b2.24,b3.24,b4.24, b8.24_resampled)
names(stack24)<-c("B2", "B3","B4","B8")
plot(stack24, col=vir)

#reality's colors with rgb
im.plotRGB(stack24, r=3, g=2, b=1)

#putting nir in green band we can enhance vegetation
im.plotRGB(stack24, r=3, g=4, b=1)

#false color
im.plotRGB(stack24, 4, 3, 2)

################SWIR - Short Wave Infrared RGB Composite
#Sentinel-2: B12, B8A, B04
b12.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B12_(Raw).jpg")
b8A.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B8A_(Raw).jpg")
b4.24

b12.24
b8A.24
b4.24


### change extent of b4 image

ext(b4.24)<-ext(b12.24)
b4.24_disagg<-disagg(b4.24, 2) 
b4.24_resampled<-resample(b4.24_disagg, b12.24) 

#make a stack
stackswir24<-c(b12.24, b8A.24, b4.24_resampled)
plot(stackswir24, col=vir)

#plot of SWIR index
im.plotRGB(stackswir24, 1, 2, 3)




################################## 2016 #######################################

setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/Spacial project/2016")

#importo bande 2 3 4 8 con resolution 10 m

b2.16<-rast("2016-01-20-00_00_2016-01-20-23_59_Sentinel-2_L1C_B02_(Raw).jpg")
b3.16<-rast("2016-01-20-00_00_2016-01-20-23_59_Sentinel-2_L1C_B03_(Raw).jpg")
b4.16<-rast("2016-01-20-00_00_2016-01-20-23_59_Sentinel-2_L1C_B04_(Raw).jpg")
b8.16<-rast("2016-01-20-00_00_2016-01-20-23_59_Sentinel-2_L1C_B08_(Raw).jpg")

plot(b2.16, col=cb)
plot(b3.16, col=cg)
plot(b4.16, col=cr)
plot(b8.16, col=cn)

par(mfrow=c(2,2))
plot(b2.16, col=cb)
plot(b3.16, col=cg)
plot(b4.16, col=cr)
plot(b8.16, col=cn)

dev.off()


### change extent of b8 image

ext(b8.16)<-ext(b2.16)
b8.16_disagg<-disagg(b8.16, 2) 
b8.16_resampled<-resample(b8.16_disagg, b2.16) 
b8.16_resampled
plot(b8.16_resampled)

stack16<-c(b2.16,b3.16,b4.16, b8.16_resampled)
names(stack16)<-c("B2", "B3","B4","B8")
plot(stack16, col=vir)

#reality's colors with rgb
im.plotRGB(stack16, r=3, g=2, b=1)

################SWIR - Short Wave Infrared RGB Composite
#Sentinel-2: B12, B8A, B04
b12.16<-rast("2016-01-20-00_00_2016-01-20-23_59_Sentinel-2_L1C_B12_(Raw).jpg")
b8A.16<-rast("2016-01-20-00_00_2016-01-20-23_59_Sentinel-2_L1C_B8A_(Raw).jpg")
b4.16

b12.16
b8A.16
b4.16


#change extent of b4 image using b12's

ext(b4.16)<-ext(b12.16)
b4.16_disagg<-disagg(b4.16, 2) 
b4.16_resampled<-resample(b4.16_disagg, b12.16) 

#make a stack
stackswir16<-c(b12.16, b8A.16, b4.16_resampled)
plot(stackswir16, col=vir)
im.plotRGB(stackswir16, 1, 2, 3)

####################### 2016-2024 ############################
par(mfrow=c(1,2))
#reality
im.plotRGB(stack16, r=3, g=2, b=1)
title("2016", line = 0.5)
im.plotRGB(stack24, r=3, g=2, b=1)
title("2024",line = 0.5)

#false color
im.plotRGB(stack16, 4, 3, 2)
title("2016", line = 0.5)
im.plotRGB(stack24, 4, 3, 2)
title("2024",line = 0.5)


#swir
im.plotRGB(stackswir16, 1, 2, 3)
title("2016", line = 0.5)
im.plotRGB(stackswir24, 1, 2, 3)
title("2024",line = 0.5)

dev.off()



##############################################################################################################
#2 Lago di Bilancino


############################## BILANCINO ################################

############################## DICEMBRE ############################
setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/Spacial project/bilancino dicembre")

#tiff for georeference
tiff<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L2A_True_color (1).tiff")
tiff


bb8.d<-rast("2023-12-19-00_00_2023-12-19-23_59_Sentinel-2_L1C_B08_(Raw).jpg")
bb2.d<-rast("2023-12-19-00_00_2023-12-19-23_59_Sentinel-2_L1C_B02_(Raw).jpg")
bb3.d<-rast("2023-12-19-00_00_2023-12-19-23_59_Sentinel-2_L1C_B03_(Raw).jpg")
bb4.d<-rast("2023-12-19-00_00_2023-12-19-23_59_Sentinel-2_L1C_B04_(Raw).jpg")

#change extent of b8 image
ext(bb8.d)<-ext(bb2.d)
bb8.d_disagg<-disagg(bb8.d, 2) 
bb8.d_resampled<-resample(bb8.d_disagg, bb2.d) 
bb8.d_resampled
plot(bb8.d_resampled)
bstackd<-c(bb2.d, bb3.d, bb4.d,bb8.d_resampled )

im.plotRGB(bstackd, 3, 2, 1)
im.plotRGB(bstackd, 3, 2, 4)

dev.off()
################################### LUGLIO ######################################
setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/Spacial project/bilancino luglio")

bb2.l<-rast("2023-07-07-00_00_2023-07-07-23_59_Sentinel-2_L1C_B02_(Raw).jpg")
bb3.l<-rast("2023-07-07-00_00_2023-07-07-23_59_Sentinel-2_L1C_B03_(Raw).jpg")
bb4.l<-rast("2023-07-07-00_00_2023-07-07-23_59_Sentinel-2_L1C_B04_(Raw).jpg")
bb8.l<-rast("2023-07-07-00_00_2023-07-07-23_59_Sentinel-2_L1C_B08_(Raw).jpg")

#change extent of b8 image
ext(bb8.l)<-ext(bb2.l)
bb8.l_disagg<-disagg(bb8.l, 2) 
bb8.l_resampled<-resample(bb8.l_disagg, bb2.l) 
bb8.l_resampled
plot(bb8.l_resampled)
bstackl<-c(bb2.l, bb3.l, bb4.l,bb8.l_resampled )

im.plotRGB(bstackl, 3, 2, 1)


##############################################################################

par(mfrow=c(1,2))
im.plotRGB(bstackl,3,2,1)
title("July", line = 1)
im.plotRGB(bstackd, 3,2,1)
title("December", line = 1)


dev.off()
##############################################################################

#Normalized Difference Water Index (NDWI)
#Sentinel-2 NDWI = (B03 - B08) / (B03 + B08)
ndwiD<-(bb3.d-bb8.d) /(bb3.d + bb8.d)
plot(ndwiD, col=cb)


ndwiL<-(bb3.l-bb8.l) /(bb3.l + bb8.l)
plot(ndwiL, col=cb)


par(mfrow=c(1,2))
plot(ndwiL, col=mako)
title("July", line = -1)
plot(ndwiD, col=mako)
title("December", line =-1)

dev.off()

diff=ndwiD-ndwiL
plot(diff, col=vir)
title("Difference in NDWI December - July", line = 3)

par(mfrow=c(1,2))
dclass<-im.classify(ndwiD)
plot(dclass, col=mako)
lclass<-im.classify(ndwiL)
plot(lclass, col=mako)

fd<-freq(dclass)
ncell(dclass)
fl<-freq(lclass)
ncell(lclass)

#percentage of class 1-> water
dwater<-fd/ncell(dclass) * 100
lwater<-fl/ncell(lclass) *100
dwater
lwater


########################### graph
library(ggplot2)

#build columns of table
Classes<- c("Vegetation","Others", "Water")
December<-c(56, 35, 9)
July<-c(71.5,27,1.5)

tabella<-data.frame(Classes,December,July)


# final plot


p1 <- ggplot(tabella, aes(x=Classes, y=December, color=Classes)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabella, aes(x=Classes, y=July, color=Classes)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1
p2


dev.off()




##############################################################################################################
#3 Cave di Brento

############################### CAVE ################################
################################ 2024 ######################################

setwd("C:/Users/suada/OneDrive - University of Pisa/Desktop/Spacial project/frena24")

#tiff for georeference
tiff<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L2A_True_color (2).tiff")
tiff

fb2.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B02_(Raw).jpg")
fb3.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B03_(Raw).jpg")
fb4.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B04_(Raw).jpg")
fb8.24<-rast("2024-02-02-00_00_2024-02-02-23_59_Sentinel-2_L1C_B08_(Raw).jpg")

#change extent of b8 image
ext(fb8.24)<-ext(fb2.24)
fb8.24_disagg<-disagg(fb8.24, 2) 
fb8.24_resampled<-resample(fb8.24_disagg, fb2.24) 
fb8.24_resampled
plot(fb8.24_resampled)


fstack24<-c(fb2.24, fb3.24, fb4.24,fb8.24_resampled)
#reality's colors
im.plotRGB(fstack24, 3, 2, 1)
#false color
im.plotRGB(fstack24,4, 3, 2)


dev.off()

############################ NDVI ###########################################


ndvi24<-(fb8.24-fb4.24)/(fb8.24+fb4.24)
plot(ndvi24, col=vir)
plot(ndvi24, col=mako)


plot(ndvi24, col=magma)

dev.off()
############################ VARIABILITY  ####################################
#using  only nir band

fb8.24
plot(fb8.24, col=vir)

sd3<-focal(fb8.24, matrix(1/9,3,3), fun=sd) 
sd3
plot(sd3)
plot(sd3, col=mako)

#calculate variability in 7x7 pixel moving window
sd7<-focal(fb8.24, matrix(1/49,7,7), fun=sd) 
plot(sd7, col=mako)


par(mfrow=c(1,2))
plot(sd7, col=mako)
title("Variability (sd)", line = -1)
im.plotRGB(fstack24, 3, 2, 1)

dev.off()
############################# VARIABILITY PCA ##################################
pairs(fstack24)
#sentinel 2 and 3 (red and green) are very related to each other (0.98)
# nir is less correlated
#last raw sent 4 is just a control layer

pc<-im.pca(fstack24)
pc
plot(pc, col=vir)

#the 1 is the the band with the highest possible range
pc1<-pc$PC1

plot(pc1, col=mako)

pc1sd3<-focal(pc1, matrix(1/9, 3, 3), sd)
plot(pc1sd3, col=magma)
title("Variability on PC1 in a 3x3 moving window", line = 2.5)

#on 7 by 7
pc1sd7<-focal(pc1, matrix(1/49, 7, 7), sd)
plot(pc1sd7, col=magma)
title("Variability on PC1 in a 7x7 moving window", line = 2.5)


par(mfrow=c(1,2))
plot(pc1sd3, col=magma)
title("Variability (sd)", line = -1)
im.plotRGB(fstack24, 3, 2, 1)

dev.off()



