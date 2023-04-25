clear 
set more off 
capture log close

*Create Replication_Project_Part3.log
log using "statawork/Replication_Project_Part3.log", replace

*Open paces_vouchers dataset
use "statawork/paces_vouchers.dta", clear

*Look at data
codebook, compact

*Put list of variables to get descriptives for in local macro to use later *(Column1)
local descrip_vars "checkid read math"

*Means and SD for All Applicants
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & math > 0 & read > 0, statistics(mean sd n) columns(statistics) save

*Means and SD for Female
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & math > 0 & read > 0 & sex_name ==0, statistics(mean sd n) columns(statistics) save

*Means and SD for Male
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & math > 0 & read > 0 & sex_name ==1, statistics(mean sd n) columns(statistics) save

*(Column2)
local descrip_vars "checkid readcens1 mathcens1"

*Means and SD for All Applicants
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25, statistics(mean sd n) columns(statistics) save

*Means and SD for Female
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & sex_name ==0, statistics(mean sd n) columns(statistics) save

*Means and SD for Male
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & sex_name ==1, statistics(mean sd n) columns(statistics) save

* Voucher effect on Language score(Column 1)

*for full sample 
regress read vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & read > 0, robust

*For Female
regress read vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & read > 0 & sex_name ==0, robust

*for Male
regress read vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & read > 0 & sex_name ==1, robust

* Voucher effect on Language score(Column 2)

*for full sample 
regress readcens1 vouch0 age sex_name if checkid ==1 & age>=9 & age<=25, robust

*For Female
regress readcens1 vouch0 age sex_name  if checkid ==1 & age>=9 & age<=25 & sex_name ==0, robust

*for Male
regress readcens1 vouch0 age sex_name  if checkid ==1 & age>=9 & age<=25 & sex_name ==1, robust


* Voucher effect on Math score(Column 1)

*for full sample 
regress math vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & math > 0, robust

*For Female
regress math vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & math > 0 & sex_name ==0, robust

*for Male
regress math vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & math > 0 & sex_name ==1, robust

* Voucher effect on Math score(Column 2)

*for full sample 
regress mathcens1 vouch0 age sex_name if checkid ==1 & age>=9 & age<=25, robust

*For Female
regress mathcens1 vouch0 age sex_name  if checkid ==1 & age>=9 & age<=25 & sex_name ==0, robust

*for Male
regress mathcens1 vouch0 age sex_name  if checkid ==1 & age>=9 & age<=25 & sex_name ==1, robust

log close





