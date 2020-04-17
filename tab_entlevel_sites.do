/*
tab_entlevel_sites.do


*/

use master_merged.dta, clear

*	21st Century Oncology
tab ent_company if inlist(ent_id, "E00104244") // Holdings
			// mostly Radiation Therapy Services Holdings, Inc. ???
tab ent_company if inlist(ent_id, "E00959634") // Investments
tab ent_company if inlist(ent_id, "E04052074", "E00620168", "E09638464", ///
	"E32309384", "E07196015", "E07342340", "E00177286")

*	Adobe Systems
tab ent_company if inlist(ent_id, "E00031915", "E00111591", "E03915300", "E20249585")

*	Advanced Auto Parts
tab ent_company if inlist(ent_id, "E09149496", "E00003775", "E00261071", ///
	"E07495699", "E06992433", "E09193491", "E09162868", "E09156095") | ///
	inlist(ent_id, "E09156094", "E09156087", "E09152259", "E09156439", ///
	"E09152271", "E09149713", "E09142297", "E09145334", "E09149842") | ///
	inlist(ent_id, "E09148738", "E09142958", "E09149410", "E20256310")

*	AECom
tab ent_company if inlist(ent_id, "E00036708", "E03897608", "E02688082", ///
	"E04251775", "E04275785", "E03880147", "E03930677", "E03894619") | ///
	inlist(ent_id, "E04350132", "E04275785", "E00094968", "E06775495", ///
	"E06477607", "E02655338", "E07493954", "E07509300", "E07488958") | ///
	inlist(ent_id, "E09147241", "E09142702", "E07493954", "E20240916", ///
	"E04439570", "E03935455", "E07781929", "E07781929", "E20696205")

*	Akorn
tab ent_company if inlist(ent_id, "E00017165", "E07505039")

*	Alibaba
tab ent_company if inlist(ent_id, "E00958510", "E04185210", "E08538180")
tab ent_company if inlist(ent_id, "E08528393")

*	Alliance Data Systems
tab ent_company if inlist(ent_id, "E00047935", "E08052631")

*	Altaba / Yahoo
tab ent_company if inlist(ent_id, "E00050561") // mode Altaba but also Yahoo
tab ent_company if inlist(ent_id, "E00050561", "E00175659", "E07661017", "E07818622")
	// mode Yahoo but also Altaba

*	Amazon.com
tab ent_company if inlist(ent_id, "E00050590", "E04412645", "E03262716", ///
	"E04408217", "E04406343", "E07820965", "E08800085", "E21004195")
	
*	American Express
tab ent_company if inlist(ent_id, "E02246519", "E04317980", "E04330015", ///
	"E04332156", "E04333225", "E04343497", "E04344532", "E04357990", "E04358881") | ///
	inlist(ent_id, "E04369220", "E04375784", "E04633828", "E07015398", ///
	"E07390733", "E09189822", "E20020889", "E20373990") | ///
	inlist(ent_id, "E20448812", "E21002123", "E33352677")
	
*	Anthem
tab ent_company if inlist(ent_id, "E08395178", "E09482145", "E10114818", ///
	"E20685019", "E00010906", "E00206177", "E03603442", "E03813315", "E07914548")
tab ent_company if inlist(ent_id, "E02084767", "E08238323") // Group
tab ent_company if inlist(ent_id, "E04484318") // Holdings

*	AOL
tab ent_company if inlist(ent_id, "E00206572", "E00489003")
tab ent_company if inlist(ent_id, "E04951735") // Holdings

*	Apple
tab ent_company if inlist(ent_id, "E04913279", "E07669451", "E08231007", ///
	"E08473092", "E20349506", "E33360636") // contains Apple Mini Cabs ???

*	AT&T
tab ent_company if inlist(ent_id, "E04265485", "E04206696", "E04244506", ///
	"E02206491", "E04385797", "E03876155", "E04385098", "E05015671") | ///
	inlist(ent_id, "E07912231", "E07936568", "E00032712", "E00111610", ///
	"E00032712", "E07940042")
	// "E00032577" removed because mostly Verizon;
	//	AT&T in 2016 only, nowhere near 2009 partial acquisition
	
*	Atlassian Corp
tab ent_company if inlist(ent_id, "E06798999") // PLC
tab ent_company if inlist(ent_id, "E00392993", "E07939461") // Pty Ltd
tab ent_company if inlist(ent_id, "E07954178") // Inc.

