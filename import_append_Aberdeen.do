/*

import_append_Aberdeen.do

**Must run on Grid with special request for extra RAM:
bsub -q long int -n 4 -Ip -W 12:00 -R "rusage[mem=50000]" -M 50000 -hl xstata-mp4
(50GB for 12 hours)
*/
pause on

cap cd "Z:/Documents/IT_Spending"
cap cd "/export/home/dor/lmostrom/Documents/IT_Spending"

local itspend 0
local sitedesc 0
local ent 0
local compinst 0
local presinst 0
local pls 0
local techtot 0
local businit 1
local append_1819 0
local merge 0



*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if `itspend' == 1 {
*-------------------
foreach country in /*"USA"*/ "Canada" "EuropeHistory" {
	
	if "`country'" == "USA" local start = 2007
	else local start = 2008

	forval y = `start'/2009 {
		import delimited "Hist`y'_DYNAMIC_`country'`y'.txt", clear varn(1)
		keep siteid est*budget
		ren est* *
		ren *budget *_budget
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}

	if "`country'" != "EuropeHistory" {
	local y = 2010
		import delimited "Hist`y'_ITSPEND_`country'`y'.txt", clear varn(1)
		keep siteid est*budget
		ren est* *
		ren *budget *_budget
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}

	forval y = 2011/2015 {
		import delimited "Hist`y'_ITSPEND_`country'`y'.txt", clear varn(1)
		keep siteid *_budget
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		import delimited "ITSpend_`country'`y'.TXT", clear varn(1)
		keep *siteid *_budget
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	/*
	forval y = 2018/2019 {
		import delimited "itspend_`country'`y'.txt", clear varn(1)
		keep *siteid *_budget
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*/
	*-------------------------------------------------------------------
	forval y = `start'/2018 {
		append using `Ab`y''
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "itspend_`country'_2007_2019.dta", replace
} // end country loop
*----------------------
} // `itspend' section
*----------------------

*--------------------
if `sitedesc' == 1 {
*--------------------
	foreach country in /*"USA" "Canada"*/ "EuropeHistory" {
	
	if "`country'" == "USA" local start = 2007
	else local start = 2008

	forval y = `start'/2015 {
		import delimited "Hist`y'_Sitedesc_`country'`y'.txt", clear varn(1)
		keep siteid company
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		import delimited "sitedescription_`country'`y'.TXT", clear varn(1)
		keep *siteid company
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*-------------------------------------------------------------------
	forval y = 2007/2018 {
		cap append using `Ab`y''
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "compname_`country'_2007_2019.dta", replace
} // end country loop
*----------------------
} // `sitedesc' section
*----------------------

*--------------------
if `ent' == 1 {
*--------------------
foreach country in /*"USA"*/ "Canada" /*"EuropeHistory"*/ {
	
	forval y = 2010/2015 {
		import delimited "Hist`y'_Enterprise_`country'`y'.txt", clear varn(1)
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		import delimited "SiteLevelEnterprise_`country'`y'.TXT", clear varn(1)
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*-------------------------------------------------------------------
	forval y = 2010/2018 {
		append using `Ab`y'', force
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "enterprise_`country'_2010_2019.dta", replace
	pause
} // end country loop
*----------------------
} // `ent' section
*----------------------

*--------------------
if `compinst' == 1 {
*--------------------
foreach country in "USA" "Canada" "EuropeHistory" {
	
	forval y = 2010/2015 {
		import delimited "Hist`y'_CompInst_`country'`y'.txt", clear varn(1)
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		import delimited "competitiveinstall_`country'`y'.TXT", clear varn(1)
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*-------------------------------------------------------------------
	forval y = 2010/2018 {
		append using `Ab`y'', force
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "compinst_`country'_2010_2019.dta", replace
} // end country loop
*----------------------
} // `compinst' section
*----------------------

*--------------------
if `presinst' == 1 {
*--------------------
foreach country in /*"USA"*/ "Canada" "EuropeHistory" {
	
	forval y = 2010/2015 {
		import delimited "Hist`y'_PresInst_`country'`y'.txt", clear varn(1)
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		drop *
		local countryname = "`country'"

		import delimited "presenceinstall_`countryname'`y'.txt", clear varn(1)
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*-------------------------------------------------------------------
	forval y = 2010/2018 {
		append using `Ab`y'', force
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "presinst_`country'_2010_2019.dta", replace
	pause
} // end country loop
*----------------------
} // `presinst' section
*----------------------

