*********************************************************************************************************
***** Load Goldstar Data


cd "C:\Users\Martin Hackmann\Documents\GitHub\obesitydata\LA\Goldstar\code"


log using datapprep.log, replace


****************************************************************
*************************** 21/22

*** a) San gabriel Valley

insheet using "..\raw_data\SGV_300025 - District Usage by Item San Gabe Coop 2021-2022.csv"

*** TODOS: drop first two rows, convert third row into columns names, create new column with school district, drop school district row, year column, save 







