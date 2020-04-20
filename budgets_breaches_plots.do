/*
budgets_and_breaches.do

Combining a subset of the Aberdeen IT budget dataset and the cyber
	breach dataset

*/
clear all
set more off
pause on

cap cd "C:/Users/lmostrom/Dropbox/Cyber IT Project/"
global repo "C:\Users\lmostrom\Documents\GitHub\it_spending"

local exports 0
local plots 0
local subsets 0
local pre_post 1


local gov_actions "xline(2011.833 2013.167 2015.667 2015.833 2018.833, lc(gs12))"

import excel "cyber_pilot_v2.xlsx", clear ///
	first sheet("breaches_only") case(lower)

fre report_year using "report_years_tab.txt", tab order replace

tempfile breaches
save `breaches', replace

drop if groupid == .
keep report_year groupid gvkey cik conm
duplicates drop

tempfile breaches_nodups
save `breaches_nodups', replace

*========================================================================
* YEAR-TO-YEAR CHANGES IN TOTAL BUDGETS
if `exports' == 1 {
*========================================================================
use master_sitelevel_subset, clear
	egen tot_budget = rowtotal(*_budget)
		replace tot_budget = tot_budget-it_budget
	xtset siteid year
		gen g = (tot_budget-l.tot_budget)/l.tot_budget*100
		lab var g "Total Budget growth rate (%)"
		format g %9.3g

	summ g, d

use master_clean_subset, clear

	collapse (sum) it_budget (first) stn_conm, by(ent_id groupid year)
	isid ent_id year
	egen new_entid = group(ent_id)
	xtset new_entid year
		gen g = (it_budget-l.it_budget)/l.it_budget*100
		lab var g "IT Budget growth rate (%)"
		format g %9.3g

	sort groupid ent_id year
	export excel year ent_id groupid it_budget g ///
		using "Archive/budget_growth.xlsx", ///
	  sheet("Enterprises-All", replace)	first(var)

	preserve
		collapse (sum) it_budget, by(groupid year)
		xtset groupid year
			gen g = (it_budget-l.it_budget)/l.it_budget*100
			lab var g "IT Budget growth rate (%)"
			format g %9.3g
		sort groupid year
		export excel year groupid it_budget g ///
			using "Archive/budget_growth.xlsx", ///
		  sheet("Groups-All", replace)	first(var)
	restore

	bys ent_id: egen n_years = count(ent_id)
		bys groupid: egen max_cov = max(n_years)
		keep if n_years == max_cov

	sort groupid ent_id year
	export excel year ent_id groupid it_budget g ///
		using "Archive/budget_growth.xlsx", ///
	  sheet("Enterprises-MaxCov", replace)	first(var)

	preserve
		collapse (sum) it_budget (first) stn_conm, by(groupid year)
		xtset groupid year
			gen g = (it_budget-l.it_budget)/l.it_budget*100
			lab var g "IT Budget growth rate (%)"
			format g %9.3g
		sort groupid year
		export excel year groupid it_budget g ///
			using "Archive/budget_growth.xlsx", ///
		  sheet("Groups-MaxCov", replace) first(var)

		joinby groupid using `breaches', unmatched(master)
		keep groupid year report_year report_month ///
					it_budget g stn_conm

		sort groupid year report_year report_month
			bys groupid year: gen breach = _n
				drop report_month
			reshape wide report_year, i(groupid year) j(breach)
		br stn_conm groupid year report*
		pause
	restore

