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

#shark tsv

townsville_shark_data <- subset(shark_cleaned, Area == "Townsville" & SpeciesGroup == "Shark")

shark_catch_per_year <- aggregate(NumberCaught.Total ~ CalendarYear, data = townsville_shark_data, FUN = sum)

barplot(shark_catch_per_year$NumberCaught.Total, names.arg = shark_catch_per_year$CalendarYear,
        xlab = "Year", ylab = "Number of Sharks Caught", col = "blue",
        main = "Shark Catch in Townsville Per Year",
        ylim = c(0, 200),   
        las = 2,             
        yaxt = "n")         

axis(2, at = seq(0, 200, by = 20))



#turtle tsv

townsville_turtle_data <- subset(shark_cleaned, Area == "Townsville" & SpeciesGroup == "Turtle")

turtle_catch_per_year <- aggregate(NumberCaught.Total ~ CalendarYear, data = townsville_turtle_data, FUN = sum)

barplot(turtle_catch_per_year$NumberCaught.Total, names.arg = turtle_catch_per_year$CalendarYear,
        xlab = "Year", ylab = "Number of Turtles Caught", col = "green",
        main = "Turtle Catch in Townsville Per Year",
        las = 2)




townsville_total_catch <- aggregate(NumberCaught.Total ~ CalendarYear, data = shark_cleaned[shark_cleaned$Area == "Townsville", ], sum)

# Plot the total catch data
barplot(townsville_total_catch$NumberCaught.Total, names.arg = townsville_total_catch$CalendarYear,
        xlab = "Year", ylab = "Total Number of Catch", col = "skyblue",
        main = "Total Catch in Townsville by Year",
        las = 2)

# Calculate total catch for each year across all areas
total_catch_by_year <- aggregate(NumberCaught.Total ~ CalendarYear, data = shark_cleaned, sum)

# Plot the total catch data
barplot(total_catch_by_year$NumberCaught.Total, names.arg = total_catch_by_year$CalendarYear,
        xlab = "Year", ylab = "Total Number of Catch", col = "blue",
        main = "Total Catch Across All Areas by Year")


# Plot using ggplot
ggplot() +
  geom_bar(data = total_data, aes(x = CalendarYear, y = NumberCaught, fill = "Total"), position = "dodge", width = 0.8) +
  geom_bar(data = townsville_data, aes(x = CalendarYear, y = NumberCaught, fill = "Townsville"), position = "dodge", width = 0.8) +
  labs(x = "Year", y = "Total Number of Catch",
       title = "Total Catch by Area and Year") +
  scale_fill_manual(values = c("Total" = "blue", "Townsville" = "red")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels


# Calculate total catch by year
total_data <- shark_cleaned %>%
  group_by(CalendarYear) %>%
  summarise(TotalCaught = sum(NumberCaught.Total))

# Calculate Townsville catch by year
townsville_data <- shark_cleaned %>%
  filter(Area == "Townsville") %>%
  group_by(CalendarYear) %>%
  summarise(TownsvilleCaught = sum(NumberCaught.Total))

# Merge the two datasets
combined_data <- merge(total_data, townsville_data, by = "CalendarYear", all.x = TRUE)

# Plot using ggplot
ggplot(combined_data, aes(x = factor(CalendarYear), y = TotalCaught)) +
  geom_col(aes(fill = "Total"), position = "dodge", width = 0.8) +
  geom_col(aes(y = TownsvilleCaught, fill = "Townsville"), position = "dodge", width = 0.8) +
  labs(x = "Year", y = "Total Number of Catch",
       title = "Total Catch by Area and Year") +
  scale_fill_manual(values = c("Total" = "skyblue", "Townsville" = "green")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotate x-axis labels



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






