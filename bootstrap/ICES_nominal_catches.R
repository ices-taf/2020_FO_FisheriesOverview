# wd: bootstrap/data/ICES_nominal_catches

library(icesTAF)
taf.library(icesFO)

hist <- load_historical_catches()
write.taf(hist, file = "bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv", quote = TRUE)

official <- load_official_catches()
write.taf(official, file = "bootstrap/data/ICES_nominal_catches/ICES_2006_2018_catches.csv", quote = TRUE)

prelim <- load_preliminary_catches(2019)
write.taf(prelim, file = "bootstrap/data/ICES_nominal_catches/2019PreliminaryCatchStatistics.csv", quote = TRUE)


load_preliminary_catches <- function (year){
        url<- "http://data.ices.dk/rec12/download/1bjygg4mzskn1idq5tusannp569A0.csv"
        tmpFilePrelimCatch <- tempfile(fileext = ".csv")
        download.file(url, destfile = tmpFilePrelimCatch, mode = "wb", quiet = TRUE)
        out <- read.csv(tmpFilePrelimCatch,
                        stringsAsFactors = FALSE,
                        header = TRUE,
                        fill = TRUE)
        out
}