*--- Report Years ---*
	import delimited "report_years_tab.txt", clear varn(3)
		drop v1
		ren v2 report_year
	export excel using "Archive/budget_growth.xlsx", ///
		  sheet("ReportYears", replace) first(var)
	drop if report_year == "Total"
	destring report_year, replace
	tw (line freq report_year, lc(black)), legend(off) ///
		ti("Number of Cyber Breaches") yti("") `gov_actions'
	graph export "ts_n_breaches.png", replace as(png) wid(1200) hei(700)

*--- Accounting SW Manufacturer Stats ---*
use master_clean_subset, clear
	replace accounting_sw_manuf = upper(accounting_sw_manuf)
		replace accounting_sw_manuf = "UNSPECIFIED" ///
			if inlist(accounting_sw_manuf, "UNSPECIFIED", "OTHER", "", " ")
	collapse (sum) n_sites it_budget, by(groupid accounting_sw_manuf year)
	collapse (count) n_firms = groupid ///
			 (sum) n_sites it_budget ///
			 (median) med_it_budget = it_budget, by(accounting_sw_manuf year)
	reshape wide n_firms n_sites it_budget med_it_budget, i(accounting) j(year)
	
	order accounting n_firms* n_sites* it_budget* med_it_budget*
	gsort -n_firms2019
	export excel accounting n_firms* ///
		using "summ_stats.xlsx", first(var) sheet("Manuf_Stats_F_raw", replace)
	gsort -n_sites2019
	export excel accounting n_sites* ///
		using "summ_stats.xlsx", first(var) sheet("Manuf_Stats_S_raw", replace)
	gsort -it_budget2019
	export excel accounting it_budget* ///
		using "summ_stats.xlsx", first(var) sheet("Manuf_Stats_B_raw", replace)
	gsort -med_it_budget2019
	export excel accounting med_it_budget* ///
		using "summ_stats.xlsx", first(var) sheet("Manuf_Stats_MedB_raw", replace)


forval y = 2010/2019 {
	gen avg_budget`y' = it_budget`y'/n_firms`y'
}

} // end of `exports'
*========================================================================
import delimited "report_years_tab.txt", clear varn(3)
		drop v1
		ren v2 year
		drop if year == "Total"
		destring year, replace
	tempfile breach_counts
	save `breach_counts', replace
*========================================================================
* TIME SERIES PLOTS OF BUDGET DISTRIBUTION
if `plots' == 1 {
*========================================================================
*=============================================
foreach var in "it_budget" "n_computer" {
*=============================================
if "`var'" == "it_budget" {
	local title "IT Budgets"
	local yt "$ Millions"
}
if "`var'" == "n_computer" {
	local title "Number of Computers"
	local yt ""
}
*-----------------------------------
foreach lev in /*"site"*/ "group" {
*-----------------------------------
	local Lev = strproper("`lev'")
if "`lev'" == "site" use master_sitelevel_subset, clear
if "`lev'" == "group" {
	use master_sitelevel_subset, clear
	bys siteid: egen n_yrs = count(year)
	bys groupid: egen max_cov = max(n_yrs)
	keep if n_yrs == max_cov
		collapse (count) n_sites = siteid (sum) it_budget n_computer acct_sw, ///
			by(groupid year)

}

cap mkdir "MaxCovSites"
	cd "MaxCovSites"

//-- IT BUDGETS ------------------------------------------------
foreach lowp in 1 10 {
	local highp = 100-`lowp'
forval to2015 = 0/0 {
	if `to2015' local ext "_to2015"
	else local ext ""
		preserve
			*if "`lev'" == "group" collapse (sum) it_budget, by(groupid year)
			replace it_budget = it_budget / 1000000
				lab var it_budget "IT Budget ($ Millions)"

			#delimit ;
			collapse (mean) mean_`var' = `var'
					 (median) med_`var' = `var'
					 (p`lowp') p`lowp'_`var' = `var'
					 (p`highp') p`highp'_`var' = `var'
					 (p25) p25_`var' = `var'
					 (p75) p75_`var' = `var'
					 (sd) sd_`var' = `var',
				by(year) fast;
			
			if `to2015' keep if year <= 2015;
			tw (line p`lowp' year, lc(gs8) lp(-)) (line p`highp' year, lc(gs8) lp(-))
			   (line p25 year, lc(eltblue) lp(_)) (line p75 year, lc(eltblue) lp(_))
			   (line mean year, lc(black) lp(l)) (line med year, lc(midblue) lp(l)),
			 legend(order(1 "Percentiles `lowp' & `highp'" 3 "Quartiles"
			 			  5 "Mean" 6 "Median") r(2) colfirst)
			 ti("`title' Distribution by `Lev'")
			 yti("`yt'")
			 `gov_actions';
			graph export "ts_`var's_`lev'id`ext'_`lowp'_`highp'.png",
									replace as(png) wid(1200) hei(700);


			merge 1:1 year using `breach_counts', keepus(freq) keep(1 3) nogen;
			sort year;
			tw (line freq year, lc(gs12) lw(thick) lp(l) yaxis(1))
			   (line p`lowp' year, lc(gs8) lp(-) yaxis(2))
			   (line p`highp' year, lc(gs8) lp(-) yaxis(2))
			   (line p25 year, lc(eltblue) lp(_) yaxis(2))
			   (line p75 year, lc(eltblue) lp(_) yaxis(2))
			   (line mean year, lc(black) lp(l) yaxis(2))
			   (line med year, lc(midblue) lp(l) yaxis(2)),
			 legend(order(2 "Percentiles `lowp' & `highp'" 4 "Quartiles"
			 			  1 "Cyber Breaches"
			 			  6 "Mean" 7 "Median") r(3) colfirst)
			 ti("`title' Distribution by `Lev'")
			 yti("`yt'", axis(2)) yti("Number of Breaches", axis(1))
			 `gov_actions';
			graph export "ts_`var's_`lev'id`ext'_`lowp'_`highp'_wBreaches.png",
									replace as(png) wid(1200) hei(700);
			#delimit cr

		if `to2015' != 1 {
			if `lowp' == 1 {
				tempfile p1_p99
				save `p1_p99', replace
			}
			else {
				merge 1:1 year using `p1_p99', ///
					keepus(p1_`var' p99_`var') nogen assert(3)
				order year mean sd p1_ p10_ p25 med p75 p90 p99
				export excel using "summ_stats_`lev'level.xlsx", first(var) ///
					sheet("`title'_raw", replace)
	}
}

restore 
} // end to2015 loop
} // end 1% / 10% loop
//---------------------------------------------------------------

