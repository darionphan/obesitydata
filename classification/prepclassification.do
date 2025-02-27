*** Clean Food classification data
*** Source file: Statistical Appendices in  School Food Purchase Study III https://www.fns.usda.gov/research/cn/school-food-purchase-study-iii 



**** choose directory 


cd "C:/Users/mbhac/OneDrive/Documents/GitHub/obesitydata/classification"

*** 
clear
clear matrix
set more off 
set mem 30g

*** load digitized data

import delimited "class_csv.txt", clear


*** remove empty text prio to description

generate foodgroups_clean = trim(foodgroups)
generate foodsubgroups_clean = trim(foodsubgroups)

drop foodgroups foodsubgroups

rename foodgroups_clean foodgroups
rename foodsubgroups_clean foodsubgroups
rename individual description


export delimited using "classification_studyIII.csv", replace