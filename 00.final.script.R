#Final script including all lectures scripts

#-----------------------------------------------
#summary
#01 beginning
#02 population ecology
#03 population distribution 

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