//-- GROWTH RATE OF IT BUDGET ----------------------------------
foreach lowp in 1 10 {
	local highp = 100-`lowp'
forval to2015 = 0/0 {
	if `to2015' local ext "_to2015"
	else local ext ""
		preserve
			*if "`lev'" == "group" collapse (sum) it_budget, by(groupid year)
			xtset `lev'id year
			gen g_`var' = (`var'-l.`var')/l.`var'*100

			#delimit ;
			collapse (mean) mean_g = g_`var'
					 (median) med_g = g_`var'
					 (p`lowp') p`lowp'_g = g_`var'
					 (p`highp') p`highp'_g = g_`var'
					 (p25) p25_g = g_`var'
					 (p75) p75_g = g_`var'
					 (sd) sd_g = g_`var',
				by(year) fast;
			
			if `to2015' keep if year <= 2015;
			tw (line p`lowp' year, lc(gs8) lp(-)) (line p`highp' year, lc(gs8) lp(-))
			   (line p25 year, lc(eltblue) lp(_)) (line p75 year, lc(eltblue) lp(_))
			   (line mean year, lc(black) lp(l)) (line med year, lc(midblue) lp(l)),
			 legend(order(1 "Percentiles `lowp' & `highp'" 3 "Quartiles"
			 			  5 "Mean" 6 "Median") r(2) colfirst)
			 ti("Distribution of `title' Growth by `Lev'")
			 yti("Growth Rate of `title'" "Over Previous Year (%)")
			 `gov_actions';
			graph export "ts_gr_`var's_`lev'id`ext'_`lowp'_`highp'.png",
									replace as(png) wid(1200) hei(700);


			merge 1:1 year using `breach_counts', keepus(freq) keep(1 3) nogen;
			sort year;
			tw (line freq year, lc(gs12) lw(thick) lp(l) yaxis(1))
			   (line p`lowp' year, lc(gs8) lp(-) yaxis(2))
			   (line p`highp' year, lc(gs8) lp(-) yaxis(2))
			   (line p25 year, lc(eltblue) lp(_) yaxis(2))
			   (line p75 year, lc(eltblue) lp(_) yaxis(2))
			   (line mean year, lc(black) lp(l) yaxis(2))
			   (line med year, lc(midblue) lp(l) yaxis(2)),
			 legend(order(2 "Percentiles `lowp' & `highp'" 4 "Quartiles"
			 			  1 "Cyber Breaches"
			 			  6 "Mean" 7 "Median") r(3) colfirst)
			 ti("Distribution of `title' Growth by `Lev'")
			 yti("Growth Rate of `title'" "Over Previous Year (%)", axis(2))
			 yti("Number of Breaches", axis(1))
			 `gov_actions';
			graph export "ts_gr_`var's_`lev'id`ext'_`lowp'_`highp'_wBreaches.png",
									replace as(png) wid(1200) hei(700);


			#delimit cr

		if `to2015' != 1 {
			if `lowp' == 1 {
				tempfile p1_p99
				save `p1_p99', replace
			}
			else {
				merge 1:1 year using `p1_p99`ext'', nogen assert(3)
				order year mean sd p1_ p10_ p25 med p75 p90 p99
				export excel using "summ_stats_`lev'level.xlsx", first(var) ///
					sheet("gr_`title'_raw", replace)
	}
}
restore 
} // end to2015 loop
} // end 1% / 10% loop
//---------------------------------------------------------------
} // end site & group level loop
*=====================================
} // end it_budgets/n_computers loop
*=====================================