*	Automatic Data Processing
tab ent_company if inlist(ent_id, "E00000559", "E00110856", "E03822234", "E08792355")

*	Auto Zone
tab ent_company if inlist(ent_id, "E20090589", "E20320532", "E12159854", ///
	"E20178947", "E20269809", "E00037086", "E09140611", "E09211047") | ///
	inlist(ent_id, "E07533164", "E09150607", "E09155696", "E09162009", ///
	"E11694900", "E12596940")
tab ent_company if inlist(ent_id, "E22842382") // Holdings

*	AVX
tab ent_company if inlist(ent_id, "E04426197", "E07113491", "E07718448", ///
	"E07820777", "E20142464", "E00701185", "E07743749", "E03913078") | ///
	inlist(ent_id, "E03833000", "E07781440", "E20687628")

*	B & G Foods
tab ent_company if inlist(ent_id, "E00005165")
tab ent_company if inlist(ent_id, "E00037599", "E21004259") // Enterprises
tab ent_company if inlist(ent_id, "E07964911") // Products
tab ent_company if inlist(ent_id, "E03695695") // Engineering Group

*	Baidu
tab ent_company if inlist(ent_id, "E04359359", "E07717455") // Baidu USA only

*	Bebe Stores
tab ent_company if inlist(ent_id, "E00015195") // just use this one
tab ent_company if inlist(ent_id, "E09635040", "E09671831", "E09624982", ///
	"E09671818", "E09671775", "E09671819", "E09637318") | ///
	inlist(ent_id, "E09635042", "E09671820", "E09635041", "E09637116", ///
	"E09671821", "E09671832") // only 13 sites; not worth it

*	Bed, Bath & Beyond
tab ent_company if inlist(ent_id, "E00016085") // just use this one
tab ent_company if inlist(ent_id, "E02050877", "E00680545", "E09138320")
	// only 4 sites and one isn't even a BB&B

