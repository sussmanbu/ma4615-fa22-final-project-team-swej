library(tidyverse)

#haven package needed to read in .XPT data
library(haven)
bpdata <- read_xpt(here::here("dataset", "P_BPXO.XPT"))

## CLEAN the data

write_csv(bpdata, file = here::here("dataset", "bpdata.csv"))

save(bpdata, file = here::here("dataset/bpdata.RData"))

