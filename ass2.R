#### Module 4 - Assessment 2 ####
#beste oktem MB5370
#17.05.2024

library("tidyverse")
library(dplyr)
file_path <- "C:/Users/beste/OneDrive/Masaüstü/shark.csv"
shark <- read.csv(file_path)

rows_with_total <- apply(shark, 1, function(row) any(grepl("total", row, ignore.case = TRUE)))

shark_cleaned <- shark[!rows_with_total, ]

print(shark_cleaned)


# Filter data for Townsville and Shark catches
townsville_shark_data <- subset(shark_cleaned, Area == "Townsville" & SpeciesGroup == "Shark")

# Group data by CalendarYear and calculate total number of sharks caught each year
shark_catch_per_year <- aggregate(NumberCaught.Total ~ CalendarYear, data = townsville_shark_data, FUN = sum)

barplot(shark_catch_per_year$NumberCaught.Total, names.arg = shark_catch_per_year$CalendarYear,
        xlab = "Year", ylab = "Number of Sharks Caught", col = "blue",
        main = "Shark Catch in Townsville Per Year",
        ylim = c(0, 200),   
        las = 2,             
        yaxt = "n")         

axis(2, at = seq(0, 200, by = 20))

















#### we tried this with first download then realised we could change rows and collumns before downloading so this part is not needed anymore ####

# Make first cell  Area
data$X[1] = "Area"

# Move first row to variable names
colnames(data) <- data[1,]

data <- 
  data[-1,]

glimpse(data)
  

data |>
  select(!contains("NA"))



#this is my trying part
data |> 
  pivot_longer(
    cols = col_number(1), 
    names_to = "year", 
    values_to = "number caught"
  )


# Rename the first column to 'year'
colnames(data)[1] <- "year"

# reshape the data
long_data <- data %>%
  pivot_longer(cols = -year, names_to = "variable", values_to = "value")

print(long_data)