*--------------------
if `pls' == 1 {
*--------------------
foreach country in /*"USA"*/ "Canada" "EuropeHistory" {
	if "`country'" == "EuropeHistory" local start 2011
	else local start 2010

	forval y = `start'/2015 {
		import delimited "Hist`y'_PLS_`country'`y'.txt", clear varn(1)
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		import delimited "purchaselikelihoodscores_`country'`y'.txt", clear varn(1)
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*-------------------------------------------------------------------
	forval y = 2010/2018 {
		append using `Ab`y'', force
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "pls_`country'_2010_2019.dta", replace
} // end country loop
*----------------------
} // `pls' section
*----------------------

*--------------------
if `techtot' == 1 {
*--------------------
foreach country in /*"USA"*/ "Canada" "EuropeHistory" {
	forval y = 2010/2015 {
		import delimited "Hist`y'_Technology_`country'`y'.txt", clear varn(1)
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	forval y = 2016/2019 {
		import delimited "technologytotals_`country'`y'.TXT", clear varn(1)
		cap ren ÿþsiteid siteid
		gen year = `y'
		tempfile Ab`y'
		save `Ab`y'', replace
	}
	*-------------------------------------------------------------------
	forval y = 2010/2018 {
		append using `Ab`y'', force
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "techtot_`country'_2010_2019.dta", replace
} // end country loop
*----------------------
} // `techtot' section
*----------------------

*--------------------
if `businit' == 1 {
*--------------------
* Business Initiatives
foreach country in "USA" /*"Canada" "EuropeHistory"*/ {
	/*
	forval y = 2014/2014 {
		unzipfile "`country'_`y'.zip"
		import delimited "Hist`y'_BUSINIT.txt", clear varn(1)
		gen year = `y'
		save "`country'`y'_businit.dta", replace
		pause
		drop _all
		cd ../
		local filelist: dir "IT_Spending" files "Hist`y'_*.txt"
		cd IT_Spending
		foreach file of local filelist {
			rm "`file'"
		}
		pause
	}
	
	forval y = 2018/2019 {
		unzipfile "`country'_`y'.zip"
		import delimited "BusinessInitiatives.TXT", clear varn(1)
		cap ren ÿþsiteid siteid
		gen year = `y'
		save "`country'`y'_businit.dta", replace
		pause
		drop _all
		cd ../
		local filelist: dir "IT_Spending" files "*.TXT"
		cd IT_Spending
		foreach file of local filelist {
			rm "`file'"
		}
		pause
	}
	
	*-------------------------------------------------------------------
	use "`country'2010_businit.dta", clear
	forval y = 2011/2019 {
		append using "`country'`y'_businit.dta", force
	}
	*===================================================================
	order siteid year
	sort siteid year

	save "businit_`country'_2010_2019.dta", replace
	*/

} // end country loop

use "master_merged.dta", clear
	keep if country == "USA"
	merge 1:1 siteid year using "businit_USA_2010_2019.dta", gen(_mbus)
save "full_sitelevel_USA.dta", replace
	include breach_subset.do
save "breach_subset_sitelevel.dta", replace

*----------------------
} // `businit' section
*----------------------
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if `append_1819' == 1 {
*------------------------
	foreach country in "USA" "Canada" "EuropeHistory" {
/*
		*----* IT Spending *----*
		forval y = 2018/2019 {
			local countryname = "`country'"

			import delimited "itspend_`countryname'`y'.txt", clear varn(1)
			keep *siteid *_budget
			cap ren ÿþsiteid siteid
			gen year = `y'
			tempfile Ab`y'
			save `Ab`y'', replace
		}
		use "itspend_`country'_2007_2017.dta", clear
			append using `Ab2018'
			append using `Ab2019'
		save "itspend_`country'_2007_2019.dta", replace

		*----* Site Description *----*
		forval y = 2018/2019 {
			local countryname = "`country'"

			cap noi import delimited "sitedescription_`countryname'`y'.txt", clear varn(1)
			cap noi import delimited "sitedescription_`countryname'`y'.TXT", clear varn(1)
			keep *siteid company
			cap ren ÿþsiteid siteid
			gen year = `y'
			tempfile Ab`y'
			save `Ab`y'', replace
		}

		use "compname_`country'_2007_2017.dta", clear
			append using `Ab2018', force
			append using `Ab2019', force
		save "compname_`country'_2007_2019.dta", replace
*/
		*----* Enterprise *----*
		forval y = 2018/2019 {
			local countryname = "`country'"

			cap noi import delimited "sitelevelenterprise_`countryname'`y'.txt", clear varn(1)
			cap noi import delimited "sitelevelenterprise_`countryname'`y'.TXT", clear varn(1)
			cap ren ÿþsiteid siteid
			gen year = `y'
			tempfile Ab`y'
			save `Ab`y'', replace
		}

		use "enterprise_`country'_2010_2017.dta", clear
			append using `Ab2018', force
			append using `Ab2019', force
		save "enterprise_`country'_2010_2019.dta", replace
