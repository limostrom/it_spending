/*
keep_breach_ents.do
*/

pause on
cap cd "Z:/Documents/IT_Spending/"
cap cd "/export/home/dor/lmostrom/Documents/IT_Spending/"

*-------------------------------------------------------------------------------
use "master_entlevel.dta", clear

gen entconm_raw = ent_company
	ren ent_company entconm

forval ii = 1/10 {
preserve
	local start = (`ii' - 1)*3000000 + 1
	dis "Start: `start'"
		if `ii' < 10 local end = `ii'*3000000
		if `ii' == 10 local end = 30823678
	dis "End: `end'"
	
	keep if inrange(_n, `start', `end')
	
	stnd_specialchar entconm, type(name)

	stnd_compname entconm, ///
		gen(stn_conm stn_dbaconm stn_fkaconm entity_type attn_name)

	tempfile part`ii'
	save  `part`ii'', replace
restore
}
use `part1', clear
forval ii = 2/10 {
	append using `part`ii''
}
assert _N == 30823678

save "master_entlevel_stndconms.dta", replace
*-------------------------------------------------------------------------------

use "master_entlevel_stndconms.dta", clear

#delimit ;
keep if inlist(ent_id, "E00104244") /* 21st Century Oncology */
	| inlist(ent_id, "E00959634")
	| inlist(ent_id, "E04052074", "E00620168", "E09638464",
		"E32309384", "E07196015", "E07342340", "E00177286")
	/* Adobe */
	| inlist(ent_id, "E00031915", "E00111591", "E03915300", "E20249585")
	/* Advanced Auto Parts */
	| inlist(ent_id, "E09149496", "E00003775", "E00261071",
		"E07495699", "E06992433", "E09193491", "E09162868", "E09156095")
	| inlist(ent_id, "E09156094", "E09156087", "E09152259", "E09156439",
		"E09152271", "E09149713", "E09142297", "E09145334", "E09149842")
	| inlist(ent_id, "E09148738", "E09142958", "E09149410", "E20256310")
	/* AE Com */
	| inlist(ent_id, "E00036708", "E03897608", "E02688082",
		"E04251775", "E04275785", "E03880147", "E03930677", "E03894619")
	| inlist(ent_id, "E04350132", "E04275785", "E00094968", "E06775495", 
		"E06477607", "E02655338", "E07493954", "E07509300", "E07488958")
	| inlist(ent_id, "E09147241", "E09142702", "E07493954", "E20240916",
		"E04439570", "E03935455", "E07781929", "E07781929", "E20696205")
	/* Akorn */
	| inlist(ent_id, "E00017165", "E07505039")
	/* Alibaba */
	| inlist(ent_id, "E00958510", "E04185210", "E08538180")
	| inlist(ent_id, "E08528393")
	/* Alliance Data Systems */
	| inlist(ent_id, "E00047935", "E08052631")
	/* Altaba / Yahoo */
	| inlist(ent_id, "E00050561", "E00175659", "E07661017", "E07818622")
	/* Amazon.com */
	| inlist(ent_id, "E00050590", "E04412645", "E03262716",
		"E04408217", "E04406343", "E07820965", "E08800085", "E21004195")
	/* American Express */
	| inlist(ent_id, "E02246519", "E04317980", "E04330015", "E04358881",
		"E04332156", "E04333225", "E04343497", "E04344532", "E04357990")
	| inlist(ent_id, "E04369220", "E04375784", "E04633828", "E07015398",
		"E07390733", "E09189822", "E20020889", "E20373990")
	| inlist(ent_id, "E20448812", "E21002123", "E33352677")
	/* Anthem */
	| inlist(ent_id, "E08395178", "E09482145", "E10114818", "E20685019",
		"E00010906", "E00206177", "E03603442", "E03813315", "E07914548")
	| inlist(ent_id, "E02084767", "E08238323") /* Group */
	| inlist(ent_id, "E04484318") /* Holding */
	/* AOL */
	| inlist(ent_id, "E00206572", "E00489003")
	| inlist(ent_id, "E04951735")
	/* Apple */
	| inlist(ent_id, "E04913279", "E07669451", "E08231007", "E08473092",
		"E20349506", "E33360636")
	/* AT&T */
	| inlist(ent_id, "E04265485", "E04206696", "E04244506", "E02206491",
		"E04385797", "E03876155", "E04385098", "E05015671", "E07940042")
	| inlist(ent_id, "E07912231", "E07936568", "E00032712", "E00111610", "E00032712")
	/* Atlassian Corp */
	| inlist(ent_id, "E06798999") /* PLC */
	| inlist(ent_id, "E00392993", "E07939461") /* Pty Ltd */
	| inlist(ent_id, "E07954178") /* Inc. */
	/* Automatic Data Processing */
	| inlist(ent_id, "E00000559", "E00110856", "E03822234", "E08792355")
	/* Auto Zone */
	| inlist(ent_id, "E20090589", "E20320532", "E12159854", "E20178947",
		"E20269809", "E00037086", "E09140611", "E09211047")
	| inlist(ent_id, "E07533164", "E09150607", "E09155696", "E09162009",
		"E11694900", "E12596940")
	| inlist(ent_id, "E22842382") /* Holding */
	/* AVX */
	| inlist(ent_id, "E04426197", "E07113491", "E07718448", "E07820777",
		"E20142464", "E00701185", "E07743749", "E03913078")
	| inlist(ent_id, "E03833000", "E07781440", "E20687628")
	/* B & G Foods */
	| inlist(ent_id, "E00005165")
	| inlist(ent_id, "E00037599", "E21004259") /* Enterprises */
	| inlist(ent_id, "E07964911") /* Products */
	| inlist(ent_id, "E03695695") /* Engineering Group */
	/* Baidu */
	| inlist(ent_id, "E04359359", "E07717455")
	/* Bebe Stores */
	| inlist(ent_id, "E00015195")
	/* Bed, Bath & Beyond */
	| inlist(ent_id, "E00016085")
	/* Dairy Queen */
	| inlist(ent_id, "E20381790", "E20002718", "E20418908", "E20431787",
		"E20438906", "E20320678", "E02158497", "E00254453")
	| inlist(ent_id, "E00255389", "E00279962", "E00290205", "E00290971",
		"E00298622", "E00323579", "E00332176", "E00333825", "E20585536")
	| inlist(ent_id, "E20421914", "E20206703", "E20510207", "E20343523",
		"E20022806", "E21018960", "E20611461", "E21003080", "E20191724")
	| inlist(ent_id, "E07509863", "E20671848", "E20599027", "E20338914",
		"E20218448", "E20607343", "E20467180", "E20666471", "E20414979")
	| inlist(ent_id, "E20300218", "E20594375", "E20529638", "E20206482",
		"E20524615", "E20003104", "E20167799", "E20113785", "E20591859")
	| inlist(ent_id, "E20443016", "E20493233", "E20589332", "E20323323",
		"E20362930", "E20574100", "E20435088", "E20242692", "E20375497")
	| inlist(ent_id, "E20474554", "E20395735", "E00339412", "E00339902",
		"E00384869", "E04080597", "E00429761", "E00614523", "E00643433")
	| inlist(ent_id, "E07509863", "E07957237")
	/* Blucora */
	| inlist(ent_id, "E00051395")
	/* Booking Holdings & Priceline */
	| inlist(ent_id, "E00032964") /* Booking Holdings & Priceline Group */
	| inlist(ent_id, "E04328180", "E08790569", "E33351442", "E33354964") /* Booking.com */
	| inlist(ent_id, "E06673551") /* more Priceline */
	/* Boston Scientific */
	| inlist(ent_id, "E00007979", "E00111236", "E01561367", "E03684829",
		"E04522972", "E03934756", "E03910877")
	| inlist(ent_id, "E03940595", "E08067131", "E12614573")
	/* Brinker International */
	| inlist(ent_id, "E00008292", "E04019383")
	/* Buckle */
	| inlist(ent_id, "E04094852")
	/* Cafepress */
	| inlist(ent_id, "E00036885")
	/* CBS */
	| inlist(ent_id, "E00442941", "E00720792", "E05070334", "E12005560", "E33384818")
	/* Charter Communications */
	| inlist(ent_id, "E00027001", "E00437201", "E07027030", "E06955740", "E01356360")
	| inlist(ent_id, "E00177465")
		/* Time Warner through 2015 when merger w/ Charter Comm occurred */
	| inlist(ent_id, "E04983959") /* Charter Corp */
	/* Chipotle Mexican Grill */
	| inlist(ent_id, "E00103606")
	/* Citigroup */
	| inlist(ent_id, "E00039935", "E06775612")
	/* Citrix Systems */
	| inlist(ent_id, "E00043366", "E00171015") 
	| inlist(ent_id, "E03638555")
	/* Comcast */
	| inlist(ent_id, "E00015883")
	/* Community Health Systems */
	| inlist(ent_id, "E00026288", "E09148898", "E00049404", "E00071370",
		"E00035285", "E00036056", "E00071370")
	| inlist(ent_id, "E04489542", "E09162235", "E08500801", "E04494773")
	/* Connectone Bancorp */
	| inlist(ent_id, "E00033135")
	/* Copart */
	| inlist(ent_id, "E00009375")
	/* Costco Wholesale */
	| inlist(ent_id, "E00032184", "E00111600")
	/* Crown Castle International */
	| inlist(ent_id, "E00052045", "E00081345", "E03295134", "E00929731")
	/* Diageo */
	| inlist(ent_id, "E00040367", "E00111922")
	| inlist(ent_id, "E02198889", "E03844677", "E03847130", "E03833575", 
		"E03940268", "E03905008", "E03844705", "E06541021")
	/* Digital River */
	| inlist(ent_id, "E00051768", "E07653516", "E09675744")
	/* Disney */
	| inlist(ent_id, "E03843754", "E07781341", "E20701881",
		"E04430303", "E32309029", "E08158150", "E08328972")
	/* Domino Pizza */
	| inlist(ent_id, "E00333908")
	/* DSW */
	| inlist(ent_id, "E00269579")
	/* Dun & Bradstreet */
	| inlist(ent_id, "E00175658", "E03818442", "E08066946", "E04325857",
		"E03932460", "E07781507", "E08779125")
	/* ETrade Financial */
	| inlist(ent_id, "E00008464")
	/* eBay */
	| inlist(ent_id, "E00175783", "E00051804", "E03812818", "E02262365",
		"E04138514", "E20581645")
	/* eHealth */
	| inlist(ent_id, "E01888575", "E00044635", "E04416993")
	/* Electronic Arts */
	| inlist(ent_id, "E00021586", "E00111485")
	| inlist(ent_id, "E02891713", "E09144922", "E09209221", "E03025773", "E07649392")
	/* EMC */
	| inlist(ent_id, "E01169670", "E00626784", "E20134021", "E03675383",
		"E02929763", "E02379320", "E04578815", "E04579092")
	| inlist(ent_id, "E04670169", "E12429701", "E20985119")
	/* Equifax */
	| inlist(ent_id, "E00012909")
	/* Facebook */
	| inlist(ent_id, "E00198908", "E07663362", "E06559196", "E04376251", "E08377314")
	/* Fidelity National Information */
	| inlist(ent_id, "E00061665")
	/* FireEye */
	| inlist(ent_id, "E00505257", "E07923276")
	/* Fiserv */
	| inlist(ent_id, "E00034013", "E04903527", "E09214136", "E01145216")
	/* GameStop */
	| inlist(ent_id, "E00043606")
	/* Gannett */
	| inlist(ent_id, "E00929730", "E00930817", "E00177579", "E04407832",
		"E01556573", "E00000784", "E00110881", "E06775678")
	/* Genesco */
	| inlist(ent_id, "E00000330")
	/* Goldcorp */
	| inlist(ent_id, "E00095043") | inlist(ent_id, "E20283786", "E04552454")
	/* Groupon */
	| inlist(ent_id, "E00206443")
	/* Hancock Fabrics */
	| inlist(ent_id, "E00010224") | inlist(ent_id, "E04367459")
	/* Hanesbrands */
	| inlist(ent_id, "E00100187")
	/* Hartford Financial Services */
	| inlist(ent_id, "E07016719", "E04993982")
	/* Heartland Payment Systems */
	| inlist(ent_id, "E00005841")
	/* Hewlett Packard Enterprises */
	| inlist(ent_id, "E00951453", "E00930737")
	/* Hilton Worldwide */
	| inlist(ent_id, "E00555635", "E06589220", "E00936610")
	/* Home Depot */
	| inlist(ent_id, "E20048171", "E20650612", "E12303683")
	/* Honda Motor Company */
	| inlist(ent_id, "E08533307", "E00045862", "E00485818")
	| inlist(ent_id, "E03861895", "E00928609", "E03865561", "E04625760",
		"E03848280", "E03862044", "E03821343")
	/* HSBC Holdings */
	| inlist(ent_id, "E00041122", "E00443525", "E06593537",	"E03928082",
		"E03885923", "E03832772", "E03836405", "E00953575")
	| inlist(ent_id, "E03932154", "E00045284", "E00380745", "E03941072")
	/* Hyatt Hotels */
	| inlist(ent_id, "E00202568", "E06775548")
	/* Intercontinental Hotels */
	| inlist(ent_id, "E00046748", "E00174003")
	| inlist(ent_id, "E01530849", "E03876348", "E03926484", "E02242104",
		"E03920686", "E03802743", "E03849583", "E02217635", "E00939543")
	/* Interxion Holdings */
	| inlist(ent_id, "E00148558", "E03807603")
	/* Intuit */
	| inlist(ent_id, "E00033159")
	| inlist(ent_id, "E07496653", "E20256764", "E33347372")
	/* Jetblue Airways */
	| inlist(ent_id, "E00028602")
	/* Jive Software */
	| inlist(ent_id, "E00582517", "E00581938")
	/* JP Morgan Chase */
	| inlist(ent_id, "E03907100", "E20499282", "E04643111", "E04347297",
		"E04633323", "E04317981", "E04344629", "E00174699", "E04351787")
	| inlist(ent_id, "E07731783", "E08879285", "E20622526", "E04378249", "E04550094")
	/* Kar Auction Services */
	| inlist(ent_id, "E00566961", "E03609621", "E04498195", "E06775818")
	/* Landauer */
	| inlist(ent_id, "E00039311")
	/* Landstar Systems */
	| inlist(ent_id, "E00044651", "E09151016", "E09140202", "E09152717")
	/* Las Vegas Sands */
	| inlist(ent_id, "E00037639")
	/* Estee Lauder */
	| inlist(ent_id, "E04539359", "E09165163")
	/* LinkedIn */
	| inlist(ent_id, "E08105030", "E07777680", "E08606142", "E20684660",
		"E08197170", "E00195967")
	/* LPL Financial Holdings */
	| inlist(ent_id, "E00102150")
	/* Madison Square Garden */
	| inlist(ent_id, "E00206591")
	/* Mantech International */
	| inlist(ent_id, "E00014926", "E01443396")
	/* Michaels */
	| inlist(ent_id, "E20198328")
	/* Neiman Marcus */
	| inlist(ent_id, "E00555670")
	/* Nokia */
	| inlist(ent_id, "E08922545", "E20718946", "E07725615", "E08835298", "E09643671")
	/* Rand Capital */
	| inlist(ent_id, "E04397765")
	/* Rite Aid */
	| inlist(ent_id, "E00006515")
	/* Smucker */
	| inlist(ent_id, "E01931512")
	/* Sony */
	| inlist(ent_id, "E00045755", "E00485772", "E08533198")
	/* SRA International */
	| inlist(ent_id, "E00296099", "E00043498", "E00484169")
	/* St. Jude Medical */
	| inlist(ent_id, "E00026362") | inlist(ent_id, "E00111517")
	/* Supervalu */
	| inlist(ent_id, "E00003734")
	/* Target */
	| inlist(ent_id, "E00003738")
	/* United Continental Holdings */
	| inlist(ent_id, "E00013560", "E00437109")
	/* Wells Fargo */
	| inlist(ent_id, "E04382401", "E04386027", "E04382528", "E04215412",
		"E07810178", "E07043539", "E07068986")
	/* Wendy's */
	| inlist(ent_id, "E00027217", "E04059104", "E04945612");
#delimit cr
	
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
* Looking at site-level enterprise name to examine how similar
*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*	21st Century Oncology
gen groupid = 1 if inlist(ent_id, "E00104244") /// /* 21st Century Oncology */
	| inlist(ent_id, "E00959634") ///
	| inlist(ent_id, "E04052074", "E00620168", "E09638464", ///
		"E32309384", "E07196015", "E07342340", "E00177286")
	
*	Adobe Systems
replace groupid = 2 if ///
	inlist(ent_id, "E00031915", "E00111591", "E03915300", "E20249585")

*	Advanced Auto Parts
replace groupid = 3 if inlist(ent_id, "E09149496", "E00003775", "E00261071", ///
		"E07495699", "E06992433", "E09193491", "E09162868", "E09156095") ///
	| inlist(ent_id, "E09156094", "E09156087", "E09152259", "E09156439", ///
		"E09152271", "E09149713", "E09142297", "E09145334", "E09149842") ///
	| inlist(ent_id, "E09148738", "E09142958", "E09149410", "E20256310")
	
*	AECom	
replace groupid = 4 if inlist(ent_id, "E00036708", "E03897608", "E02688082", ///
		"E04251775", "E04275785", "E03880147", "E03930677", "E03894619") ///
	| inlist(ent_id, "E04350132", "E04275785", "E00094968", "E06775495",  ///
		"E06477607", "E02655338", "E07493954", "E07509300", "E07488958") ///
	| inlist(ent_id, "E09147241", "E09142702", "E07493954", "E20240916", ///
		"E04439570", "E03935455", "E07781929", "E07781929", "E20696205")
	
*	Akorn
replace groupid = 5 if inlist(ent_id, "E00017165", "E07505039")

*	Alibaba
replace groupid = 6 if inlist(ent_id, "E00958510", "E04185210", "E08538180", "E08528393")

*	Alliance Data Systems
replace groupid = 7 if inlist(ent_id, "E00047935", "E08052631")

*	Altaba / Yahoo
replace groupid = 8 if inlist(ent_id, "E00050561", "E00175659", "E07661017", "E07818622")
	
*	Amazon.com
replace groupid = 9 if inlist(ent_id, "E00050590", "E04412645", "E03262716", ///
	"E04408217", "E04406343", "E07820965", "E08800085", "E21004195")
	
*	American Express
replace groupid = 10 if inlist(ent_id, "E02246519", "E04317980", "E04330015", ///
	"E04332156", "E04333225", "E04343497", "E04344532", "E04357990", "E04358881") | ///
	inlist(ent_id, "E04369220", "E04375784", "E04633828", "E07015398", ///
	"E07390733", "E09189822", "E20020889", "E20373990") | ///
	inlist(ent_id, "E20448812", "E21002123", "E33352677")
	
*	Anthem
replace groupid = 11 if inlist(ent_id, "E08395178", "E09482145", "E10114818", ///
	"E20685019", "E00010906", "E00206177", "E03603442", "E03813315", "E07914548") ///
	| inlist(ent_id, "E02084767", "E08238323") ///
	| inlist(ent_id, "E04484318")

*	AOL
replace groupid = 12 if inlist(ent_id, "E00206572", "E00489003") ///
	| inlist(ent_id, "E04951735")

*	Apple	
replace groupid = 13 if inlist(ent_id, "E04913279", "E07669451", "E08231007", ///
	"E08473092", "E20349506", "E33360636")
	
*	AT&T
replace groupid = 14 if inlist(ent_id, "E04265485", "E04206696", "E04244506", ///
	"E02206491", "E04385797", "E03876155", "E04385098", "E05015671") | ///
	inlist(ent_id, "E07912231", "E07936568", "E00032712", "E00111610", ///
	"E00032712", "E07940042")
	
*	Atlassian Corp
replace groupid = 15 if inlist(ent_id, "E06798999") ///
	| inlist(ent_id, "E00392993", "E07939461") ///
	| inlist(ent_id, "E07954178")

*	Automatic Data Processing
replace groupid = 16 if inlist(ent_id, "E00000559", "E00110856", "E03822234", "E08792355")

*	Auto Zone
replace groupid = 17 if inlist(ent_id, "E20090589", "E20320532", "E12159854", ///
	"E20178947", "E20269809", "E00037086", "E09140611", "E09211047") | ///
	inlist(ent_id, "E07533164", "E09150607", "E09155696", "E09162009", ///
	"E11694900", "E12596940") ///
	|inlist(ent_id, "E22842382")

*	AVX
replace groupid = 18 if inlist(ent_id, "E04426197", "E07113491", "E07718448", ///
	"E07820777", "E20142464", "E00701185", "E07743749", "E03913078") | ///
	inlist(ent_id, "E03833000", "E07781440", "E20687628")
	
*	B & G Foods
replace groupid = 19 if inlist(ent_id, "E00005165") ///
	| inlist(ent_id, "E00037599", "E21004259") ///
	| inlist(ent_id, "E07964911") ///
	| inlist(ent_id, "E03695695")

*	Baidu
replace groupid = 20 if inlist(ent_id, "E04359359", "E07717455")

*	Bebe Stores
replace groupid = 21 if inlist(ent_id, "E00015195")
	
*	Bed, Bath & Beyond
replace groupid = 22 if inlist(ent_id, "E00016085")

*	Dairy Queen (Berkshire Hathaway)
replace groupid = 23 if inlist(ent_id, "E20381790", "E20002718", "E20418908", ///
	"E20431787", "E20438906", "E20320678", "E02158497", "E00254453") | ///
	inlist(ent_id, "E00255389", "E00279962", "E00290205", "E00290971", ///
	"E00298622", "E00323579", "E00332176", "E00333825", "E20585536") | ///
	inlist(ent_id, "E20421914", "E20206703", "E20510207", "E20343523", ///
	"E20022806", "E21018960", "E20611461", "E21003080", "E20191724") | ///
	inlist(ent_id, "E07509863", "E20671848", "E20599027", "E20338914", ///
	"E20218448", "E20607343", "E20467180", "E20666471", "E20414979") | ///
	inlist(ent_id, "E20300218", "E20594375", "E20529638", "E20206482", ///
	"E20524615", "E20003104", "E20167799", "E20113785", "E20591859") | ///
	inlist(ent_id, "E20443016", "E20493233", "E20589332", "E20323323", ///
	"E20362930", "E20574100", "E20435088", "E20242692", "E20375497") | ///
	inlist(ent_id, "E20474554", "E20395735", "E00339412", "E00339902", ///
	"E00384869", "E04080597", "E00429761", "E00614523", "E00643433") | ///
	inlist(ent_id, "E07509863", "E07957237")
	
*	Blucora
replace groupid = 24 if inlist(ent_id, "E00051395")

*	Booking Holdings / Priceline
replace groupid = 25 if inlist(ent_id, "E00032964") ///
	| inlist(ent_id, "E04328180", "E08790569", "E33351442", "E33354964") ///
	| inlist(ent_id, "E06673551")

*	Boston Scientific
replace groupid = 26 if inlist(ent_id, "E00007979", "E00111236", "E01561367", ///
	"E03684829", "E04522972", "E03934756", "E03910877") | ///
	inlist(ent_id, "E03940595", "E08067131", "E12614573")
	
*	Brinker International
replace groupid = 27 if inlist(ent_id, "E00008292", "E04019383")

*	Buckle
replace groupid = 28 if inlist(ent_id, "E04094852")

*	Cafepress
replace groupid = 29 if inlist(ent_id, "E00036885")

*	CBS
replace groupid = 30 if inlist(ent_id, "E00442941", "E00720792", "E05070334", ///
	"E12005560", "E33384818")

*	Charter Communications
replace groupid = 31 if inlist(ent_id, "E00027001", "E00437201", "E07027030", ///
	"E06955740", "E01356360") ///
	| inlist(ent_id, "E00177465") /// 
	| inlist(ent_id, "E04983959")

*	Chipotle Mexican Grill
replace groupid = 32 if inlist(ent_id, "E00103606")

*	Citigroup
replace groupid = 33 if inlist(ent_id, "E00039935", "E06775612")
	
*	Citrix Systems
replace groupid = 34 if inlist(ent_id, "E00043366", "E00171015") ///
	| inlist(ent_id, "E03638555")

*	Comcast
replace groupid = 35 if inlist(ent_id, "E00015883")
	
*	Community Health Systems
replace groupid = 36 if inlist(ent_id, "E00026288", "E09148898", "E00049404", ///
	"E00071370", "E00035285", "E00036056", "E00071370") ///
	| inlist(ent_id, "E04489542", "E09162235", "E08500801", "E04494773")

*	Connectone Bancorp
replace groupid = 37 if inlist(ent_id, "E00033135")

*	Copart
replace groupid = 38 if inlist(ent_id, "E00009375")

*	Costco Wholesale
replace groupid = 39 if inlist(ent_id, "E00032184", "E00111600")
	
*	Crown Castle International
replace groupid = 40 if ///
	inlist(ent_id, "E00052045", "E00081345", "E03295134", "E00929731")

*	Diageo
replace groupid = 41 if inlist(ent_id, "E00040367", "E00111922") | ///
	inlist(ent_id, "E02198889", "E03844677", "E03847130", ///
	"E03833575", "E03940268", "E03905008", "E03844705", "E06541021")

*	Digital River
replace groupid = 42 if inlist(ent_id, "E00051768", "E07653516", "E09675744")

*	Disney
replace groupid = 43 if inlist(ent_id, "E03843754", "E07781341", "E20701881", ///
	"E04430303", "E32309029", "E08158150", "E08328972")

*	Domino Pizza
replace groupid = 44 if inlist(ent_id, "E00333908")

*	DSW
replace groupid = 45 if inlist(ent_id, "E00269579")

*	Dun & Bradstreet
replace groupid = 46 if inlist(ent_id, "E00175658", "E03818442", "E08066946", ///
	"E04325857", "E03932460", "E07781507", "E08779125")

*	ETrade Financial
replace groupid = 47 if inlist(ent_id, "E00008464")

*	eBay
replace groupid = 48 if inlist(ent_id, "E00175783", "E00051804", "E03812818", ///
	"E02262365", "E04138514", "E20581645")
	
*	eHealth
replace groupid = 49 if inlist(ent_id, "E01888575", "E00044635", "E04416993")

*	Electronic Arts
replace groupid = 50 if inlist(ent_id, "E00021586", "E00111485") | ///
	inlist(ent_id, "E02891713", "E09144922", "E09209221", ///
	"E03025773", "E07649392")
	
*	EMC
replace groupid = 51 if inlist(ent_id, "E01169670", "E00626784", "E20134021", ///
	"E03675383", "E02929763", "E02379320", "E04578815", "E04579092") | ///
	inlist(ent_id, "E04670169", "E12429701", "E20985119")

*	Equifax
replace groupid = 52 if inlist(ent_id, "E00012909")
	
*	Facebook
replace groupid = 53 if inlist(ent_id, "E00198908", "E07663362", "E06559196", ///
	"E04376251", "E08377314")

*	Fidelity National Information Services
replace groupid = 54 if inlist(ent_id, "E00061665")
	
*	FireEye
replace groupid = 55 if inlist(ent_id, "E00505257", "E07923276")

*	Fiserv
replace groupid = 56 if ///
	inlist(ent_id, "E00034013", "E04903527", "E09214136", "E01145216")

*	GameStop
replace groupid = 57 if inlist(ent_id, "E00043606")

*	Gannett
replace groupid = 58 if inlist(ent_id, "E00929730", "E00930817", "E00177579", ///
	"E04407832", "E01556573", "E00000784", "E00110881", "E06775678")
	
*	Genesco
replace groupid = 59 if inlist(ent_id, "E00000330")

*	Goldcorp
replace groupid = 60 if inlist(ent_id, "E00095043") ///
	| inlist(ent_id, "E20283786", "E04552454")

*	Groupon
replace groupid = 61 if inlist(ent_id, "E00206443")

*	Hancock Fabrics
replace groupid = 62 if inlist(ent_id, "E00010224") ///
	| inlist(ent_id, "E04367459")

*	Hanesbrands
replace groupid = 63 if inlist(ent_id, "E00100187")

*	Hartford Financial Services
replace groupid = 64 if inlist(ent_id, "E07016719", "E04993982")

*	Heartland Payment Systems
replace groupid = 65 if inlist(ent_id, "E00005841")

*	Hewlett Packard Enterprises
replace groupid = 66 if inlist(ent_id, "E00951453", "E00930737")

*	Hilton Worldwide
replace groupid = 67 if inlist(ent_id, "E00555635", "E06589220", "E00936610")

*	Home Depot
replace groupid = 68 if inlist(ent_id, "E20048171", "E20650612", "E12303683")

*	Honda Motor Company
replace groupid = 69 if inlist(ent_id, "E08533307", "E00045862", "E00485818") | ///
	inlist(ent_id, "E03861895", "E00928609", "E03865561", "E04625760", ///
	"E03848280", "E03862044", "E03821343")

*	HSBC Holdings
replace groupid = 70 if inlist(ent_id, "E00041122", "E00443525", "E06593537", ///
	"E03928082", "E03885923", "E03832772", "E03836405", "E00953575") | ///
	inlist(ent_id, "E03932154", "E00045284", "E00380745", "E03941072")
	
*	Hyatt Hotels
replace groupid = 71 if inlist(ent_id, "E00202568", "E06775548")

*	Intercontinental Hotels
replace groupid = 72 if inlist(ent_id, "E00046748", "E00174003") ///
	| inlist(ent_id, "E01530849", "E03876348", "E03926484", ///
	"E02242104", "E03920686", "E03802743", "E03849583", "E02217635", "E00939543")
	
*	Interxion Holdings
replace groupid = 73 if inlist(ent_id, "E00148558", "E03807603")

*	Intuit
replace groupid = 74 if inlist(ent_id, "E00033159") ///
	| inlist(ent_id, "E07496653", "E20256764", "E33347372")

*	Jetblue Airways
replace groupid = 75 if inlist(ent_id, "E00028602")

*	Jive Software
replace groupid = 76 if inlist(ent_id, "E00582517", "E00581938")

*	JP Morgan Chase
replace groupid = 77 if inlist(ent_id, "E03907100", "E20499282", "E04643111", ///
	"E04347297", "E04633323", "E04317981", "E04344629", "E00174699") | ///
	inlist(ent_id, "E07731783", "E08879285", "E20622526", "E04378249", ///
	"E04550094", "E04351787")
	
*	Kar Auction Services
replace groupid = 78 if ///
	inlist(ent_id, "E00566961", "E03609621", "E04498195", "E06775818")

*	Landauer
replace groupid = 79 if inlist(ent_id, "E00039311")

*	Landstar System
replace groupid = 80 if ///
	inlist(ent_id, "E00044651", "E09151016", "E09140202", "E09152717")

*	Las Vegas Sands
replace groupid = 81 if inlist(ent_id, "E00037639")

*	Estee Lauder
replace groupid = 82 if inlist(ent_id, "E04539359", "E09165163")
	
*	LinkedIn
replace groupid = 83 if inlist(ent_id, "E08105030", "E07777680", "E08606142", ///
	"E20684660", "E08197170") ///
	| inlist(ent_id, "E00195967")
	
*	LPL Financial Holdings
replace groupid = 84 if inlist(ent_id, "E00102150")

*	Madison Square Garden
replace groupid = 85 if inlist(ent_id, "E00206591")

*	Mantech International
replace groupid = 86 if inlist(ent_id, "E00014926") | inlist(ent_id, "E01443396")

*	Michaels
replace groupid = 87 if inlist(ent_id, "E20198328")

*	Neiman Marcus
replace groupid = 88 if inlist(ent_id, "E00555670")

*	Nokia
replace groupid = 89 if inlist(ent_id, "E08922545", "E20718946", "E07725615", ///
	"E08835298", "E09643671")
	
*	Rand Capital
replace groupid = 90 if inlist(ent_id, "E04397765")

*	Rite Aid
replace groupid = 91 if inlist(ent_id, "E00006515")

*	Smucker
replace groupid = 92 if inlist(ent_id, "E01931512")

*	Sony
replace groupid = 93 if inlist(ent_id, "E00045755", "E00485772", "E08533198")

*	SRA International
replace groupid = 94 if inlist(ent_id, "E00296099", "E00043498", "E00484169")

*	St. Jude Medical
replace groupid = 95 if inlist(ent_id, "E00026362") | inlist(ent_id, "E00111517")

*	Supervalu
replace groupid = 96 if inlist(ent_id, "E00003734")

*	Target
replace groupid = 97 if inlist(ent_id, "E00003738")

*	United Continental Holdings
replace groupid = 98 if inlist(ent_id, "E00013560", "E00437109")

*	Wells Fargo
replace groupid = 99 if inlist(ent_id, "E04382401", "E04386027", "E04382528", ///
	"E04215412", "E07810178", "E07043539", "E07068986")

*	Wendy's
replace groupid = 100 if inlist(ent_id, "E00027217", "E04059104", "E04945612")


save "master_clean_subset.dta", replace