*	Dairy Queen (Berkshire Hathaway)
tab ent_company if inlist(ent_id, "E20381790", "E20002718", "E20418908", ///
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
tab ent_company if inlist(ent_id, "E00051395")

*	Booking Holdings / Priceline
tab ent_company if inlist(ent_id, "E00032964") // Booking Holdings & Priceline Group
tab ent_company if inlist(ent_id, "E04328180", "E08790569", "E33351442", "E33354964")
	// Booking.com
tab ent_company if inlist(ent_id, "E06673551") // more Priceline

*	Boston Scientific
tab ent_company if inlist(ent_id, "E00007979", "E00111236", "E01561367", ///
	"E03684829", "E04522972", "E03934756", "E03910877") | ///
	inlist(ent_id, "E03940595", "E08067131", "E12614573")

*	Brinker International
tab ent_company if inlist(ent_id, "E00008292", "E04019383")

*	Buckle
tab ent_company if inlist(ent_id, "E04094852") // only 2 obs

*	Cafepress
tab ent_company if inlist(ent_id, "E00036885")

*	CBS
tab ent_company if inlist(ent_id, "E00442941", "E00720792", "E05070334", ///
	"E12005560", "E33384818")

*	Charter Communications
tab ent_company if inlist(ent_id, "E00027001", "E00437201", "E07027030", ///
	"E06955740", "E01356360")
tab ent_company year if inlist(ent_id, "E00177465")
	// Time Warner through 2015 when merger w/ Charter Comm occurred
tab ent_company if inlist(ent_id, "E04983959") // Charter Corp

*	Chipotle Mexican Grill
tab ent_company if inlist(ent_id, "E00103606") // 4,000 sites
tab ent_company if inlist(ent_id, "E09153669", "E09163375", "E09162627", ///
	"E09162351", "E09163959", "E09156426") // only 7 sites

*	Citigroup
tab ent_company if inlist(ent_id, "E00039935", "E06775612") // ~50k sites
tab ent_company if inlist(ent_id, "E07091929", "E03932081", "E01349040") | ///
	inlist(ent_id, "E02687233", "E04344401", "E04358839", "E03933623", ///
	"E01565400", "E04376868", "E07107144", "E00111809", "E05051272")
	// only ~92 sites

*	Citrix Systems
tab ent_company if inlist(ent_id, "E00043366", "E00171015") 
tab ent_company if inlist(ent_id, "E03638555")

*	Comcast
tab year ent_company if inlist(ent_id, "E00015883") // 11,827 out of 11,885

tab year ent_company if inlist(ent_id, "E01172577", "E01264733", "E01266835", ///
	"E04348872", "E04357526", "E04371657", "E04382037", "E04933412") | ///
	inlist(ent_id, "E00037173", "E00511397", "E02254881", "E03845397", ///
	"E03916999", "E04269159", "E04989019", "E06525980", "E07078358") | ///
	inlist(ent_id, "E07092213", "E07913565", "E08788454", "E08797172", "E08834426")

*	Community Health Systems
tab ent_company if inlist(ent_id, "E00026288", "E09148898", "E00049404", ///
	"E00071370", "E00035285", "E00036056", "E00071370") ///
	| inlist(ent_id, "E04489542", "E09162235", "E08500801", "E04494773")

*	Connectone Bancorp
tab year ent_company if inlist(ent_id, "E00033135")

*	Copart
tab year ent_company if inlist(ent_id, "E00009375") // ~almost 1400 sites
tab year ent_company if inlist(ent_id, "E04565323", "E07519839", "E06529760")
	// only 4 sites, don't bother

*	Costco Wholesale
tab ent_company if inlist(ent_id, "E00032184", "E00111600") // 3500 sites
tab ent_company if inlist(ent_id, "E00620464", "E04537247", "E04537315", ///
	"E30014075", "E20102643", "E30014753," "E20671201") // only 5 sites

*	Crown Castle International
tab ent_company if inlist(ent_id, "E00052045", "E00081345", "E03295134", "E00929731")

*	Diageo
tab ent_company if inlist(ent_id, "E00040367", "E00111922") | ///
	inlist(ent_id, "E02198889", "E03844677", "E03847130", ///
	"E03833575", "E03940268", "E03905008", "E03844705", "E06541021")

*	Digital River
tab ent_company if inlist(ent_id, "E00051768", "E07653516", "E09675744")

*	Disney
tab ent_company if inlist(ent_id, "E03843754", "E07781341", "E20701881", ///
	"E04430303", "E32309029", "E08158150", "E08328972") // only 8 sites

*	Domino Pizza
tab ent_company if inlist(ent_id, "E00333908")

*	DSW
tab ent_company if inlist(ent_id, "E00269579")

*	Dun & Bradstreet
tab ent_company if inlist(ent_id, "E00175658", "E03818442", "E08066946", ///
	"E04325857", "E03932460", "E07781507", "E08779125")

*	ETrade Financial
tab ent_company if inlist(ent_id, "E00008464") // 601 sites
tab ent_company if inlist(ent_id, "E09144954") // 2 sites only

*	eBay
tab ent_company if inlist(ent_id, "E00175783", "E00051804", "E03812818", ///
	"E02262365", "E04138514", "E20581645")

*	eHealth
tab ent_company if inlist(ent_id, "E01888575", "E00044635", "E04416993")

*	Electronic Arts
tab ent_company if inlist(ent_id, "E00021586", "E00111485") | ///
	inlist(ent_id, "E02891713", "E09144922", "E09209221", ///
	"E03025773", "E07649392") // 411 sites

*	EMC
tab ent_company if inlist(ent_id, "E01169670", "E00626784", "E20134021", ///
	"E03675383", "E02929763", "E02379320", "E04578815", "E04579092") | ///
	inlist(ent_id, "E04670169", "E12429701", "E20985119")
	
*	Equifax
tab ent_company if inlist(ent_id, "E00012909") // 995 sites
tab ent_company if inlist(ent_id, "E04430610", "E07024837", "E03828097", ///
	"E07781462", "E20728103") // only 9 sites

*	Facebook
tab ent_company if inlist(ent_id, "E00198908", "E07663362", "E06559196", ///
	"E04376251", "E08377314")

*	Fidelity National Information Services
tab ent_company if inlist(ent_id, "E00061665") // 4930 sites
tab ent_company if inlist(ent_id, "E00437058", "E04415222", "E00344498", "E00944379")
	// 15 sites only

*	FireEye
tab ent_company if inlist(ent_id, "E00505257", "E07923276")

*	Fiserv
tab ent_company if inlist(ent_id, "E00034013", "E04903527", "E09214136", "E01145216")

*	GameStop
tab ent_company if inlist(ent_id, "E00043606") // 15,808 sites
tab ent_company if inlist(ent_id, "E00171022") // 1 site only

*	Gannett
tab ent_company if inlist(ent_id, "E00929730", "E00930817", "E00177579", ///
	"E04407832", "E01556573", "E00000784", "E00110881", "E06775678") // 4199

*	Genesco
tab ent_company if inlist(ent_id, "E00000330") // 4,688
tab ent_company if inlist(ent_id, "E00436912", "E00342107") // only 12 sites

*	Goldcorp
tab ent_company if inlist(ent_id, "E00095043") // 129
tab ent_company if inlist(ent_id, "E20283786", "E04552454") // 2 sites only

*	Groupon
tab ent_company if inlist(ent_id, "E00206443")

*	Hancock Fabrics
tab ent_company if inlist(ent_id, "E00010224") // 209
tab ent_company if inlist(ent_id, "E04367459") // 4 sites only

*	Hanesbrands
tab year ent_company if inlist(ent_id, "E00100187") // 1570 sites
tab ent_company if inlist(ent_id, "E03791976") // only 1 site-level

*	Hartford Financial Services
tab ent_company if inlist(ent_id, "E07016719", "E04993982") // still only 7

*	Heartland Payment Systems
tab ent_company if inlist(ent_id, "E00005841") // 658 sites
tab ent_company if inlist(ent_id, "E07933340", "E08923251", "E20714208") // 5 sites only

*	Hewlett Packard Enterprises
tab ent_company if inlist(ent_id, "E00951453", "E00930737") // 1169
tab ent_company if inlist(ent_id, "E07525268", "E03821643", "E02689457", ///
	"E00505046", "E03829583", "E03894187", "E03815296", "E04640743") // 13 only
	
*	Hilton Worldwide
tab ent_company if inlist(ent_id, "E00555635", "E06589220", "E00936610") // 1567
tab ent_company if inlist(ent_id, "E03685259", "E03824383", "E01831004", "E04379822", ///
	"E02450194", "E00935709", "E01765267") | ///
	inlist(ent_id, "E02978021", "E03940423", "E07784433", ///
	"E09139037", "E20729567", "E05041223", "E04205018", "E20529194") // only 23
	
*	Home Depot
tab ent_company if inlist(ent_id, "E20048171", "E20650612", "E12303683") // only 3 obs

*	Honda Motor Company
tab ent_company if inlist(ent_id, "E08533307", "E00045862", "E00485818") | ///
	inlist(ent_id, "E03861895", "E00928609", "E03865561", "E04625760", ///
	"E03848280", "E03862044", "E03821343")
	
*	HSBC Holdings
tab ent_company if inlist(ent_id, "E00041122", "E00443525", "E06593537", ///
	"E03928082", "E03885923", "E03832772", "E03836405", "E00953575") | ///
	inlist(ent_id, "E03932154", "E00045284", "E00380745", "E03941072")

*	Hyatt Hotels
tab ent_company if inlist(ent_id, "E00202568", "E06775548") // 2418 
tab ent_company if inlist(ent_id, "E00484164", "E09140456", "E04227078")
	// 15 sites only
	
*	Intercontinental Hotels
tab ent_company if inlist(ent_id, "E00046748", "E00174003")
tab ent_company if inlist(ent_id, "E01530849", "E03876348", "E03926484", ///
	"E02242104", "E03920686", "E03802743", "E03849583", "E02217635", "E00939543")

*	Interxion Holdings
tab ent_company if inlist(ent_id, "E00148558", "E03807603")

*	Intuit
tab ent_company if inlist(ent_id, "E00033159")
tab ent_company if inlist(ent_id, "E07496653", "E20256764", "E33347372")

*	Jetblue Airways
tab ent_company if inlist(ent_id, "E00028602")

*	Jive Software
tab ent_company if inlist(ent_id, "E00582517", "E00581938") // only covers 2015-16

*	JP Morgan Chase
tab year ent_company if inlist(ent_id, "E03907100", "E20499282", "E04643111", ///
	"E04347297", "E04633323", "E04317981", "E04344629", "E00174699") | ///
	inlist(ent_id, "E07731783", "E08879285", "E20622526", "E04378249", ///
	"E04550094", "E04351787") // few sites, but 2011-19

*	Kar Auction Services
tab ent_company if inlist(ent_id, "E00566961", "E03609621", "E04498195", "E06775818")

*	Landauer
tab ent_company if inlist(ent_id, "E00039311")

*	Landstar System
tab ent_company if inlist(ent_id, "E00044651", "E09151016", "E09140202", "E09152717")

*	Las Vegas Sands
tab ent_company if inlist(ent_id, "E00037639")

*	Estee Lauder
tab ent_company if inlist(ent_id, "E04539359", "E09165163")
	// only 4 sites

*	LinkedIn
tab year ent_company if inlist(ent_id, "E08105030", "E07777680", "E08606142", ///
	"E20684660", "E08197170")
tab year ent_company if inlist(ent_id, "E00195967")
	// has a suspicious 19 sites instead of the usual 1-2 but the only 2016 obs
	// -> need to include that last one to get 2016 but check budget numbers
	//	for consistency

*	LPL Financial Holdings
tab year ent_company if inlist(ent_id, "E00102150") // just do this, 2010-19
	// Financial Holdings & Investment Holdings
tab ent_company if inlist(ent_id, "E03319156", "E03532353", "E04973434", ///
	"E06618408", "E06835171", "E07061100", "E07066232", "E07069277") | ///
	inlist(ent_id, "E07097247", "E07164432", "E07360481", "E07942289", ///
	"E08137217", "E09139182", "E09153528", "E09162154") | ///
	inlist(ent_id, "E09164389", "E30004919", "E33342774")

*	Madison Square Garden
tab year ent_company if inlist(ent_id, "E00206591")

*	Mantech International
tab year ent_company if inlist(ent_id, "E00014926")
tab year ent_company if inlist(ent_id, "E01443396")

*	Michaels
tab year ent_company if inlist(ent_id, "E20198328")

*	Neiman Marcus
tab ent_company if inlist(ent_id, "E00555670") // 395 sites
tab ent_company if inlist(ent_id, "E03585464") // 2 sites only

*	Nokia
tab year ent_company if inlist(ent_id, "E08922545", "E20718946", "E07725615", ///
	"E08835298", "E09643671") // only 2017-19
	
*	Rand Capital
tab year ent_company if inlist(ent_id, "E04397765") // 2016-19

*	Rite Aid
tab year ent_company if inlist(ent_id, "E00006515") // 2010-19
tab year ent_company if inlist(ent_id, "E00199228", "E04417888")

*	Smucker
tab year ent_company if inlist(ent_id, "E01931512") // 2016-19 only

*	Sony
tab ent_company if inlist(ent_id, "E00045755", "E00485772", "E08533198") // 2,316
tab ent_company if inlist(ent_id, "E03820052", "E03865699", "E03881523", ///
	"E02549888", "E03800231", "E03800231", "E03899585", "E03880206") // only 7
	
*	SRA International
tab year ent_company if inlist(ent_id, "E00296099", "E00043498", "E00484169")
 // 2010-11 has a suspicious number of sites
 
*	St. Jude Medical
tab ent_company if inlist(ent_id, "E00026362") // 272
tab ent_company if inlist(ent_id, "E00111517")

*	Supervalu
tab year ent_company if inlist(ent_id, "E00003734")

*	Target
tab year ent_company if inlist(ent_id, "E00003738") // many more sites 2016-19 only

*	United Continental Holdings
tab ent_company if inlist(ent_id, "E00013560", "E00437109")

*	Wells Fargo
tab year ent_company if inlist(ent_id, "E04382401", "E04386027", "E04382528", ///
	"E04215412", "E07810178", "E07043539", "E07068986") // 2016-19 only

*	Wendy's
tab year ent_company if inlist(ent_id, "E00027217", "E04059104", "E04945612")
	// International 2010-19
tab year ent_company if inlist(ent_id, "E08460290", "E00603610", "E08213731", ///
	"E20505538", "E20327982", "E20282416", "E20521642", "E20320746") | ///
	inlist(ent_id, "E20670936", "E20317299", "E20028226", "E20154474")
	// (just) Wendy's, but only available from 2016 on
	

















