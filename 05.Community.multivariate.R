# how species are related to each other in time
#multivariate analysis 
#rescale all data in just two dimentions 

# with vegan package, vegetation analysis
library(vegan)
# ordination methods (ordinate em in space-->multivariate analysis)


# dataset called dune, vegetation on them
#recall data

data("dune")
dune #shows data

# or use head function, shows only first 6 rows
head(dune)

#or use tail function


####MULTIVARIATE ANALYSIS
#decorana function, detrended correspondence analysis
#other methods, pc,correspondence analysis...

ord<-decorana(dune)
ord #to see data

#4 axis, we use two to scale the whole data, ex first two
#measure lenght of pc1 ( so the percentage of data that it covers)

ldc1=3.7004
ldc2=3.1166 
ldc3=1.30055
ldc4=1.47888

total<- ldc1+ldc2+ldc3+ldc4

#percentages of data in each of the 4 axis
pldc1<-ldc1*100/total
pldc2<-ldc2*100/total
pldc3<-ldc3*100/total
pldc4<-ldc4*100/total

#lenght of each axis
pldc1
pldc2
pldc3
pldc4

# guardo quale più grande per pc1
#ex ppldc1+pldc2 contiene la maggior parte delle info

pldc1+pldc2

plot(ord)

#from table we camn not get the relations between different species
# we are interested in spatial relations that we get from graph with 2 axis
