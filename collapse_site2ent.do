/*
collapse_site2ent.do


*/

cap cd "/export/home/dor/lmostrom/Documents/IT_Spending"

use "master_merged.dta", clear

gen n_computers = desktops + laptops
gen acct_sw = (accounting_sw_pres == "Yes")
gen am_sw = (asset_mgmt_sw_pres == "Yes")
gen supplych_sw = (supply_chain_sw_pres == "Yes")

#delimit ;
collapse (count) n_sites = siteid
		 (sum) *budget n_computers desktops laptops
		 (sum) acct_sw am_sw supplych_sw
		 (mean) antivirus_sw_pls,
	by(ent_id ent_company accounting_sw_manuf year country ent_country) fast;
#delimit cr

drop if ent_id == ""

foreach var of varlist *budget {
	gen sh_`var' = `var'/it_budget
}

egen tot_budget = rowtotal(*budget)
	replace tot_budget = tot_budget - it_budget

save "master_entlevel.dta", replace

set seed 12345
gen r_unif = runiform()

keep if r_unif <= 0.1
save "master_entlevel_10pct.dta", replace
