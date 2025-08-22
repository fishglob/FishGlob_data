library(here)
library(data.table)

load(here("outputs/Cleaned_data","SCS_clean.Rdata"))

problems <- data[xor(wgt_cpue == 0, num_cpue == 0)]

nrow(problems) / nrow(data)
quantile(problems$year)
Fn <- ecdf(problems$year)
Fn(1995)
# issue affects 9.4% of the data
# 99% of problems are in 1995 or before 

# fix 1: from 1970-1995, if count > 0 but weight = 0, replace weight with 0.5 kg
# note that we'd have to do this on the raw data, not the calculated cpue, but since I'm waiting for Juliano to push patches to the cleaning functions, I can't re-run get_scs.R 

problems[year <= 1995 & num_cpue > 0 & wgt_cpue == 0, 
     wgt_cpue := 0.5]
problems2 <- problems[xor(wgt_cpue == 0, num_cpue == 0)]
(nrow(problems) - nrow(problems2)) / nrow(problems) # dealt with 99% of the issues! 

# how many of these are zero weight vs zero count? 
problems2[, .(
  n_wgt0 = sum(wgt_cpue == 0, na.rm = TRUE), # 61
  n_num0 = sum(num_cpue == 0, na.rm = TRUE) # 83 
)]

# fix 2: where wgt > 0 but num = 0, replace num with NA
problems2[wgt_cpue > 0 & num_cpue == 0, num_cpue := NA_integer_] 

problems3 <- problems2[xor(wgt_cpue == 0, num_cpue == 0)] # down to 61 rows 
# all but 7 of these are in 1996 or 1997 

