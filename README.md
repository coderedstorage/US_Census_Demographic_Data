WIP - don't use it yet

# DA105.3 Build a Data Visualization Project (Udacity)

# Chosen Metadata: US Demographic data

## 1. Project description
Generate insights from census tract data which covers factors related to transportation, income and poverty rate (disparity) along and across state lines. 

## 2. Submission
PDF of this markdown document.

## 3. Insights and rationale for design choice of visualizations 
### Insight 1:
  * Summary: Overall counties exhibit inversely proportional relationship between incomes per capita with povery rates. Convex-to-concave nature of the Power trendline to characterize the distributions of the two factors (income and poverty) indicate a complex system is at play. This often the feature in politics and socio-economic factors.
  * Why scatter chart? To aptly capture required high-res analysis for study, with minimal bias from consolidation incl. true ranges and distributions of counties across income/disparity frontier. It also illuminates outsized influence certain counties (e.g. SF/NY) have on their states or metro systems. Overlaying with categorical colours for regions and metropolitan affiliation indicates unexpected insight into a favourable drift of those counties above trend line. 
### Insight 2:
  * Summary: TBD.
  * Why XX chart? TBD. 
### Insight 3:
  * Summary: TBD.
  * Why XX chart? TBD.

## 4. Resources: 
* Dashboard (Tableau Story) https://public.tableau.com/app/profile/alan.kong2051/viz/USCensusDemographicData_16858286856570/Story
* Github https://github.com/coderedstorage/US_Census_Demographic_Data
  * acs2015-county-data.csv (original data obtained from https://www.kaggle.com/muonneutrino/us-census-demographic-data/data)
  * US Census Demographic Data.twbx (Tableau Workbook)
  * metro_adj.csv (calculation of of populations at metro area level). Generated from MySQL as a view called 'metro_adj'.
  * metro_counties.csv (State, County, Metropolitan and MSA mapping). Imported into MySQL as a Table called 'metro'
  * state_code.csv (state codes and state regions/divisions used by US Census bureau) 

# Tools used
* MySQL to facilitate enablement to overlay external information on original data (acs2015_county_data.csv) to generate final dataset (us_census_data.csv):
  * Overlay urbanization conglomeration (MSAs) information from metro_counties.csv. 
  * Overlay state codes from state_code.csv.
* MySQL to facilitate enablement to overlay information on original data (acs2015_county_data.csv) to generate calculation of metro area level populations as metro_adj.csv:
  * Overlay urbanization conglomeration (MSAs) information from metro_counties.csv. 
* MySQL to overlay metro area level populations (metro_adj.csv) on original data (acs2015_county_data.csv) to generate final dataset (us_census_data.csv).
* Tableau Public to create visualization (requires final dataset us_census_data.csv to be commited to Tableau Public).

# Condition of dataset
* 37-field dataset at county level for:
  * Populations (total, gender, racial, employed). 
  * Income related (total and per capita).
  * Disparity(poverty and child poverty rates).
  * Transportation mode.
  * Unemployment rate.
  * Job types (professional, service, office etc).
* More details, see Appendix.

# Appendix: About the dataset
Below is copied from https://www.kaggle.com/datasets/muonneutrino/us-census-demographic-data.
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
