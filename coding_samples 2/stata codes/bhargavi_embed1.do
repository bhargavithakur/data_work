
*The Dataset
*In 2010, J-PAL researchers conducted a randomized control trial (RCT) to increase voter turnout, with an emphasis on female turnout, during an election in India. The RCT was conducted in 27 towns, with approximately half of the polling booths in each town randomly selected for treatment. The outcomes of interest were total turnout (the number of votes cast at each polling booth) and female turnout (the number of votes cast by women at each polling booth). Data was also collected on the number of registered voters at each polling booth, disaggregated by gender, but for some polling booths this data could not be obtained, and so data entry operators entered “-999” whenever they were missing data. 

*Problems
*1.	Data cleaning. Make the dataset ready for use in analysis. This involves the following tasks: 

*a.	Import the data into Stata.
*b.	Create a polling booth ID variable. Let this ID be equal to 1 for the polling booth within each town that has the highest turnout, 2 for the polling booth within each town that has the second-highest turnout, and so on. 
*c.	Fix any values that have been flagged as missing so that they do not affect analysis.
*d.	Create a dummy variable for each value of Town ID. Name each variable as town_id_(x), where x is the actual town ID.
*e.	Add town names into the main dataset from the supplementary Excel file. Make sure that all towns are named and drop any irrelevant towns.
*f.	Label all variables as either “ID variable”, “Electoral data” or “Intervention”.
*g.	Label values for the treatment variable appropriately.

*2.	Presenting results for an academic audience. Your PI is going to present the results from the experiment at an academic conference, and needs you to prepare one of the tables. Create one table with results from the following two regressions:

*a.	Regress total turnout on treatment, with town fixed-effects. 
*b.	Regress total turnout on treatment, with town fixed-effects and controlling for the total number of registered voters at each polling station.

*Please output your results in Excel in the clearest form possible. It is not necessary to show the coefficients on the town fixed-effects. Include mean turnout from the control group at the bottom of your table as a reference and any notes you think are necessary to explain the regression specifications.

*3. Your PI is going to present the results from the experiment at a policy conference, and needs you to prepare one of the figures. Create one simple, clearly-labeled bar graph that shows the difference in female turnout between treatment and control polling booths. Please output your results in the clearest form possible. 


*PROGRAM SETUP



clear all

cd "/Users/bhargavithakur/Documents/Stata"


set more off
log using test_log.log, replace

*Question1(a) Import the data on STATA

import excel using "Data for Stata Test.xlsx", firstrow

*Question1(b): creating booth id variable

gsort town_id -turnout_total
by town_id: gen booth_id = _n
label var booth_id "ID variable"

*Question1(c): removing missing values 

foreach var of varlist registered_total registered_male registered_female  {
	gen `var'_clean = `var'
	replace `var'_clean = . if `var'_clean == -999
	label var `var'_clean "Electoral data"
}

*Question1(d): creating the dummy variable for each town_id 

levelsof town_id, local(levels) 
foreach lev of local levels {
	gen town_id_`lev' = 0 
	replace town_id_`lev' = 1 if town_id == `lev'	
}


save "master2.dta", replace
*Keeping track of the total observations in master file
count

*Question1(e): Introducing the supplementary excel file through merging the row names 
clear all
import excel using "Town Names for Stata Test.xlsx", firstrow
rename TownID town_id
rename TownName town_name
save "using2.dta", replace

clear all
use "master2.dta"

*Checking if there are any missing row variables when merging 
merge m:1 town_id using "using2.dta"
tab _merge
br if _merge == 2
drop if _merge == 2
drop _merge



*The count in merge matches the count in master fiile = 6,970 same as the master2 data file 

*Question 1(f): Labelling the variables 

global id_variables town_id booth_id town_id_171-town_id_239 town_name
global electoral_data turnout_total- registered_female registered_total_clean- registered_female_clean

foreach var of varlist $id_variables {
	label var `var' "ID variable"
}

foreach var of varlist $electoral_data {
	label var `var' "Electoral data"
}

label var treatment "Intervention"

*Question1(g): labelling the treatment variables 

label define treatment1 1 "Treatment" 0 "Control"
label values treatment treatment1

save "merged2.dta", replace

*Question2 : PRESENTING TO ACADEMIC AUDIENCE


*Question2(a) : Regress total turnout on treatment, with town fixed-effects. 



egen turnout_mean = mean(turnout_total), by(town_id)
egen treatment_mean = mean(treatment), by(town_id)
gen turnout_demean = turnout_total - turnout_mean
gen treatment_demean = treatment - treatment_mean

reg turnout_demean treatment_demean



ssc install outreg2
outreg2 using "/Users/bhargavithakur/Documents/Stata\bhargavi_regression_tables.xls", ctitle (total turnout) label excel replace


*Question 2 (b): Regress total turnout on treatment, with town fixed-effects and controlling for the total number of registered voters at each polling station.

reg turnout_total treatment i.town_id registered_total
outreg2 using "/Users/bhargavithakur/Documents/Stata\bhargavi_regression_tables1.xls", ctitle (total turnout) label excel replace

*Question 3: Create one simple, clearly-labeled bar graph that shows the difference in female turnout between treatment and control polling booths. Please output your results in the clearest form possible. 

graph bar (sum) turnout_female, over(treatment) ytitle(Average female turnout) title("Total Female Turnout between Treatment and Control Groups")



log close

save "merged2.dta", replace


. 















