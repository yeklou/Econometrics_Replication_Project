
clear all
capture log close
set more off

*Put data directory in local macro to call on later
local data_dir "/Users/eklou/OneDrive/Documents/"

*Put working directory in local macro to call on later - this is where I will save output
local save_dir "/Users/eklou/OneDrive/Documents/statawork/"

*Can now set working directory with this local macro
cd `save_dir'


*Start log file
log using `save_dir'Replication_Project_Part1.log, replace


*Open paces_vouchers dataset
use `data_dir'paces_vouchers.dta, clear

*Look at data
codebook, compact



*Put list of variables to get descriptives for in local macro to use later
local descrip_vars "vouch0 checkid age sex_name phone"


*** Replicate Table I

*Means and SD for full sample
tabstat `descrip_vars', stat(mean sd n) col(stat) save

*Means and SD for valid age sample
tabstat `descrip_vars' if age>9 & age<25, statistics(mean sd n) columns(statistics) save

*Regression estimate of Differences by vouchers status (winners vs losers) for full sample (column 3)
regress checkid vouch0
regress age vouch0
regress sex_name vouch0
regress phone vouch0 

*Regression estimate of Differences by vouchers status (winners vs losers) for valid age sample (column 4)
regress checkid vouch0 if age>9 & age<25
regress age vouch0 if age>9 & age<25
regress sex_name vouch0 if age>9 & age<25
regress phone vouch0 if age>9 & age<25

*Regression estimate of Differences by vouchers status (winners vs losers) for valid ID and age sample (column 5)
regress checkid vouch0 if checkid==1 & age>9 & age<25
regress age vouch0 if checkid==1 & age>9 & age<25
regress sex_name vouch0 if checkid==1 & age>9 & age<25
regress phone vouch0 if checkid==1 & age>9 & age<25


*Regression estimate of Differences by vouchers status (winners vs losers) for valid ID and age and has phone sample (column 6)
regress checkid vouch0 if checkid==1 & age>9 & age<25 & phone==1
regress age vouch0 if checkid==1 & age>9 & age<25 & phone==1
regress sex_name vouch0 if checkid==1 & age>9 & age<25 & phone==1
regress phone vouch0 if checkid==1 & age>9 & age<25 & phone==1

*robust (column 3)
*Regression estimate of Differences by vouchers status (winners vs losers) for full sample
regress checkid vouch0, robust
regress age vouch0, robust
regress sex_name vouch0, robust
regress phone vouch0, robust 

*robust (column 4)
*Regression estimate of Differences by vouchers status (winners vs losers) for valid age sample 
regress checkid vouch0 if age>9 & age<25, robust
regress age vouch0 if age>9 & age<25, robust
regress sex_name vouch0 if age>9 & age<25, robust
regress phone vouch0 if age>9 & age<25, robust

*robust (column 5)
*Regression estimate of Differences by vouchers status (winners vs losers) for valid ID and age 
regress checkid vouch0 if checkid==1 & age>9 & age<25, robust
regress age vouch0 if checkid==1 & age>9 & age<25, robust
regress sex_name vouch0 if checkid==1 & age>9 & age<25, robust
regress phone vouch0 if checkid==1 & age>9 & age<25, robust

*robust (column 6)
*Regression estimate of Differences by vouchers status (winners vs losers) for valid ID and age and has phone sample
regress checkid vouch0 if checkid==1 & age>9 & age<25 & phone==1, robust
regress age vouch0 if checkid==1 & age>9 & age<25 & phone==1, robust
regress sex_name vouch0 if checkid==1 & age>9 & age<25 & phone==1, robust
regress phone vouch0 if checkid==1 & age>9 & age<25 & phone==1, robust

clear
log close