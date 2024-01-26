####################################################################
##### Load and Clean Goldstar Data


##########################
## Choose Directory

rm(list = ls())
setwd("C:/Users/Martin Hackmann/Documents/GitHub/obesitydata/LA/Goldstar") 


##################################################################
############################  21/22

### a) San gabriel Valley

data=read.csv("raw_data/SGV_300025 - District Usage by Item San Gabe Coop 2021-2022.csv")

#### TODOS: drop first two rows, convert third row into columns names, create new column with school district, drop school district row, year column, save 


##################################################################
############################  22/23


### Pomona

#### start with 1 drop prices and create variable fee-for-service to capture differences between (purple) columns (follow up with question on differences by drops and fee-for-service)


############################################################
###### 23/24


#### Pinco


#### quantity missing, hence set to missing value ""
