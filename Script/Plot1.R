getwd()
setwd("C:/Users/cesar ascencio/Desktop/Data_Science_especialización/Curso4_Exploratory Data Analisis/Semana4/Evaluación")
datos<- readRDS("summarySCC_PM25.rds")
clasi<-readRDS("Source_Classification_Code.rds")
View(clasi)
head(datos)
str(datos)

## QUESTION 1:  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all
#sources for each of the years 1999, 2002, 2005, and 2008.

totalPM25ByYear <- tapply(datos$Emissions,datos$year,sum)
meanPM25ByYear <- tapply(datos$Emissions,datos$year,mean)

png("Plot_1.png", width = 700, height = 700)
par(mfrow=c(1,2), mar=c(4,4,2,1))

plot(names(totalPM25ByYear), totalPM25ByYear, type = "l", col=2, 
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))

plot(names(meanPM25ByYear), meanPM25ByYear, type = "l", col=3, 
     xlab = "Year", ylab = expression("Mean" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Mean US" ~ PM[2.5] ~ "Emissions by Year"))

dev.off()
