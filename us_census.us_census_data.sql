CREATE OR REPLACE VIEW us_census.us_census_data AS 
WITH relevant_sates AS
(SELECT distinct state FROM us_census.metro) 
SELECT 
    usc.*, 
    CASE 
    WHEN mtr.metropolitan IS NOT NULL
    THEN mtr.metropolitan
    ELSE usc.county
    END metropolitan_or_county,
  
      CASE 
    WHEN mtr.top_10_msa_name IS NOT NULL
    THEN mtr.top_10_msa_name
    ELSE "other counties"
    END top_10_msa,
  
      CASE 
    WHEN mtr.metropolitan IS NOT NULL
    THEN 'True'
    ELSE 'False'
    END top_10_metro
    
FROM us_census.kaggle_data usc
LEFT JOIN us_census.metro mtr
ON usc.state = mtr.state AND usc.county = mtr.county