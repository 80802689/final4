getwd()
setwd("C:/Users/cesar ascencio/Desktop/Data_Science_especialización/Curso4_Exploratory Data Analisis/Semana4/Evaluación")
datos<- readRDS("summarySCC_PM25.rds")
clasi<-readRDS("Source_Classification_Code.rds")
View(clasi)
head(datos)

str(datos)

## QUESTION3:Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#3Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
##answer this question.

install.packages("plyr")
library(plyr)
install.packages("ggplot2")
library(ggplot2)

png("Plot_3.png", width = 400, height = 400)
BaltimoreCity <- subset(datos, fips == "24510")
typePM25ByYear <- ddply(BaltimoreCity, .(year, type), function(x) sum(x$Emissions))
colnames(typePM25ByYear)[3] <- "Emissions"

qplot(year, Emissions, data = typePM25ByYear, color = type, geom = "line") +
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ 
                                   "Emissions by Source Type and Year")) + xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()