//-- SITES STATS -----------------------------------------------
foreach lowp in 1 10 {
	local highp = 100-`lowp'
forval to2015 = 0/0 {
	if `to2015' local ext "_to2015"
	else local ext ""
		preserve
			*collapse (sum) n_sites acct_sw, by(groupid year)
			xtset groupid year
			gen sh_w_acct = acct_sw/n_sites*100

			#delimit ;
			collapse (mean) mean_sh_act = sh_w_acct mean_sites = n_sites
					 (median) med_sh_act = sh_w_acct med_sites = n_sites
					 (p`lowp') p`lowp'_sh_act = sh_w_acct p`lowp'_sites = n_sites
					 (p`highp') p`highp'_sh_act = sh_w_acct p`highp'_sites = n_sites
					 (p25) p25_sh_act = sh_w_acct p25_sites = n_sites
					 (p75) p75_sh_act = sh_w_acct p75_sites = n_sites
					 (sd) sd_sh_act = sh_w_acct sd_sites = n_sites,
				by(year) fast;
			
			if `to2015' keep if year <= 2015;

			tw (line p`lowp'_sh year, lc(gs8) lp(-)) (line p`highp'_sh year, lc(gs8) lp(-))
			   (line p25_sh year, lc(eltblue) lp(_)) (line p75_sh year, lc(eltblue) lp(_))
			   (line mean_sh year, lc(black) lp(l)) (line med_sh year, lc(midblue) lp(l)),
			 legend(order(1 "Percentiles `lowp' & `highp'" 3 "Quartiles"
			 			  5 "Mean" 6 "Median") r(2) colfirst)
			 yti("Share of Sites w/ Accounting Software (%)")
			 `gov_actions';
			graph export "ts_sh_acct_sw_id`ext'_`lowp'_`highp'.png",
									replace as(png) wid(1200) hei(700);

			tw (line p`lowp'_site year, lc(gs8) lp(-)) (line p`highp'_site year, lc(gs8) lp(-))
			   (line p25_site year, lc(eltblue) lp(_)) (line p75_site year, lc(eltblue) lp(_))
			   (line mean_site year, lc(black) lp(l)) (line med_site year, lc(midblue) lp(l)),
			 legend(order(1 "Percentiles `lowp' & `highp'" 3 "Quartiles"
			 			  5 "Mean" 6 "Median") r(2) colfirst)
			 yti("Number of Sites")
			 `gov_actions';
			graph export "ts_sites_groupid`ext'_`lowp'_`highp'.png",
									replace as(png) wid(1200) hei(700);
			#delimit cr

		if `to2015' != 1 {
			if `lowp' == 1 {
				tempfile p1_p99
				save `p1_p99', replace
			}
			else {
				merge 1:1 year using `p1_p99`ext'', nogen assert(3)
				order year mean_sites sd_sites ///
					p1_sites p10_sites p25_sites med_sites p75_sites p90_sites p99_sites ///
					mean_sh sd_sh ///
					p1_sh p10_sh p25_sh med_sh p75_sh p90_sh p99_sh
				export excel using "summ_stats_grouplevel.xlsx", first(var) ///
					sheet("SiteLevel_raw", replace)
	}
}
restore 
} // end to2015 loop
} // end 1% / 10% loop
//---------------------------------------------------------------
/*
//-- ACCOUNTING SW MANUFACTURERS -------------------------------
foreach lowp in 1 10 {
	local highp = 100-`lowp'
forval to2015 = 0/0 {
	if `to2015' local ext "_to2015"
	else local ext ""
		preserve
			replace accounting_sw_manuf = upper(accounting_sw_manuf)
				replace accounting_sw_manuf = "UNSPECIFIED" ///
					if inlist("UNSPECIFIED", "OTHER", "", " ")

			collapse (sum) n_sites , by(groupid accounting_sw_manuf year)
				egen asw_manuf = group(accounting_sw_manuf)
			collapse (count) acct_sws = asw_manuf, by(groupid year)

			xtset groupid year

			#delimit ;
			collapse (mean) mean_acct_sws = acct_sws
					 (median) med_acct_sws = acct_sws
					 (p`lowp') p`lowp'_acct_sws = acct_sws
					 (p`highp') p`highp'_acct_sws = acct_sws
					 (p25) p25_acct_sws = acct_sws
					 (p75) p75_acct_sws = acct_sws
					 (sd) sd_acct_sws = acct_sws,
				by(year) fast;
			
			if `to2015' keep if year <= 2015;

			tw (line p`lowp' year, lc(gs8) lp(-)) (line p`highp' year, lc(gs8) lp(-))
			   (line p25 year, lc(eltblue) lp(_)) (line p75 year, lc(eltblue) lp(_))
			   (line mean year, lc(black) lp(l)) (line med year, lc(midblue) lp(l)),
			 legend(order(1 "Percentiles `lowp' & `highp'" 3 "Quartiles"
			 			  5 "Mean" 6 "Median") r(2) colfirst)
			 yti("Number of Different Types of Accounting Software" "Within the Firm")
			 `gov_actions';
			graph export "ts_Acct_SWs_groupid`ext'_`lowp'_`highp'.png",
									replace as(png) wid(1200) hei(700);
			#delimit cr

		if `to2015' != 1 {
			if `lowp' == 1 {
				tempfile p1_p99
				save `p1_p99', replace
			}
			else {
				merge 1:1 year using `p1_p99', nogen assert(3)
				order year mean sd p1_ p10 p25 med p75 p90 p99
				export excel using "summ_stats.xlsx", first(var) ///
					sheet("SW_Manuf_raw", replace)
			}
		}
		restore
} // end to2015 loop
} // end 1% / 10% loop
//---------------------------------------------------------------
cd ../

*/
*========================================================================
} // end `plots'
*========================================================================
* SUBSETS OF THE IT BUDGET
if `subsets' == 1 {
*========================================================================
use master_clean_subset, clear

drop sh_*_budget

collapse (sum) *_budget n_sites n_computers ///
		 (first) stn_conm, by(groupid year) fast
		 
foreach var of varlist *_budget {
	gen sh_`var' = `var'/tot_budget*100
}

