library(tidyverse)

#haven package needed to read in .XPT data
library(haven)

#the two numbers refer to the years of the cycle, so 1718 means 2017-2018

#loading data

#taking a look at insurance data


#2017-2018
bpdata1718 <- read_xpt(here::here("dataset","BPX_J.XPT"))
demodata1718 <- read_xpt(here::here("dataset", "DEMO_J.XPT"))

#2015-2016
bpdata1516 <- read_xpt(here::here("dataset","BPX_I.XPT"))
demodata1516 <- read_xpt(here::here("dataset","DEMO_I.XPT"))

#2013-2014
bpdata1314 <- read_xpt(here::here("dataset","BPX_H.XPT"))
demodata1314 <- read_xpt(here::here("dataset","DEMO_H.XPT"))

#2011-2012
bpdata1112 <- read_xpt(here::here("dataset","BPX_G.XPT"))
demodata1112 <- read_xpt(here::here("dataset","DEMO_G.XPT"))

#2009-2010 -> need to ask about this
bpdata0910 <- read_xpt(here::here("dataset","BPX_F.XPT"))
demodata0910 <- read_xpt(here::here("dataset","DEMO_F.XPT"))

#2007-2008
bpdata0708 <- read_xpt(here::here("dataset","BPX_E.XPT"))
demodata0708 <- read_xpt(here::here("dataset","DEMO_E.XPT"))

#2005-2006
bpdata0506 <- read_xpt(here::here("dataset","BPX_D.XPT"))
demodata0506 <- read_xpt(here::here("dataset","DEMO_D.XPT"))

#2003-2004
bpdata0304 <- read_xpt(here::here("dataset","BPX_C.XPT"))
demodata0304 <- read_xpt(here::here("dataset","DEMO_C.XPT"))

#2001-2002
bpdata0102 <- read_xpt(here::here("dataset","BPX_B.XPT"))
demodata0102 <- read_xpt(here::here("dataset","DEMO_B.XPT"))

#1999-2000
bpdata9900 <- read_xpt(here::here("dataset","BPX.XPT"))
demodata9900 <- read_xpt(here::here("dataset","DEMO.XPT"))
################################################################################

#writing to .csv

#2017-2018
write_csv(bpdata1718, file = here::here("dataset", "bpdata1718.csv"))
write_csv(demodata1718, file = here::here("dataset", "demodata1718.csv"))

#2015-2016
write_csv(bpdata1516, file = here::here("dataset", "bpdata1516.csv"))
write_csv(demodata1516, file = here::here("dataset", "demodata1516.csv"))


#2013-2014
write_csv(bpdata1314, file = here::here("dataset", "bpdata1314.csv"))
write_csv(demodata1314, file = here::here("dataset", "demodata1314.csv"))

#2011-2012
write_csv(bpdata1112, file = here::here("dataset", "bpdata1112.csv"))
write_csv(demodata1112, file = here::here("dataset", "demodata1112.csv"))

#2009-2010
write_csv(bpdata0910, file = here::here("dataset","bpdata0910.csv"))
write_csv(demodata0910, file = here::here("dataset","demodata0910.csv"))

#2007-2008
write_csv(bpdata0708, file = here::here("dataset","bpdata0708.csv"))
write_csv(demodata0708, file = here::here("dataset","demodata0708.csv"))

#2005-2006
write_csv(bpdata0506, file = here::here("dataset","bpdata0506.csv"))
write_csv(demodata0506, file = here::here("dataset","demodata0506.csv"))

#2003-2004
write_csv(bpdata0304, file = here::here("dataset","bpdata0304.csv"))
write_csv(demodata0304, file = here::here("dataset","demodata0304.csv"))

#2001-2002
write_csv(bpdata0102, file = here::here("dataset","bpdata0102.csv"))
write_csv(demodata0102, file = here::here("dataset","demodata0102.csv"))

#1999-2000
write_csv(bpdata9900, file = here::here("dataset","bpdata9900.csv"))
write_csv(demodata9900, file = here::here("dataset","demodata9900.csv"))

###############################################################################

#library call and loading in necessary data sets
#before i start, the general algorithm will be to load in the demographics and BP data for the 3 datasets (so 6 sets). Remove NAs. For each dataset, demographics and BP will be joined by ID number, so only observations with ID numbers in both datasets can be considered. Following the joins, the datasets will include a variable for year of collection (to be coded for each set). After all of this, the datasets will be stacked for analysis. also important to note, the names of certain variables change between datasets, so were gonna have to do some renaming to keep things consistent.

#loading in data and libraries
bpdata1718 <- read_csv(here::here("dataset/bpdata1718.csv"))
demodata1718 <- read_csv(here::here("dataset/demodata1718.csv"))

bpdata1516 <- read_csv(here::here("dataset/bpdata1516.csv"))
demodata1516 <- read_csv(here::here("dataset/demodata1516.csv"))

