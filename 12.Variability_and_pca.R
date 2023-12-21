#measuring of RS based variability 
#important in abiotic and biotic component

#measuring of RS based variability 
#important in abiotic and biotic component

#libraries we need
library(imageRy)
library(terra)
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
####PCA
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