preserve

local medians "(median) "
local p25s "(p25) "
local p75s "(p75) "

foreach var in "hardware" "storage" "comm" "software" "services" "itstaff" {
	local medians "`medians' med_sh_`var' = sh_`var' "
	local p25s "`p25s' p25_sh_`var' = sh_`var' "
	local p75s "`p75s' p75_sh_`var' = sh_`var' "
}

collapse `medians' `p25s' `p75s', by(year)
gen ex = .

				  
#delimit ;
tw (line med_sh_hardware year, lc(dkorange) lp(l))
		(line p25_sh_hardware year, lc(dkorange) lp(-) lw(thin))
		(line p75_sh_hardware year, lc(dkorange) lp(-) lw(thin))
   (line med_sh_comm year, lc(midblue) lp(l))
		(line p25_sh_comm year, lc(midblue) lp(-) lw(thin))
		(line p75_sh_comm year, lc(midblue) lp(-) lw(thin))
   (line med_sh_software year, lc(midgreen) lp(l))
		(line p25_sh_software year, lc(midgreen) lp(-) lw(thin))
		(line p75_sh_software year, lc(midgreen) lp(-) lw(thin))
   (line med_sh_services year, lc(purple) lp(l))
		(line p25_sh_services year, lc(purple) lp(-) lw(thin))
		(line p75_sh_services year, lc(purple) lp(-) lw(thin))
   (line ex year, lc(gs8) lp(-) lw(thin)) (line ex year, lc(gs8) lp(l))
   /*(line med_sh_storage year, lc(gs7) lp(l))
		(line p25_sh_storage year, lc(gs7) lp(-) lw(thin))
		(line p75_sh_storage year, lc(gs7) lp(-) lw(thin))
   (line med_sh_itstaff year, lc(gold) lp(l))
		(line p25_sh_itstaff year, lc(gold) lp(-) lw(thin))
		(line p75_sh_itstaff year, lc(gold) lp(-) lw(thin))*/,
 legend(order(13 "Quartiles" 14 "Median"
			   7 "Software" 4 "Communications" 10 "Services" 1 "Hardware"
				/*15 "Storage" 18 "IT Staff"*/) r(2) colfirst)
 yti("Share of Total Budgets")
 `gov_actions';
graph export "sh_budget_items.png", replace as(png) wid(1200) hei(700);


merge 1:1 year using `breach_counts', keepus(freq) keep(1 3) nogen;
sort year;
tw (line freq year, lc(gs12) lw(thick) lp(l) yaxis(1))
   (line med_sh_hardware year, lc(dkorange) lp(l) yaxis(2))
		(line p25_sh_hardware year, lc(dkorange) lp(-) lw(thin) yaxis(2))
		(line p75_sh_hardware year, lc(dkorange) lp(-) lw(thin) yaxis(2))
   (line med_sh_comm year, lc(midblue) lp(l) yaxis(2))
		(line p25_sh_comm year, lc(midblue) lp(-) lw(thin) yaxis(2))
		(line p75_sh_comm year, lc(midblue) lp(-) lw(thin) yaxis(2))
   (line med_sh_software year, lc(midgreen) lp(l) yaxis(2))
		(line p25_sh_software year, lc(midgreen) lp(-) lw(thin) yaxis(2))
		(line p75_sh_software year, lc(midgreen) lp(-) lw(thin) yaxis(2))
   (line med_sh_services year, lc(purple) lp(l) yaxis(2))
		(line p25_sh_services year, lc(purple) lp(-) lw(thin) yaxis(2))
		(line p75_sh_services year, lc(purple) lp(-) lw(thin) yaxis(2))
   (line ex year, lc(gs8) lp(-) lw(thin) yaxis(2)) (line ex year, lc(gs8) lp(l) yaxis(2)),
 legend(order(14 "Quartiles" 15 "Median"
			   8 "Software" 5 "Communications" 1 "Cyber Breaches"
			  11 "Services" 2 "Hardware"
				/*15 "Storage" 18 "IT Staff"*/)
		hole(3) r(3) colfirst)
 yti("Share of Total Budgets", axis(2)) yti("Number of Breaches", axis(1))
 `gov_actions';
graph export "sh_budget_items_wBreaches.png", replace as(png) wid(1200) hei(700);

#delimit cr

restore


} // end `acct'
*========================================================================
* PLOTS OF BUDGETS PRE- AND POST-BREACH
local maxcov 0
if `pre_post' == 1 {
*========================================================================
* --- Group ID Level ----------------------------
if `maxcov' == 0 {
	use master_clean_subset, clear

	collapse (sum) it_budget n_sites n_computers ///
		 (first) stn_conm, by(groupid year) fast
}
*-----------------------------------------------*
		
