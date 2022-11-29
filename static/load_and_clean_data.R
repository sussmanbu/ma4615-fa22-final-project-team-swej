library(tidyverse)

#haven package needed to read in .XPT data
library(haven)

#the two numbers refer to the years of the cycle, so 1718 means 2017-2018

#loading data

#taking a look at insurance data


#2017-2018
bpdata1718 <- read_xpt(here::here("dataset","BPXO_J1718.XPT"))
demodata1718 <- read_xpt(here::here("dataset", "DEMO_J1718.XPT"))

#2015-2016

#2013-2014

#2011-2012

#2009-2010 -> need to ask about this
bpdata0910 <- read_xpt(here::here("dataset","BPX_F0910.XPT"))
demodata0910 <- read_xpt(here::here("dataset","DEMO_F0910.XPT"))

#2007-2008

#2005-2006

#2003-2004

#2001-2002
bpdata0102 <- read_xpt(here::here("dataset","BPX_B0102.XPT"))
demodata0102 <- read_xpt(here::here("dataset","DEMO_B0102.XPT"))

#1999-2000
bpdata9900 <- read_xpt(here::here("dataset","DEMO.XPT"))
demodata9900 <- read_xpt(here::here("dataset","DEMO.XPT"))
################################################################################

#writing to .csv
#2017-2020
write_csv(bpdata1720, file = here::here("dataset", "bpdata1720.csv"))
save(bpdata1720, file = here::here("dataset/bpdata1720.RData"))


#2017-2018
write_csv(bpdata1718, file = here::here("dataset", "bpdata1718.csv"))
save(bpdata1718, file = here::here("dataset/bpdata1718.RData"))

write_csv(demodata1718, file = here::here("dataset", "demodata1718.csv"))
save(demodata1718, file = here::here("dataset/demodata1718.RData"))


#2009-2010
write_csv(bpdata0910, file = here::here("dataset","bpdata0910.csv"))
save(bpdata0910, file = here::here("dataset/bpdata0910.RData"))

write_csv(demodata0910, file = here::here("dataset","demodata0910.csv"))
save(demodata0910, file = here::here("dataset/demodata0910.RData"))

#2001-2002
write_csv(bpdata0102, file = here::here("dataset","bpdata0102.csv"))
save(bpdata0102, file = here::here("dataset","bpdata0102.RData"))

write_csv(demodata0102, file = here::here("dataset","demodata0102.csv"))
save(demodata0102, file = here::here("dataset","demodata0102.RData"))


#library call and loading in necessary data sets
#before i start, the general algorithm will be to load in the demographics and BP data for the 3 datasets (so 6 sets). Remove NAs. For each dataset, demographics and BP will be joined by ID number, so only observations with ID numbers in both datasets can be considered. Following the joins, the datasets will include a variable for year of collection (to be coded for each set). After all of this, the datasets will be stacked for analysis. also important to note, the names of certain variables change between datasets, so were gonna have to do some renaming to keep things consistent.

#loading in data and libraries
bpdata1718 <- read_csv(here::here("dataset/bpdata1718.csv"))
demodata1718 <- read_csv(here::here("dataset/demodata1718.csv"))

bpdata0910 <- read_csv(here::here("dataset/bpdata0910.csv"))
demodata0910 <- read_csv(here::here("dataset/demodata0910.csv"))

bpdata0102 <- read_csv(here::here("dataset/bpdata0102.csv"))
demodata0102 <- read_csv(here::here("dataset/demodata0102.csv"))

######################################################################

#cleaning, combining, and getting data into working order for 01, 109, and 17

##creating variables for mean BP readings
bpdata1718 <- bpdata1718 %>% mutate(MeanDia = rowMeans(select(.,BPXODI1,BPXODI2,BPXODI3), na.rm = TRUE)) %>% mutate(MeanSys = rowMeans(select(.,BPXOSY1,BPXOSY2,BPXOSY3), na.rm = TRUE))

#ask if NaN will cause issues
bpdata0910 <- bpdata0910 %>% mutate(MeanDia = rowMeans(select(.,BPXDI1,BPXDI2,BPXDI3), na.rm = TRUE)) %>% mutate(MeanSys = rowMeans(select(.,BPXSY1,BPXSY2,BPXSY3), na.rm = TRUE))

bpdata0102 <- bpdata0102 %>% mutate(MeanDia = rowMeans(select(.,BPXDI1,BPXDI2,BPXDI3), na.rm = TRUE)) %>% mutate(MeanSys = rowMeans(select(.,BPXSY1,BPXSY2,BPXSY3), na.rm = TRUE))

##combine bp and demo for each year
combo1718 <- bpdata1718 %>% inner_join(demodata1718, by = "SEQN")
combo0910 <- bpdata0910 %>% inner_join(demodata0910, by = "SEQN")
combo0102 <- bpdata0102 %>% inner_join(demodata0102, by = "SEQN")

##adding coding for year for each dataset and subsetting for stacking
###0 = 01-02, 1 = 09-10, 2 = 17-18
combo0102 <- combo0102 %>% mutate(Year = factor(0)) %>% select(MeanDia, MeanSys, RIAGENDR, RIDAGEYR, RIDRETH1, Year)
combo0910 <- combo0910 %>% mutate(Year = factor(1)) %>% select(MeanDia, MeanSys, RIAGENDR, RIDAGEYR, RIDRETH1, Year)
combo1718 <- combo1718 %>% mutate(Year = factor(2)) %>% select(MeanDia, MeanSys, RIAGENDR, RIDAGEYR, RIDRETH1, Year)

##stacking the datasets
modelData1 <- bind_rows(combo0102, combo0910, combo1718)
write_csv(modelData1, file = here::here("dataset","modelData1.csv"))



