library(tidyverse)

library(readxl)

read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X,col_names = FALSE))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

insert_header <- function(df, name_cols) {
  colnames(df) <- name_cols
  df
}

column_create <- function(df, input) {
  df %>% 
    mutate(new_col = input)
}

#I could probably use select, but I think it's more intuitive for me to 
column_delete <- function(df, indices) {
  df[,-indices]
}

column_reorder <- function(df, indices) {
  if (ncol(df) > length(indices)) {
    stop('Please enter more indices')
  }
  df[,indices]
}

shift_values <- function(df, from_col_indices, to_col_indices) {
  
  for (i in length(from_col_indices)) {
    
    empty_indices <- which(is.na(df[,to_col_indices[i]]))
    
    df[empty_indices, to_col_indices[i]] <- df[empty_indices, from_col_indices[i]]
  }
  
  df
}

vectorized_str_extract <- Vectorize(str_extract)

isolate_numbers <- function(df, index) {
  replacement_column <- as.data.frame(df[,index]) %>%
    transmute(new_col = vectorized_str_extract(.,'\\d+.*'))
  
  df[,index] <- replacement_column
  
  df
}

row_split_by_string <- function(df, row_num, pattern) {
  
  for (k in 1:length(row_num)) {
    obser <- df[row_num[k],]
    split_str_list <- str_split(obser, pattern = pattern, n = Inf)
    additional_rows <- matrix(character(0), nrow = length(split_str_list[[1]]), ncol = ncol(df))   
    
    for (i in 1:nrow(additional_rows)) {
      for(j in 1:length(split_str_list)) {
        additional_rows[i,j] <- split_str_list[[j]][i]
      }
    }
    colnames(additional_rows) <- colnames(df)
    df <- rbind(df, additional_rows)
  }
  
  df[-row_num,]
}

vectorized_str_split <- Vectorize(str_split)
vectorized_str_locate <- Vectorize(str_locate)


#Need to use a lookbehind for this probably
col_split_by_string <- function(df, col_num, pattern, is_last_two_chars = FALSE) {
  
  col_to_split <- df[,col_num]
  #indexes <- list()
  
  first_elements <- numeric(nrow(df))
  second_elements <- numeric(nrow(df))
  
  vibes <- vectorized_str_split(col_to_split, pattern)
  chill <- vectorized_str_extract(col_to_split, pattern)
  
  for(i in 1:nrow(df)) {
    
    if (length(vibes[[i]]) > 1) {
      #  print(chill[i])
      first_elements[i] <- vibes[[i]][1]
      if (is_last_two_chars) {
        second_elements[i] <- chill[i]
      } else {
        second_elements[i] <- vibes[[i]][-1]
      }
    } else {
      first_elements[i] <- NA
      second_elements[i] <- vibes[[i]][1]
    }
  }
  #print(indexes)
  cbind(df, first_elements, second_elements)#vibes
}

vectorized_str_replace <- Vectorize(str_replace)

school_assign_SGV <- function(standard_df) {
  
  school_names <- standard_df %>%
    filter(is.na(`Description`)) %>%
    select(9) %>%
    unlist(.)
  
  holder <- numeric(length(school_names))

  for(i in 1:length(school_names)) {
    holder[i] <- which(standard_df[,9] == school_names[i])
  }
  
  holder <- c(holder, nrow(standard_df))
  
  for(j in 1:(length(holder) - 1)) {
    
    if (j != (length(holder) - 1)) {
      row_index_fill_in <- seq(holder[j], (holder[j + 1] - 1), by = 1)
    } else {
      row_index_fill_in <- seq(holder[j], holder[j + 1], by = 1)
    }
    standard_df[row_index_fill_in, 9] <- school_names[j]
  }
  
  standard_df
}


vectorized_str_replace <- Vectorize(str_replace)

match_m_1 <- c('2', 'Z')
match_m_2 <- c('0', 'O')
match_m_3 <- c('O', 'O')
match_m_4 <- c('6', 'B')
match_m_5 <- c('8', 'B')
match_m_6 <- c('AL', 'GL')
match_m_7 <- c('\\bZ.\\b', 'OZ')
match_m_8 <- c('S', 'B')
match_m_9 <- c(',','.')

replacement_dictionary_measure <- data.frame(
  match_m_1,
  match_m_2,
  match_m_3,
  match_m_4,
  match_m_5,
  match_m_6,
  match_m_7,
  match_m_8,
  match_m_9
)

match_n_1 <- c('D', '0')
match_n_2 <- c('S', '5')
match_n_3 <- c('Z', '2')
match_n_4 <- c('O', '0')

replacement_dictionary_numbers <- data.frame(
  match_n_1,
  match_n_2,
  match_n_3,
  match_n_4,
  match_m_9 #this is from the measure section
)

