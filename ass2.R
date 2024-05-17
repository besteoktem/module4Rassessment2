#### Module 4 - Assessment 2 ####
#beste oktem MB5370
#17.05.2024

library("tidyverse")
file_path <- "C:/Users/beste/OneDrive/Masaüstü/shark.csv"
data <- read.csv(file_path, header = TRUE, sep = ",", quote = "\"")
summary(data)

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