* --- Max Coverage Instead of Group ID Level ---*
if `maxcov' == 1 {
	use master_sitelevel_subset, clear
	cd MaxCovSites
	bys siteid: egen n_yrs = count(year)
	bys groupid: egen max_cov = max(n_yrs)
	keep if n_yrs == max_cov
		collapse (count) n_sites = siteid (sum) it_budget n_computer acct_sw, ///
			by(groupid year)
}
*-----------------------------------------------*

replace it_budget = it_budget / 1000000
	lab var it_budget "IT Budget ($ Millions)"
	
joinby groupid using `breaches_nodups', unmatched(master)
drop if report_year <= 2010	
gen t = year - report_year

foreach var of varlist it_budget n_computer {
if "`var'" == "it_budget" {
	local title "IT Budgets"
	local yt "$ Millions"
}
if "`var'" == "n_computers" {
	local title "Number of Computers"
	local yt "Computers"
}


	foreach lowp in 1 10 {
		local highp = 100-`lowp'
		preserve
			#delimit ;
			collapse (mean) mean_`var' = `var'
					 (median) med_`var' = `var'
					 (p`lowp') p`lowp'_`var' = `var'
					 (p`highp') p`highp'_`var' = `var'
					 (p25) p25_`var' = `var'
					 (p75) p75_`var' = `var'
					 (sd) sd_`var' = `var',
				by(t) fast;

			tw (line p25 t, lc(eltblue) lp(_)) (line p75 t, lc(eltblue) lp(_))
			   (line mean t, lc(black) lp(l)) (line med t, lc(midblue) lp(l))
			   (line p`lowp' t, lc(gs8) lp(-)) (line p`highp' t, lc(gs8) lp(-))
			, legend(order(5 "Percentiles `lowp' & `highp'" 1 "Quartiles"
						  3 "Mean" 4 "Median") r(2) colfirst)
				ti("`title' Distribution by Group and Breach")
				yti("`yt'") xti("Years Since Breach") xline(0, lc(gs12) lp(-));
			graph export "tbreach_`var'_groupid`ext'_`lowp'_`highp'.png",
								replace as(png) wid(1200) hei(700);
			#delimit cr
		restore
	}

preserve
	winsor `var', gen(`var'_w) p(0.05) highonly

	#delimit ;
	collapse (mean) mean_`var' = `var'_w
			 (median) med_`var' = `var'_w
			 (p25) p25_`var' = `var'_w
			 (p75) p75_`var' = `var'_w
			 (sd) sd_`var' = `var'_w,
		by(t) fast;

	tw (line p25 t, lc(eltblue) lp(_)) (line p75 t, lc(eltblue) lp(_))
	   (line mean t, lc(black) lp(l)) (line med t, lc(midblue) lp(l))
	, legend(order(1 "Quartiles" 3 "Mean" 4 "Median") r(1) colfirst)
		ti("`title' Distribution by Group and Breach")
		subti("Winsorized 5%, Upper Tail Only")
		yti("`yt'") xti("Years Since Breach") xline(0, lc(gs12) lp(-));
	graph export "tbreach_`var'_groupid`ext'_25_75.png",
						replace as(png) wid(1200) hei(700);
	#delimit cr
restore

}
*===============================================================================
* --- BUDGET SUBSETS ------------------
* --- Group ID Level ----------------------------
if `maxcov' == 0 {
	use master_clean_subset, clear
	drop sh_*_budget
	collapse (sum) *_budget n_sites n_computers ///
		 (first) stn_conm, by(groupid year) fast
}
*-----------------------------------------------*
		 
* --- Max Coverage Instead of Group ID Level ---*
if `maxcov' == 1 {
	use ../master_sitelevel_subset, clear
	bys siteid: egen n_yrs = count(year)
	bys groupid: egen max_cov = max(n_yrs)
	keep if n_yrs == max_cov
		collapse (count) n_sites = siteid (sum) *_budget n_computer acct_sw, ///
			by(groupid year)
		egen tot_budget = rowtotal(*_budget)
			replace tot_budget = tot_budget - it_budget
}
*-----------------------------------------------*
		 
foreach var of varlist *_budget {
	gen sh_`var' = `var'/tot_budget*100
}

joinby groupid using `breaches_nodups', unmatched(master)
drop if report_year <= 2010	
gen t = year - report_year

local medians "(median) "
local p25s "(p25) "
local p75s "(p75) "

foreach var in "hardware" "storage" "comm" "software" "services" "itstaff" {
	local medians "`medians' med_sh_`var' = sh_`var' "
	local p25s "`p25s' p25_sh_`var' = sh_`var' "
	local p75s "`p75s' p75_sh_`var' = sh_`var' "
}

collapse `medians' `p25s' `p75s', by(t)
gen ex = .

				  
#delimit ;
tw (line med_sh_hardware t, lc(dkorange) lp(l))
		(line p25_sh_hardware t, lc(dkorange) lp(-) lw(thin))
		(line p75_sh_hardware t, lc(dkorange) lp(-) lw(thin))
   (line med_sh_comm t, lc(midblue) lp(l))
		(line p25_sh_comm t, lc(midblue) lp(-) lw(thin))
		(line p75_sh_comm t, lc(midblue) lp(-) lw(thin))
   (line med_sh_software t, lc(midgreen) lp(l))
		(line p25_sh_software t, lc(midgreen) lp(-) lw(thin))
		(line p75_sh_software t, lc(midgreen) lp(-) lw(thin))
   (line med_sh_services t, lc(purple) lp(l))
		(line p25_sh_services t, lc(purple) lp(-) lw(thin))
		(line p75_sh_services t, lc(purple) lp(-) lw(thin))
   (line ex t, lc(gs8) lp(-) lw(thin)) (line ex t, lc(gs8) lp(l))
   /*(line med_sh_storage t, lc(gs7) lp(l))
		(line p25_sh_storage t, lc(gs7) lp(-) lw(thin))
		(line p75_sh_storage t, lc(gs7) lp(-) lw(thin))
   (line med_sh_itstaff t, lc(gold) lp(l))
		(line p25_sh_itstaff t, lc(gold) lp(-) lw(thin))
		(line p75_sh_itstaff t, lc(gold) lp(-) lw(thin))*/,
 legend(order(13 "Quartiles" 14 "Median"
			   7 "Software" 4 "Communications" 10 "Services" 1 "Hardware"
				/*15 "Storage" 18 "IT Staff"*/) r(2) colfirst)
 yti("Share of Total Budgets") xti("Years Since Breach") xline(0, lc(gs12) lp(-))
 `gov_actions';
graph export "tbreach_sh_budget_items.png", replace as(png) wid(1200) hei(700);
#delimit cr

*========================================================================
* PLOTS OF BUDGET GROWTH RATES PRE- AND POST-BREACH
*========================================================================
* --- Group ID Level ----------------------------
if `maxcov' == 0 {
	use master_clean_subset, clear

	collapse (sum) it_budget n_sites n_computers ///
		 (first) stn_conm, by(groupid year) fast
}
*-----------------------------------------------*
		 
* --- Max Coverage Instead of Group ID Level ---*
if `maxcov' == 1 {
	use ../master_sitelevel_subset, clear
	bys siteid: egen n_yrs = count(year)
	bys groupid: egen max_cov = max(n_yrs)
	keep if n_yrs == max_cov
		collapse (count) n_sites = siteid (sum) it_budget n_computer acct_sw, ///
			by(groupid year)
}
*-----------------------------------------------*
xtset groupid year
gen g_it = (it_budget - l.it_budget)/l.it_budget * 100
	lab var g_it "Growth rate of IT budget over previous year (%)"
