clear 
set more off 
capture log close

*Create Replication_Project_Part2.log
log using "statawork/Replication_Project_Part2.log", replace

*Open paces_vouchers dataset
use "statawork/paces_vouchers.dta", clear

*Look at data
codebook, compact

*Put list of variables to get descriptives for in local macro to use later
local descrip_vars "checkid match_i match_ic"

*Means and SD for All Applicants
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25, statistics(mean sd n) columns(statistics) save

*Mean and sd for Female applicants
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & sex_name == 0, statistics(mean sd n) columns(statistics) save

*Mean and sd for Male applicants
tabstat `descrip_vars' if checkid ==1 & age>=9 & age<=25 & sex_name ==1, statistics(mean sd n) columns(statistics) save

*Regression estimate of Exact ID match for All Applicants (column 1)
regress match_i vouch0 if checkid ==1 & age>=9 & age<=25, robust

*Regression estimate of Exact ID match for Female Applicants (column 1)
regress match_i vouch0 if checkid ==1 & age>=9 & age<=25 & sex_name==0, robust

*Regression estimate of Exact ID match for Male Applicants (column 1)
regress match_i vouch0 if checkid ==1 & age>=9 & age<=25 & sex_name==1, robust

*Regression estimate of ID and City match for All Applicants (column 3)
regress match_ic vouch0 if checkid ==1 & age>=9 & age<=25, robust

*Regression estimate of ID and City match for Female Applicants (column 3)
regress match_ic vouch0 if checkid ==1 & age>=9 & age<=25 & sex_name==0, robust

*Regression estimate of ID and City match for Male Applicants (column 3)
regress match_ic vouch0 if checkid ==1 & age>=9 & age<=25 & sex_name==1, robust

*Robust Standard Errors
*Regression estimate of Exact ID match for All Applicants (column 2)
regress match_i vouch0 age sex_name if checkid ==1 & age>=9 & age<=25, robust

*Regression estimate of Exact ID match for Female Applicants (column 2)
regress match_i vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & sex_name==0, robust

*Regression estimate of Exact ID match for Male Applicants (column 2)
regress match_i vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & sex_name==1, robust

*Regression estimate of ID and City match for All Applicants (column 4)
regress match_ic vouch0 age sex_name if checkid ==1 & age>=9 & age<=25, robust

*Regression estimate of ID and City match for Female Applicants (column 4)
regress match_ic vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & sex_name==0, robust

*Regression estimate of ID and City match for Male Applicants (column 4)
regress match_ic vouch0 age sex_name if checkid ==1 & age>=9 & age<=25 & sex_name==1, robust

log close


