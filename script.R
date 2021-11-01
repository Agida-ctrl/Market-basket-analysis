#market backet analysis for a supermarket

#load packages and library
install.packages("arules")
install.packages("arulesViz")
install.packages("tidyverse")
install.packages("readxml")
install.packages("knitr")
install.packages("lubridate")
install.packages("plyr")


library(plyr)
library(dplyr)
library(arules)
library(arulesViz)
library(tidyverse)
library(readxl)
library(knitr)
library(ggplot2)
library(lubridate)


retail <- read_excel("Online Retail.xlsx")
skimr::skim(retail)

##Data preprocessing
retail <- retail[complete.cases(retail), ]
retail<-retail %>% mutate(Description = as.factor(Description))
retail<-retail %>% mutate(Country = as.factor(Country))
retail$Date <- as.Date(retail$InvoiceDate)
retail$Time<- format(retail$InvoiceDate,"%H:%M:%S")
retail$InvoiceNo <- as.numeric(as.character(retail$InvoiceNo))
skimr::skim(retail)

#Creating transaction data frame
transactionData <- ddply(retail,c("InvoiceNo","Date"),
                         function(df1)paste(df1$Description,
                                            collapse = ","))
#Removing InvoiceId and date column
transactionData$InvoiceNo <- NULL
transactionData$Date <- NULL
colnames(transactionData) <- c("items")
glimpse(transactionData)

#storing the transaction data so it can be loaded back using the arule package
write.csv(transactionData,"Market_basket_data.csv",quote = FALSE, row.names = FALSE)

tr <- read.transactions("Market_basket_data.csv",
                        format = 'basket', sep=',')
rm(transactionData)
summary(tr)

# Create an item frequency plot for the top 20 items
library(RColorBrewer)
itemFrequencyPlot(tr,topN=20,type="relative",col=brewer.pal(8,'Pastel2'),
                  main="relative Item Frequency Plot")
#WHITE HANGING HEART T-LIGHT HOLDER make up close to 1% of item frequency
###This plot shows that 'WHITE HANGING HEART T-LIGHT HOLDER' and 
###'REGENCY CAKESTAND 3 TIER' have the most sales. 
###So to increase the sale of 'SET OF 3 CAKE TINS PANTRY DESIGN' 
###the retailer can put it near 'REGENCY CAKESTAND 3 TIER'

##Apriori algorithm
association.rules <- apriori(tr, 
                             parameter = list(supp=0.001, conf=0.8
                                              ,maxlen=8))
summary(association.rules)
inspect(association.rules[1:10])

##Limiting the number and size of rules
shorter.association.rules <- apriori(tr, parameter = list(supp=0.001, conf=0.8,maxlen=3))
subset.rules <- which(colSums(is.subset(association.rules, association.rules)) > 1) # get subset rules in vector
#remove rules that are subsets of larger rules.
length(subset.rules)  
rules <- association.rules[-subset.rules] # remove subset rules.
##metal.association.rules <- apriori(tr, parameter = list(supp=0.001, conf=0.8),appearance = list(default="lhs",rhs="METAL"))#rules for specific item


#Results

subRules<-rules[quality(rules)$confidence>0.8]
plot(subRules,shading = "support",
     method="two-key plot")#scatter plot if confidence and support


## interactive Graph
top10Rules <- head(rules, n = 10, by = "confidence")
plot(top10Rules, method = "graph",  engine = "htmlwidget")
saveAsGraph(head(subset.association.rules.,
                 n = 1000, by = "lift"),
            file = "rules.graphml")

#Individual Rule Representation
subRules2<-head(rules, n=20, by="lift")
plot(subRules2, method="paracoord")
png(filename = "Results.png")
dev.off()