/*
		*----* Competitive Install *----*
		forval y = 2018/2019 {
			local countryname = "`country'"

			cap noi import delimited "competitiveinstall_`countryname'`y'.txt", clear varn(1)
			cap noi import delimited "competitiveinstall_`countryname'`y'.TXT", clear varn(1)
			cap ren ÿþsiteid siteid
			gen year = `y'
			tempfile Ab`y'
			save `Ab`y'', replace
		}

		use "compinst_`country'_2010_2017.dta", clear
			append using `Ab2018', force
			append using `Ab2019', force
		save "compinst_`country'_2010_2019.dta", replace
		*/
	}
*------------------------
}
*------------------------
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if `merge' == 1 {
*-----------------

	*** Site Description ***
	use "compname_USA_2007_2019.dta", clear
	gen country = "USA"
	
	foreach country in "Canada" "EuropeHistory" {
		append using "compname_`country'_2007_2019.dta"
		replace country = "`country'" if country == ""
	}
	compress *, nocoalesce
	save "compname_full.dta", replace

	*** Competitive Install ***
	use siteid year ///
		antivirus_sw_manuf asset_mgmt_sw_manuf accounting_sw_manuf supply_chain_sw_manuf ///
		using "compinst_USA_2010_2019.dta", clear
	gen country = "USA"

	foreach country in "Canada" "EuropeHistory" {
		append using "compinst_`country'_2010_2019.dta", ///
			keep(siteid year ///
				antivirus_sw_manuf asset_mgmt_sw_manuf accounting_sw_manuf supply_chain_sw_manuf)
		replace country = "`country'" if country == ""
	}
	compress *, nocoalesce
	save "compinst_full.dta", replace

	*** Presence Install ***
	use siteid year ///
		asset_mgmt_sw_pres accounting_sw_pres supply_chain_sw_pres ///
		using "presinst_USA_2010_2019.dta", clear
	gen country = "USA"

	foreach country in "Canada" "EuropeHistory" {
		append using "presinst_`country'_2010_2019.dta", ///
			keep(siteid year ///
				asset_mgmt_sw_pres accounting_sw_pres supply_chain_sw_pres)
		replace country = "`country'" if country == ""
	}
	compress *, nocoalesce
	save "presinst_full.dta", replace

	*** Purchase Likelihood Score ***
	use siteid year antivirus_sw_pls using "pls_USA_2010_2019.dta", clear
	gen country = "USA"

	foreach country in "Canada" "EuropeHistory" {
		append using "pls_`country'_2010_2019.dta", keep(siteid year antivirus_sw_pls)
		replace country = "`country'" if country == ""
	}
	compress *, nocoalesce
	save "pls_full.dta", replace

	*** Technology Totals ***
	use siteid year it_staff wireless_users internet_users ///
		desktops laptops storage routers ///
		using "techtot_USA_2010_2019.dta", clear
	gen country = "USA"

	foreach country in "Canada" "EuropeHistory" {
		append using "techtot_`country'_2010_2019.dta", ///
			keep(siteid year ///
				it_staff wireless_users internet_users desktops laptops storage routers)
		replace country = "`country'" if country == ""
	}
	compress *, nocoalesce
	save "techtot_full.dta", replace

	*** Enterprise ***
	use siteid year ent_id ent_company ent_country ///
		using "enterprise_USA_2010_2019.dta", clear
	gen country = "USA"

	foreach country in "Canada" "EuropeHistory" {
		append using "enterprise_`country'_2010_2019.dta", keep(siteid year ent_id ent_company ent_country)
		replace country = "`country'" if country == ""
	}
	compress *, nocoalesce
	save "ent_full.dta", replace

	*** IT Spending ***
	use "itspend_USA_2007_2019.dta", clear
	gen country = "USA"

	foreach country in "Canada" "EuropeHistory" {
		append using "itspend_`country'_2007_2019.dta"
		replace country = "`country'" if country == ""
	}

	merge 1:1 siteid year country using compname_full, keep(1 3) gen(_mconm)
	merge 1:1 siteid year country using compinst_full, keep(1 3) gen(_mcomp)
	merge 1:1 siteid year country using presinst_full, keep(1 3) gen(_mpres)
	merge 1:1 siteid year country using pls_full, keep(1 3) gen(_mpls)
	merge 1:1 siteid year country using techtot_full, keep(1 3) gen(_mtot)
	merge 1:1 siteid year country using ent_full, keep(1 3) gen(_ment)

	save "master_merged.dta", replace

*--------------------
} // `merge' section
*--------------------
