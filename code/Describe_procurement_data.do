****************************************
*** This is a first exploratory attempt in describing food procurement data
*** We start with data from cypress_fairbanks
****************************************

clear
clear matrix
set more off 
set mem 30g
set matsize 2000
set rmsg on

cd "C:\Users\Martin Hackmann\Documents\GitHub\obesitydata"

*** open log file 


capture log close
log using "logs\descriptivess_cypressfairbanks.log", replace


*** load csv data

insheet using "data_temp/cypress_fairbanks_temp.csv"


*** year of procurement
gen year=substr(doc_date_scaled,-4,.)
destring year, replace force

*** product if if available

gen productid=substr(bid_name_scaled,1,5)
destring productid, replace force

*** GOAL: construct time series by products (several products have missing ids)

*** 1) I would start by codes that have a product if and then search over text similarity among codes that have high similarity and assign the code
*** 2) then try to impute the product if for current missings based on text similarity.
**** for example: we have "55620 Tomato, Sauce, Canned" and also "Tomato, Sauce, Canned - Domestic"
**** we probably want to assign the firt 4 digits and maybe also the last 5 if they have the same quantity. If not, then we assign a letter, say X?




*** construct 5 digit, 4 digit, and 3 digit product codes






*** close log file 

log close 
clear

