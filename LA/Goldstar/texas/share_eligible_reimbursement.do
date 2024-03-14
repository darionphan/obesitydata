*****************************************************************
**** Load data


cd "C:\Users\Martin Hackmann\Documents\GitHub\obesitydata\LA\Goldstar\texas"


insheet using School_Nutrition_Programs___Meal_Reimbursement_Information___Program_Year_2018-2019_20240314.csv, clear


gen total_perbreak=totalreimbursement/breakfasttotal

gen share_subsidized=(breakfastservedfree+breakfastservedredc)/breakfasttotal


reg total_perbreak  breakfasttotal  share_subsidized


collapse (sum)  breakfastservedfree breakfastservedredc breakfasttotal totalreimbursement breakfastreimbursement lunchservedfree lunchservedredc lunchtotal lunchreimbursement , by(sitename)


gen share_subsidized_break=(breakfastservedfree+breakfastservedredc)/breakfasttotal
gen share_subsidized_lunch=(lunchservedfree+lunchservedredc)/lunchtotal


gen total_perbreak=totalreimbursement/breakfasttotal
gen breakfastreimb_perbreak=breakfastreimbursement/breakfasttotal
gen lunchreimb_perlunch=lunchreimbursement/lunchtotal

gen round_share_subsidized_break=round(share_subsidized_break,0.01)
gen round_share_subsidized_lunch=round(share_subsidized_lunch,0.01)


*drop if total_perbreak>20

*collapse (mean) total_perbreak breakfastreimb_perbreak lunchreimb_perlunch, by(round_share_subsidized_break )

*twoway (scatter breakfastreimb_perbreak round_share_subsidized_break) (lpoly breakfastreimb_perbreak round_share_subsidized_break)

collapse (mean) total_perbreak breakfastreimb_perbreak lunchreimb_perlunch, by(round_share_subsidized_lunch )

twoway (scatter lunchreimb_perlunch round_share_subsidized_lunch) (lpoly lunchreimb_perlunch round_share_subsidized_lunch)
