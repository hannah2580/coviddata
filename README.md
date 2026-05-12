# Project Title
  COVID-19 Cases and Deaths across locations (2020-2024)

# Project Description
This project uses the COVID-19 Cases and Deaths Database to examine how COVID-19 deaths and cases vary across 246 countries and territories between January 2020 to August 2024.
Using R for data wrangling and visualizations, the project reveals global and regional patterns in infections and mortality.  

# Getting Started
## Required Libraries
The following R packages must be installed:
  tidyverse
  skimr
  lubridate
  gridExtra
  
## Files in this report   
  covid_full_data.csv: Dataset used in this report
  rscript.R: RScript with all the code used 
  Quarto_report.qmd: Main Quarto Document containing written report and code
  Quarto_Report.html: Rendered HTML version of the Quarto Report 

# Variables used in this report
    "location": Country or region name
    "date": Date of observation 
    "new_cases": Daily COVID-19 cases
    "new_deaths": Daily COVID-19 deaths
    "total_cases": Cumulative total of cases
    "total_deaths": Cumulative total of deaths

# How to Run the Code
  Open rscript.R and run the code
