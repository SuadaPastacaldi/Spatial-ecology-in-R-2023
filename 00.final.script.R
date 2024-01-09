#Final script including all lectures scripts

#-----------------------------------------------
#summary
#01 beginning
#02 population density
#03 population

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

#02 population

# code related to populations ecology
# package needed for point pattern analysis is spatstat
install.packages("spatstat") #quotes are needed every time you get out of R and back
# to check if it's there
library(spatstat) #no quotes needed cause inside R

# bei data
# data description: link
bei #(trees disposition data)
Planar point pattern: 3604 points
window: rectangle = [0, 1000] x [0, 500] metres

# plotting data 
plot(bei)
#changing dimention with carachter exageration cex
plot(bei, cex=0.5)
plot(bei, cex=0.2)
#changing the symbol
plot(bei, cex=0.3, pch=19)

# additional data set bei.extra
bei.extra
List of pixel images

elev:
real-valued pixel image
101 x 201 pixel array (ny, nx)
enclosing rectangle: [-2.5, 1002.5] x [-2.5, 502.5] 
metres

grad:
real-valued pixel image
101 x 201 pixel array (ny, nx)
enclosing rectangle: [-2.5, 1002.5] x [-2.5, 502.5] 
metres

#plotting
plot(bei.extra)
# raster file images (elev and grad),
# filtering info, we only need one part of the two, the elevation. 2 ways to do that
plot(bei.extra$elev) #use a $ as a link those objects
#or
elevation<-bei.extra$elev
plot(elevation)
#or another method to select only one element
elevation1<- bei.extra[[1]] #double [] because we are on 2 dimensions, an image
plot(elevation1)


#------------------------------------------------