gen g_cpu = (n_computers - l.n_computers)/l.n_computers * 100
	lab var g_cpu "Growth rate of number of computers over previous year (%)"
	
joinby groupid using `breaches_nodups', unmatched(master)
drop if report_year <= 2010	
gen t = year - report_year

foreach var of varlist g_it g_cpu {
if "`var'" == "g_it" {
	local title "Growth Rate of IT Budgets"
	local yt "Growth Rate over Previous Year (%)"
}
if "`var'" == "g_cpu" {
	local title "Growth Rate of Number of Computers"
	local yt "Growth Rate over Previous Year (%)"
}


	foreach lowp in 1 10 {
		local highp = 100-`lowp'
		preserve
			#delimit ;
			collapse (mean) mean_`var' = `var'
					 (median) med_`var' = `var'
					 (p`lowp') p`lowp'_`var' = `var'
					 (p`highp') p`highp'_`var' = `var'
					 (p25) p25_`var' = `var'
					 (p75) p75_`var' = `var'
					 (sd) sd_`var' = `var',
				by(t) fast;

			tw (line p25 t, lc(eltblue) lp(_)) (line p75 t, lc(eltblue) lp(_))
			   (line mean t, lc(black) lp(l)) (line med t, lc(midblue) lp(l))
			   (line p`lowp' t, lc(gs8) lp(-)) (line p`highp' t, lc(gs8) lp(-))
			, legend(order(5 "Percentiles `lowp' & `highp'" 1 "Quartiles"
						  3 "Mean" 4 "Median") r(2) colfirst)
				ti("`title'" "Distribution by Group and Breach")
				yti("`yt'") xti("Years Since Breach") xline(0, lc(gs12) lp(-));
			graph export "tbreach_`var'_groupid`ext'_`lowp'_`highp'.png",
								replace as(png) wid(1200) hei(700);
			#delimit cr
		restore
	}

preserve
	winsor `var', gen(`var'_w) p(0.05) highonly

	#delimit ;
	collapse (mean) mean_`var' = `var'_w
			 (median) med_`var' = `var'_w
			 (p25) p25_`var' = `var'_w
			 (p75) p75_`var' = `var'_w
			 (sd) sd_`var' = `var'_w,
		by(t) fast;

	tw (line p25 t, lc(eltblue) lp(_)) (line p75 t, lc(eltblue) lp(_))
	   (line mean t, lc(black) lp(l)) (line med t, lc(midblue) lp(l))
	, legend(order(1 "Quartiles" 3 "Mean" 4 "Median") r(1) colfirst)
		ti("`title'" "Distribution by Group and Breach")
		subti("Winsorized 5%, Upper Tail Only")
		yti("`yt'") xti("Years Since Breach") xline(0, lc(gs12) lp(-));
	graph export "tbreach_`var'_groupid`ext'_25_75.png",
						replace as(png) wid(1200) hei(700);
	#delimit cr
restore

}

} // end `pre_post'