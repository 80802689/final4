getwd()
setwd("C:/Users/cesar ascencio/Desktop/Data_Science_especialización/Curso4_Exploratory Data Analisis/Semana4/Evaluación")
datos<- readRDS("summarySCC_PM25.rds")
clasi<-readRDS("Source_Classification_Code.rds")
View(clasi)
head(datos)

str(datos)

## QUESTION4 Across the United States, how have emissions from 
##coal combustion-related sources changed from 1999-2008?
datos<- readRDS("summarySCC_PM25.rds")
clasi<-readRDS("Source_Classification_Code.rds")

CoalCombustionSCC <- subset(clasi, EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal",
                                                    "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal"))
# Compare to Short.Name matching both Comb and Coal
CoalCombustionSCC1 <- subset(clasi, grepl("Comb", Short.Name) & grepl("Coal",  Short.Name))

nrow(CoalCombustionSCC)
nrow(CoalCombustionSCC1)

d3 <- setdiff(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
d4 <- setdiff(CoalCombustionSCC1$SCC, CoalCombustionSCC$SCC)
length(d3)
length(d4)

CoalCombustionSCCCodes <- union(CoalCombustionSCC$SCC, CoalCombustionSCC1$SCC)
length(CoalCombustionSCCCodes)

CoalCombustion <- subset(datos, SCC %in% CoalCombustionSCCCodes)

coalCombustionPM25ByYear <- ddply(CoalCombustion, .(year, type), function(x) 
        sum(x$Emissions))
colnames(coalCombustionPM25ByYear)[3] <- "Emissions"

png("Plot_4.png", width = 700, height = 700)
qplot(year, Emissions, data = coalCombustionPM25ByYear, color = type, 
      geom = "line") + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ 
                                                  "Emissions by Source Type and Year")) + xlab("Year") + 
        ylab(expression  ("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

