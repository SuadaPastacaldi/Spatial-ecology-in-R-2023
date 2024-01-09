
#time relation between species
#especially with animals, we get the info with camera traps
#we get where and at what time the certain species passed
#to see overlap between two niches

library(overlap)

data(kerinci)
head(kerinci) #to show some data (not all species)
summary(kerinci) #gives the abstract of the data

#3 columns- zone, specie(sps), time

##let's use only specie tiger, new dataset with only tiger
kerinci[kerinci$Sps=="tiger",] #we need closure with the final coma
tiger<-kerinci[kerinci$Sps=="tiger",]

summary(tiger)

#to pass from linear time and make it circular time (moltiplico per 2pigreco)
kerinci$Time * 2 * pi
#add a column to kerinci with circular time
kerinci$timeRad <- kerinci$Time * 2 * pi

head(kerinci)

#relaunch tiger with new column
kerinci$timeRad <- kerinci$Time * 2 * pi
tiger<-kerinci[kerinci$Sps=="tiger",]
head(tiger)

#function density plot, shows the amount of time a certain species has been seen
# selecting the time for the tiger
timetig <- tiger$timeRad
#distribution of tiger data during the day
densityPlot(timetig, rug=TRUE)

#select macaque as the species
macaque<-kerinci[kerinci$Sps=="macaque",]
#time
timemac <- macaque$timeRad
#distribution of macaque data during the day
densityPlot(timemac, rug=TRUE)

#lets overlap the two distribution
#function overlapPlot, colours the overlapping distribution
overlapPlot(timetig, timemac)
