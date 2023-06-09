cls

/*=====================================================================================================================================
Project:		DO FILE TITLE
Author(s):		Author #1
				Author #2
Dependencies:  	World Justice Project
Creation Date:	Month-Year
This version:	Month Day, Year
======================================================================================================================================*/

/*=====================================================================================================================================
					0. Settings
=====================================================================================================================================*/

version 15.1

*--- Defining directories paths:

*------ (a) Carlos Toruno:
if (inlist("`c(username)'", "carlostorunopaniagua")) {
	global path2SP "/Users/carlostorunopaniagua/Documents/GitHub/WJP-workshops/Slides/2-intro2github/"
}

*------ (b) Santiago Pardo:
else if (inlist("`c(username)'", "santiagopardo")) {
	global path2SP "/Users/santiagopardo/OneDrive - World Justice Project/..."
}

*------ (c) Any other user: PLEASE INPUT YOUR PERSONAL PATH TO THE SHAREPOINT DIRECTORY:
else {
	global path2SP "INSERT PATH TO WORKING DIRECTORY HERE"
}

/*=====================================================================================================================================
					1. Data Loading
=====================================================================================================================================*/

use "${path2SP}/Resources/ESS-Germany-data/ESS-Germany-10.dta", clear


/*=====================================================================================================================================
					2. Cleaning
=====================================================================================================================================*/

*--- Recoding ethnicity
recode anctry1 (11070/11078 = 1 "German") ///
	(11000/11060 12000/15140 = 2 "Non-German European") ///
	(. 444444= .) ///
	(else = 3 "Non European"), g(ethni)
	
*--- Recoding variables as binary
g trstprl_bin = (trstprl > 5) if !missing(trstprl)
g trstplc_bin = (trstplc > 5) if !missing(trstplc)
g trstplt_bin = (trstplt > 5) if !missing(trstplt)
g trstprt_bin = (trstprt > 5) if !missing(trstprt)
g trstep_bin  = (trstep > 5)  if !missing(trstep)
g trstun_bin  = (trstun > 5)  if !missing(trstun)
g trstsci_bin = (trstsci > 5) if !missing(trstsci)

	
/*=====================================================================================================================================
					3. Adjustments
=====================================================================================================================================*/

*None

/*=====================================================================================================================================
					4. Collapse
=====================================================================================================================================*/

*--- Collapsing data
collapse (mean) *_bin, by(region)
