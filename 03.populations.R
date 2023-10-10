#species distribution modelling
bei #dataset

plot(bei)

#to decrease size
plot(bei, cex=0.5)

#density map
#from points to continuous surface --> interpolation
density(bei)

#and assigning it to an object
treedensitymap<-density(bei)

# we passed from points to pixels, that we can plot
plot(treedensitymap)

#to put points on top of density map
points(bei, cex=.2)

#change colors, we need an array of colours(function c),
#and specify how many colors we need in between (100)
colorRampPalette(c("black", "red", "orange", "yellow"))(100)
cl<-colorRampPalette(c("black", "red", "orange", "yellow"))(100)

#plot them toghether
plot(treedensitymap, col = cl)

points(bei, cex=.2, col="white")
