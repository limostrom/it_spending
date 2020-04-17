/*
attempt_fuzzy_merge.do


Has never worked - datasets too large
*/

use "master_entlevel_10pct.dta", clear

* Can't use merge because mode_entconm from Master is strL (too long)
replace mode_entconm = upper(mode_entconm)
replace mode_entconm = subinstr(mode_entconm, ".", "", .)
ren mode_entconm conm
compress *, nocoalesce

preserve
use "../Compustat.dta", clear
replace conm = upper(conm)
replace conm = subinstr(conm, ".", "", .)
gen year = fyear-1
tempfile compu
save `compu', replace
restore

merge 1:1 conm year using `compu', keep(1 3)

assert inlist(substr(ent_id, 1, 1),"E","1")
	replace ent_id = "9" + substr(ent_id,2,.) if substr(ent_id,1,1) == "E"
	** needs to be numeric to be used in matchit
	destring ent_id, replace

* Takes over 24 hours even just with the 10% sample 

matchit ent_id mode_entconm ///
	using "../Compustat.dta", idu(gvkey) txtu(conm) time override



tostring ent_id, replace
replace ent_id = "E" + substr(ent_id,2,.) if substr(ent_id,1,1) == "9"

save "master_entlevel_10pct_wCompustat.dta", replace