bpdata1314 <- read_csv(here::here("dataset/bpdata1314.csv"))
demodata1314 <- read_csv(here::here("dataset/demodata1314.csv"))

bpdata1112 <- read_csv(here::here("dataset/bpdata1112.csv"))
demodata1112 <- read_csv(here::here("dataset/demodata1112.csv"))

bpdata0910 <- read_csv(here::here("dataset/bpdata0910.csv"))
demodata0910 <- read_csv(here::here("dataset/demodata0910.csv"))

bpdata0708 <- read_csv(here::here("dataset/bpdata0708.csv"))
demodata0708 <- read_csv(here::here("dataset/demodata0708.csv"))

bpdata0506 <- read_csv(here::here("dataset/bpdata0506.csv"))
demodata0506 <- read_csv(here::here("dataset/demodata0506.csv"))

bpdata0304 <- read_csv(here::here("dataset/bpdata0304.csv"))
demodata0304 <- read_csv(here::here("dataset/demodata0304.csv"))

bpdata0102 <- read_csv(here::here("dataset/bpdata0102.csv"))
demodata0102 <- read_csv(here::here("dataset/demodata0102.csv"))

bpdata9900 <- read_csv(here::here("dataset/bpdata9900.csv"))
demodata9900 <- read_csv(here::here("dataset/demodata9900.csv"))

######################################################################

#cleaning, combining, and getting data into working order for all years

##creating variables for mean arterial pressure (MAP)
###making a function bc this is the same thing. function makes MAP, joins the
###demographics data, and gets things in working condition

combo <- function(df, demo, year){
  df <- df %>% mutate(MeanDia = rowMeans(select(.,BPXDI1,BPXDI2,BPXDI3), na.rm = TRUE)) %>% 
    mutate(MeanSys = rowMeans(select(.,BPXSY1,BPXSY2,BPXSY3), na.rm = TRUE)) %>%
    mutate(MAP = MeanDia + ((MeanSys - MeanDia)/3)) %>%
    select(SEQN, MAP) %>% 
    inner_join(demo, by = "SEQN") %>% 
    mutate(Year = factor(year)) %>% 
    select(SEQN, MAP, RIAGENDR, RIDAGEYR, RIDRETH1, Year) %>%
    filter(!is.nan(MAP))
  return(df)
}

combo1718 <- combo(bpdata1718, demodata1718, 2018)
combo1516 <- combo(bpdata1516, demodata1516, 2016)
combo1314 <- combo(bpdata1314, demodata1314, 2014) 
combo1112 <- combo(bpdata1112, demodata1112, 2012) 
combo0910 <- combo(bpdata0910, demodata0910, 2010) 
combo0708 <- combo(bpdata0708, demodata0708, 2008) 
combo0506 <- combo(bpdata0506, demodata0506, 2006) 
combo0304 <- combo(bpdata0304, demodata0304, 2004) 
combo0102 <- combo(bpdata0102, demodata0102, 2002) 
combo9900 <- combo(bpdata9900, demodata9900, 2000) 

##stacking the datasets
modelData <- bind_rows(combo9900, combo0102, combo0304, combo0506, combo0708, combo0910, combo1112, combo1314, combo1516, combo1718) %>%
  mutate(RIDRETH1 = factor(RIDRETH1), RIAGENDR = factor(RIAGENDR))
write_csv(modelData, file = here::here("dataset","modelData.csv"))

############################################

#loading in the secondary dataset
##the main variable is the % of US government budget spent towards general health
health_ex <- read_csv(here::here("dataset/API_USA_DS2_en_csv_v2_4696777.csv"), skip = 4)
health_ex <- health_ex %>% filter(`Indicator Code`== "SH.XPD.GHED.GE.ZS") %>%
  select(-`Country Name`,-`Country Code`, -`Indicator Name`, -`Indicator Code`) %>%
  pivot_longer(cols = everything(), names_to = "Year", values_to = "GovernmentHealthExpenditure") %>%
  drop_na() %>% filter(Year %in% c("2000","2002","2004","2006","2008","2010","2012","2014","2016","2018")) %>%
  mutate(Year = factor(Year))

#simplifying model data to median per cycle and joining secondary dataset by year 
##gonna try hypertension defined as MAP > 100 
##(https://www.healthline.com/health/mean-arterial-pressure#high-map)

#this is median MAP vs expenditure by year
MAPvsEx <- modelData %>% group_by(Year) %>% 
  summarize(MedianMAP = median(MAP, na.rm = TRUE)) %>%
  left_join(health_ex, by = "Year")

#this is rate of hypertension vs expenditure by year
rateHTNvsEX <- modelData %>% 
  mutate(HTN = ifelse(MAP >= 100, 1, 0)) %>%
  group_by(Year) %>%
  summarize(rateHTN = sum(HTN)/n()) %>%
  left_join(health_ex, by = "Year")
