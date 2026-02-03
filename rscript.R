# Setting up the packages  
if (!require("pacman")) {install.packages("pacman")}
pacman::p_load(tidyverse,
               skimr,
               lubridate,
               gridExtra) 

data <- read.csv("covid_full_data.csv")

# Data Exploration and Contextualization
str(data) # inspecting structure of the dataset 
n_distinct(data$location) # # counts the total number of unique countries or territories in the dataset
range(as.Date(data$date)) # displays the earliest and latest dates of observations
skim(data) # checking for variable types, means, standard deviations, and missing values

# Data Processing and Functional Programming
## Data Wrangling: Recoding and adding new variables
data <- data %>%
  mutate(date = as.Date(date),
         year = year(date))

## Data Wrangling: Top 20 Locations with Highest Case Counts
top_cases <- data %>%
  group_by(location) %>%
  summarise(total_cases = sum(new_cases, na.rm = TRUE)) %>%
  arrange(desc(total_cases)) # arrange from highest to least number of cases 

head(top_cases, 20)

## Wrangling Function: Total Cases and Deaths for Selected Country 
summarise_totals <- function(data, country_name) {
  data %>%
    filter(location == country_name) %>%
    group_by(year) %>%
    summarise(annual_cases = sum(new_cases, na.rm = TRUE),
              annual_deaths = sum(new_deaths, na.rm = TRUE))
}

summarise_totals(data, "High-income countries")
summarise_totals(data, "Lower-middle-income countries")

# Data Visualization
## Function: Daily New Cases for Selected Country 
plot_country_cases <- function(data, country_name) {
  data %>% 
    filter(location == country_name) %>%
    ggplot(aes(x = date, y = new_cases)) + 
    geom_line(color = "red") + 
    labs(title = country_name, 
         # paste() allows the variable country_name to be included in the string 
         x = "",
         y = "Daily New COVID-19 Cases") +  
    theme_minimal()
}

## Data Visualization 1: Daily New Cases in High-income vs Lower-middle income countries 
higher_income <- plot_country_cases(data, "High-income countries")
lower_income <- plot_country_cases(data, "Lower-middle-income countries")
grid.arrange(higher_income, lower_income, ncol = 2)


## Data Visualization 2: Total Cases in China, France, India and United States 
country_cases <- data %>%
  filter(location %in% c("United States","China","India", "France")) %>%
  group_by(location) %>%
  summarise(total_cases = sum(new_cases, na.rm = TRUE)) 

ggplot(country_cases, aes(x = location, y = total_cases))+
  geom_col(position = "dodge") +
  labs(x = "", 
       y = "Total COVID-19 Cases") +
  theme_minimal()


## Data Visualization 3: Total Cases Per Million People in China, France, India, and the United States
# Input population values
population_lookup <- tibble(location = c("United States","China","India","France"),
                            population = c(340100000,1409000000,1451000000, 68520000))

# Compute total cases per country
pop_adjusted <- data %>%
  group_by(location) %>%
  summarise(total_cases = sum(new_cases, na.rm = TRUE)) %>%
  inner_join(population_lookup, by = "location") %>%
  mutate(cases_per_million = (total_cases / population) * 1e6)

ggplot(pop_adjusted, aes(x = location, y = cases_per_million)) +
  geom_col(position = "dodge") +
  labs(x = "",
       y = "Total COVID-19 Cases per Million People") +
  theme_minimal()
  
  