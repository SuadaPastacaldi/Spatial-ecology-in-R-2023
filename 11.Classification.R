## Classify satellite images and estimate the amount of change
#vgetetation no reflection of red, high reflectance in near infrared
#water high reflection of red, near infrared absorbed

#training sized
#to explain the server what are the clusters (set of objects with the same characteristics)
#ex. of clusters in our case ( lake, forest, city, agro field) more or less same kind of reflection in a particular area
#minimum distance from class --> method to distinguish if one particular pixel is in which class (for any kind of pixel in my image that is not a training size)

####Classify
library(terra)
library(imageRy)
library(ggplot2)

install.packages("patchwork")
library(patchwork)

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#directly plotted by R 
plotRGB(sun, 1, 2, 3)
#3 levels of energy, black, organgy, white
#created by the algorithm that selects pixels similar to each other
#classify the image
#im.classify(image, number of clusters)

sun1<-im.classify(sun, num_clusters = 3)
sun1


##plot un 1
plot(sun1)
#gives tree images exactly the same replicated
plot(sun1[[1]])

# 1)white has the highest energy down to the third class with the lowest
#let's apply it to the mato grosso forest to quantify the amount of change in the forest

#import images
im.list()
#[21] "matogrosso_ast_2006209_lrg.jpg"                    
#[22] "matogrosso_l5_1992219_lrg.jpg"   
m1992<-im.import("matogrosso_l5_1992219_lrg.jpg")
m2006<-im.import("matogrosso_ast_2006209_lrg.jpg" )

#plotrgb
plotRGB(m1992)
#water in combination with the infrared shuld be black since it absorbs all infrared
#in this image we can not distinguish 

#create a classification with 2 clusters 1 for forest 1 for all others(water, urban, deforested)
m1992c<-im.classify(m1992, 2)
plot(m1992c[[1]])
#CLASSES:
#1=human intervention, water
#2=forest

#classify second image
m2006c<-im.classify(m2006,2)
plot(m2006c[[1]])
#same classes

par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

#quantufy change
#function calculating the frequency of a certain class
#freq(image)

f1992<-freq(m1992c)
f2006<-freq(m2006c)
f1992

#compute percentage of pixel class
#ncell() calculate n of pixels in an image

tot19992<-ncell(m1992c)

#percentage
#frequency/tot pixels * 100

#1992
p1992<-f1992/tot19992*100
p1992
#forest=83%
#humans=17%

#2006
tot2006<-ncell(m2006c)

p2006<-f2006/tot2006*100
p2006
#forest=45%
#humans=55%


#make a graph 
#build a dataframe with all the data --> forest, human, percentages, 2006, 1992
#function data.frame()

#build columns of table
class<- c("forest", "humans")
y1992<-c(83,17)
y2006<-c(45,55)

tabella<-data.frame(class,y1992, y2006)
tabella

#to graph need ggplot2
library(ggplot2)

# final plot
#function ggplot(object, aes()+ geom_bar())
#aes, aesthetics
#fill, colour of filling

p1 <- ggplot(tabella, aes(x=class, y=y1992, color=class) + geom_bar(stat="identity", fill="white"))
p2 <- ggplot(tabella, aes(x=class, y=y2006, color=class) + geom_bar(stat="identity", fill="white"))
p1+p2
