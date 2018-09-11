getwd()
setwd("C:/Users/cesar ascencio/Desktop/Data_Science_especialización/Curso4_Exploratory Data Analisis/Semana4/Evaluación")
datos<- readRDS("summarySCC_PM25.rds")
clasi<-readRDS("Source_Classification_Code.rds")
View(clasi)
head(datos)

str(datos)

## QUESTION2:l Have total emissions from PM2.5 decreased in the Baltimore City, 
##Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot
#answering this question.

png("Plot_2.png", width = 700, height = 700)
par(mfrow=c(1,2), mar=c(4,4,2,1))

BaltimoreCity <- subset(datos, fips == "24510")

totalPM25ByYear <- tapply(BaltimoreCity$Emissions, BaltimoreCity$year, sum)
meanPM25ByYear <- tapply(BaltimoreCity$Emissions, BaltimoreCity$year, mean)

plot(names(totalPM25ByYear), totalPM25ByYear, type = "l", xlab = "Year", col=2,
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))

plot(names(meanPM25ByYear), meanPM25ByYear, type = "l", xlab = "Year", col=3,
     ylab = expression("Mean" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Mean Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()