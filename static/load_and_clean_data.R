library(tidyverse)

#haven package needed to read in .XPT data
library(haven)

#the two numbers refer to the years of the cycle, so 1718 means 2017-2018

#loading data
#2017-2020
bpdata1720 <- read_xpt(here::here("dataset", "P_BPXO1720.XPT"))

#2017-2018
bpdata1718 <- read_xpt(here::here("dataset","BPXO_J1718.XPT"))
demodata1718 <- read_xpt(here::here("dataset", "DEMO_J1718.XPT"))

#2009-2010 -> need to ask about this
bpdata0910 <- read_xpt(here::here("dataset","BPX_F0910.XPT"))
demodata0910 <- read_xpt(here::here("dataset","DEMO_F0910.XPT"))

#2001-2002
bpdata0102 <- read_xpt(here::here("dataset","BPX_B0102.XPT"))
demodata0102 <- read_xpt(here::here("dataset","DEMO_B0102.XPT"))


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
save(bpdata0102, file = here::here("dataset","bpdata0102.csv"))

write_csv(demodata0102, file = here::here("dataset","demodata0102.csv"))
save(demodata0102, file = here::here("dataset","demodata0102.csv"))

