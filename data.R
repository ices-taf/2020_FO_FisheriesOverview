
# Initial formatting of the data

library(icesTAF)
taf.library(icesFO)
library(dplyr)

mkdir("data")

# load species list
species_list <- read.taf("bootstrap/data/FAO_ASFIS_species/species_list.csv")
sid <- read.taf("bootstrap/data/ICES_StockInformation/sid.csv")


# 1: ICES official catch statistics

hist <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_historical_catches.csv")
official <- read.taf("bootstrap/data/ICES_nominal_catches/ICES_2006_2018_catches.csv")
prelim <- read.taf("bootstrap/data/ICES_nominal_catches/2019PreliminaryCatchStatistics.csv")

# catch_dat <-
#   format_catches(2020, "Faroes",
#     hist, official, prelim, species_list, sid)
catch_dat <-
        format_catches(2020, "Faroes",
                       hist, official,NULL,species_list, sid)

write.taf(catch_dat, dir = "data", quote = TRUE)


# 2: Effort and landings, need to figure out data to be used


# 3: SAG
sag_sum <- read.taf("bootstrap/data/SAG_data/SAG_summary.csv")
sag_refpts <- read.taf("bootstrap/data/SAG_data/SAG_refpts.csv")
sag_status <- read.taf("bootstrap/data/SAG_data/SAG_status.csv")

clean_sag <- format_sag(sag_sum, sag_refpts, 2021, "Faroes")
clean_status <- format_sag_status(sag_status, 2021, "Faroes")

check <- unique(clean_sag$StockKeyLabel)
unique(clean_sag$StockKeyLabel)
#51
unique(FO_2020FO_StockList_1$StockKeyLabel)
#53

# Stocks not showing up in SAG
setdiff(FO_2020FO_StockList_1$StockKeyLabel,clean_sag$StockKeyLabel)

#[1] "whg.27.6a"  "anf.27.1-2"

#check
setdiff(clean_sag$StockKeyLabel, FO_2020FO_StockList_1$StockKeyLabel)
#character(0)

unique(clean_status$StockKeyLabel)

setdiff(FO_2020FO_StockList_1$StockKeyLabel,clean_status$StockKeyLabel)
#[1] "whg.27.6a"    "thr.27.nea"   "anf.27.1-2"   "sal.neac.all"

write.taf(clean_sag, dir = "data")
write.taf(clean_status, dir = "data", quote = TRUE)
