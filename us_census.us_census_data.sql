CREATE OR REPLACE VIEW us_census.us_census_data AS 
WITH relevant_sates AS
(SELECT distinct state FROM us_census.metro),
US_avg_IncomePerCap AS
(SELECT SUM(TotalPop*IncomePerCap)/SUM(TotalPop) FROM us_census.kaggle_data),
state_has_metro AS
(SELECT DISTINCT state FROM us_census.metro)

SELECT 
    usc.*, 
    
        CASE 
    WHEN mtr.metropolitan IS NOT NULL
    THEN mtr.metropolitan
    ELSE usc.county
    END metro_or_county,
    
	CASE 
    WHEN mtr.major_msa IS NOT NULL
    THEN mtr.major_msa
    ELSE "other counties"
    END major_msa,

	CASE 
    WHEN mtr.metropolitan IS NOT NULL
    THEN 'Y'
    ELSE 'N'
    END is_major_metro,

      CASE 
    WHEN usc.IncomePerCap >= 60000 THEN "$60K+"
    WHEN usc.IncomePerCap >= 50000 THEN "$50K-$60K"
    WHEN usc.IncomePerCap >= 40000 THEN "$40K-$50K"
    WHEN usc.IncomePerCap >= 30000 THEN "$30K-$40K"
    WHEN usc.IncomePerCap >= (SELECT * FROM US_avg_IncomePerCap) THEN "Avg-$30K"
    ELSE "Below avg" END income_band_county,
    
    CASE WHEN 
    (SELECT smtr.state FROM state_has_metro smtr WHERE smtr.state = usc.state)
    IS NULL THEN 'N'
    ELSE 'Y' END state_has_metro

FROM us_census.kaggle_data usc
LEFT JOIN us_census.metro mtr
ON usc.state = mtr.state AND usc.county = mtr.county