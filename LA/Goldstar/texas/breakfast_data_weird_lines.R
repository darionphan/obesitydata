#Every dataset from 2015-2016 ran

library(tidyverse)

snp_texas_15_16 <- read_csv("School_Nutrition_Programs___Meal_Reimbursement_Information___Program_Year_2015-2016_20240314.csv")
snp_texas_16_17 <- read_csv("School_Nutrition_Programs___Meal_Reimbursement_Information___Program_Year_2016-2017_20240314.csv")
snp_texas_17_18 <- read_csv("School_Nutrition_Programs___Meal_Reimbursement_Information___Program_Year_2017-2018_20240314.csv")
snp_texas_18_19 <- read_csv("School_Nutrition_Programs___Meal_Reimbursement_Information___Program_Year_2018-2019_20240314.csv")
snp_texas_19_20 <- read_csv("School_Nutrition_Programs_-_Meal_Reimbursement_Information_-_Program_Year_2019-2020_20240314.csv")
snp_texas_20_21 <- read_csv("School_Nutrition_Programs_-_Meal_Reimbursement_Information_-_Program_Year_2020-2021_20240314.csv")
snp_texas_21_22 <- read_csv("School_Nutrition_Programs_-_Meal_Reimbursement_Information_-_Program_Year_2021-2022_20240314.csv")
snp_texas_22_23 <- read_csv("School_Nutrition_Programs_-_Meal_Reimbursement_Information_-_Program_Year_2022-2023_20240314.csv")
snp_texas_23_24 <- read_csv("School_Nutrition_Programs_-_Meal_Reimbursement_Information_-_Program_Year_2023-2024_20240314.csv")


#breakfast code

par(mfrow = c(2,4))

#Groups by site name
#For this site, sum up every Free Breakfast Served and every Reduced Breakfast Served
#Calculate the reimbursement rate per breakfast by dividing the total amount of reimbursement by the total number of breakfasts served

breakfast_share_reim_15_16 <- snp_texas_15_16 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedReduced) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

#Plots the Share of Free or Reduced Priced Meals v.s. the Reimbursement per Breakfast
plot(unlist(breakfast_share_reim_15_16[,2]), unlist(breakfast_share_reim_15_16[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2015-2016',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

breakfast_share_reim_16_17 <- snp_texas_16_17 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedReduced) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_16_17[,2]), unlist(breakfast_share_reim_16_17[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2016-2017',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

breakfast_share_reim_17_18 <- snp_texas_17_18 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedReduced) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_17_18[,2]), unlist(breakfast_share_reim_17_18[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2017-2018',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

breakfast_share_reim_18_19 <- snp_texas_18_19 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedRedc) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_18_19[,2]), unlist(breakfast_share_reim_18_19[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2018-2019',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

breakfast_share_reim_19_20 <- snp_texas_19_20 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedRedc) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_19_20[,2]), unlist(breakfast_share_reim_19_20[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2019-2020',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))


breakfast_share_reim_20_21 <- snp_texas_20_21 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedRedc) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_20_21[,2]), unlist(breakfast_share_reim_20_21[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2020-2021',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))
breakfast_share_reim_21_22 <- snp_texas_21_22 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedRedc) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_21_22[,2]), unlist(breakfast_share_reim_21_22[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2021-2022',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

breakfast_share_reim_22_23 <- snp_texas_22_23 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedRedc) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_22_23[,2]), unlist(breakfast_share_reim_22_23[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2022-2023',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

breakfast_share_reim_23_24 <- snp_texas_23_24 %>%
  group_by(`SiteName`) %>%
  summarize(share = sum(BreakfastServedFree, BreakfastServedRedc) / (sum(BreakfastTotal)),
            reimburement_per_breakfast = sum(BreakfastReimbursement) / sum(BreakfastTotal))

plot(unlist(breakfast_share_reim_23_24[,2]), unlist(breakfast_share_reim_23_24[,3]),
     main = 'Share of FRPM and Reimbursement per Breakfast SY 2023-2024',
     xlab = 'Share of FRPM',
     ylab = 'Reimbursement per Breakfast',
     xlim = c(0, 1),
     ylim = c(0, 3.5))

View(snp_texas_23_24 %>%
  filter(`SiteName` == 'ACADEMY OF CREATIVE ED'))
View(breakfast_share_reim_23_24)
#Trying to figure this out, create an indicator as to why 

breakfast_share_reim_15_16 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_16_17 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_17_18 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_18_19 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_19_20 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_20_21 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_21_22 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_22_23 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')
breakfast_share_reim_23_24 %>%
  filter(`SiteName` == 'CAYUGA MIDDLE SCHOOL')

breakfast_share_reim_15_16 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_16_17 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_17_18 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_18_19 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_19_20 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_20_21 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_21_22 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_22_23 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
breakfast_share_reim_23_24 %>%
  filter(`SiteName` == 'CAST STEM HIGH SCHOOL')
