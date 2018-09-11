getwd()
setwd("C:/Users/cesar ascencio/Desktop/Data_Science_especialización/Curso4_Exploratory Data Analisis/Semana4/Evaluación")
datos<- readRDS("summarySCC_PM25.rds")
clasi<-readRDS("Source_Classification_Code.rds")
View(clasi)
head(datos)

str(datos)

# Question 5:
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# Assume "Motor Vehicles" only means on road
BaltimoreCityMV <- subset(datos, fips == "24510" & type=="ON-ROAD")

BaltimoreMVPM25ByYear <- ddply(BaltimoreCityMV, .(year), 
                               function(x) sum(x$Emissions))
colnames(BaltimoreMVPM25ByYear)[2] <- "Emissions"
png("Plot_5.png", width = 700, height = 700)
qplot(year, Emissions, data=BaltimoreMVPM25ByYear, geom="line") +
        ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions
                           by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
