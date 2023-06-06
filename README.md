# US Census Demographic Data
An attempt to identify insights into transportation, income and economic disparity (poverty rate) in the US by using the 2015 census tract data from acs2015_county_data.csv. 
Key is to understand state of play and overlay with correlative empirical assessment and additional research to illuminate on the issues at hand.

## 1. Project description
Generate insights from census tract data which covers factors related to transportation, income and poverty rate (disparity) along and across state lines and overlay with additional research on potentially differentiated insights based on urbanization.

## 2. Condition of dataset
* 37-field dataset at county level for:
  * Populations (total, gender, racial, employed). 
  * Income related (total and per capita).
  * Disparity(poverty and child poverty rates).
  * Transportation mode.
  * Unemployment rate.
  * Job types (professional, service, office etc).
* More details, see Appendix.

## 3. Tools used
* MySQL to facilitate enablement to:
  * Overlay information on urbanization conglomerations (MSAs) saved as metro_counties.csv on the original data (acs2015_county_data.csv). Revised dataset saved as us_census_data.csv.
  * Generate MSA level (if any) consolidation for population-related fields for total, gender and racial (columns include TotalPop, Men, Women, Hispanic, White, Black, Native, Asian	Pacific). Revised dataset saved as metro_adj.csv.

## 4. Generated insights
* Macro view on transportation followed drill downs into mode of transportation and commute time by state, metro areas and county.  
* Macro view on income per capita and poverty rate followed by downs into by state, metro areas and county.
* Map visualization to provide spatial insights into distribution of county-level incomes and disparities.

## 5. Limitations and blind spots:
* Lack of information on the ubanization status of counties, which needs to researched and overlaid on the original dataset.
* No furher drill down on the basis of race. Therefore this has not been explored. Owing to:
  * Complexities on linking race to socioeconomic status to further expand on poverty and income per capita.
  * Absence of objective metrics on socioeconomic status.
  * Desire to stay objective instead deferring to biases typified by popular consciousness. 
* No furher drill down on the basis of job types. Therefore this has not been explored. Reasons include:
  * Absence of objective metrics on socioeconomic status (per before).
  * Absense of Salary bands by job types. 
  * Desire to avoid guess work needed to gnostically link income sub-categories and socioecnomic status with job types.
  
## 6. Tableau visualization
https://public.tableau.com/app/profile/alan.kong2051/viz/USCensusDemographicData_16858286856570/Story

# Appendix: About the dataset
Copied from Kaggle https://www.kaggle.com/datasets/muonneutrino/us-census-demographic-data
## Context
This dataset expands on my earlier New York City Census Data dataset. It includes data from the entire country instead of just New York City. 
The expanded data will allow for much more interesting analyses and will also be much more useful at supporting other data sets.

## Content
The data here are taken from the DP03 and DP05 tables of the 2015 American Community Survey 5-year estimates. The full datasets and much more can be found at the American Factfinder website. Currently, I include two data files:
* acs2015_census_tract_data.csv: Data for each census tract in the US, including DC and Puerto Rico.
* acs2015_county_data.csv: Data for each county or county equivalent in the US, including DC and Puerto Rico.
The two files have the same structure, with just a small difference in the name of the id column. Counties are political subdivisions, and the boundaries of some have been set for centuries. Census tracts, however, are defined by the census bureau and will have a much more consistent size. A typical census tract has around 5000 or so residents. 
The Census Bureau updates the estimates approximately every year. At least some of the 2016 data is already available, so I will likely update this in the near future.

## Acknowledgements
The data here were collected by the US Census Bureau. As a product of the US federal government, this is not subject to copyright within the US.

## Inspiration
There are many questions that we could try to answer with the data here. Can we predict things such as the state (classification) or household income (regression)? What kinds of clusters can we find in the data? What other datasets can be improved by the addition of census data?
