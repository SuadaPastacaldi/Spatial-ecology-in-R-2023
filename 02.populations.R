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