match_b_1 <- c('\\$', 'S')
replacement_dictionary_brands <- data.frame(
  match_b_1
)
letter_corrector <- function(df, col_index, type) {
  if (type == 'measure') {
    for(i in 1:length(replacement_dictionary_measure)) {
      df[,col_index] <- str_replace_all(df[,col_index], 
                                    replacement_dictionary_measure[1,i], 
                                    replacement_dictionary_measure[2,i])
    }
  }
  
  if (type == 'numbers') {
    for(i in 1:length(replacement_dictionary_numbers)) {
      df[,col_index] <- str_replace_all(df[,col_index], 
                                    replacement_dictionary_numbers[1,i], 
                                    replacement_dictionary_numbers[2,i])
    }
  }
  if (type == 'brands') {
    for(i in 1:length(replacement_dictionary_brands)) {
      df[,col_index] <- str_replace_all(df[,col_index], 
                                    replacement_dictionary_brands[1,i], 
                                    replacement_dictionary_brands[2,i])
    }
  }
  
  df
}

SGV_19_20 <- read_excel("SGV_300025 - District Usage by Item San Gabe Coop 2019-2020.xlsx")
SGV_20_21 <- read_excel("SGV_300025 - District Usage by Item San Gabe Coop 2020-2021.xlsx")
SGV_21_22 <- read_excel("SGV_300025 - District Usage by Item San Gabe Coop 2021-2022.xlsx")
SGV_22_23 <- read_excel("SGV_300025 - District Usage by Item San Gabe Coop 2022-2023.xlsx")


split_header <- c('Size of Pack', 'Size Of Unit', 'UOM')
standard_header <- c('Manufacturing Number', 'Manufacturer', 'Description', 'Quantity', 'Pack Size', 'Price')
FINAL_HEADER <- c('Manufacturing Number', 'Manufacturer', 'Description', 'Quantity', 'Pack Size,', 'Size of Pack', 'Size of Unit', 'Price', 'School', 'Year')

SGV_19_rel_cols <- SGV_19_20[-c(1,2),] %>% 
  column_delete(c(5,7, 9,11)) %>%
  col_split_by_string(6, '/') %>%
  col_split_by_string(10, '(..$)', is_last_two_chars = TRUE) %>%
  column_reorder(c(3, 5, 4, 7, 9, 11, 12, 8, 1, 2, 6, 10)) %>%
  column_delete(c(10, 11, 12)) %>%
  insert_header(c(standard_header, split_header)) %>%
  school_assign_SGV(.) %>%
  column_create(2019) %>% 
  insert_header(FINAL_HEADER) %>%
  filter(!is.na(`Description`)) %>%
  letter_corrector(7, type = 'measure')

SGV_20_rel_cols <- SGV_20_21[-c(1,2),] %>% 
  column_delete(c(5,7, 9,11)) %>%
  col_split_by_string(6, '/') %>%
  col_split_by_string(10, '(..$)', is_last_two_chars = TRUE) %>%
  column_reorder(c(3, 5, 4, 7, 9, 11, 12, 8, 1, 2, 6, 10)) %>%
  column_delete(c(10, 11, 12)) %>%
  insert_header(c(standard_header, split_header)) %>%
  school_assign_SGV(.) %>%
  column_create(2020) %>%
  insert_header(FINAL_HEADER) %>%
  filter(!is.na(`Description`)) %>%
  letter_corrector(7, type = 'measure')

SGV_21_rel_cols <- SGV_21_22[-c(1,2),] %>% 
  column_delete(c(5,7, 9,11)) %>%
  col_split_by_string(6, '/') %>%
  col_split_by_string(10, '(..$)', is_last_two_chars = TRUE) %>%
  column_reorder(c(3, 5, 4, 7, 9, 11, 12, 8, 1, 2, 6, 10)) %>%
  column_delete(c(10, 11, 12)) %>%
  insert_header(c(standard_header, split_header)) %>%
  school_assign_SGV(.) %>%
  column_create(2021) %>%
  insert_header(FINAL_HEADER) %>%
  filter(!is.na(`Description`)) %>%
  letter_corrector(7, type = 'measure')

SGV_22_rel_cols <- SGV_22_23[-c(1,2),] %>% 
  column_delete(c(5,7, 9,11)) %>%
  col_split_by_string(6, '/') %>%
  col_split_by_string(10, '(..$)', is_last_two_chars = TRUE) %>%
  column_reorder(c(3, 5, 4, 7, 9, 11, 12, 8, 1, 2, 6, 10)) %>%
  column_delete(c(10, 11, 12)) %>%
  insert_header(c(standard_header, split_header)) %>%
  school_assign_SGV(.) %>%
  column_create(2022) %>%
  insert_header(FINAL_HEADER) %>%
  filter(!is.na(`Description`)) %>%
  letter_corrector(7, type = 'measure')

big_SGV <- rbind(SGV_19_rel_cols, SGV_20_rel_cols, SGV_21_rel_cols, SGV_22_rel_cols)

mod_big_SGV <- big_SGV %>%
  filter(`Manufacturer` != 'Brand')

write.csv(mod_big_SGV, file = 'SGV_CLEAN_19-23_new.csv')

View(test)

View(SGV_20_rel_cols)
View(SGV_19_rel_cols)
View(SGV_19_20)












