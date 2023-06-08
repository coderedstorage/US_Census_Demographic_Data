CREATE OR REPLACE VIEW us_census.metro_adj AS 
WITH relevant_sates AS
(SELECT distinct state FROM us_census.metro) 
SELECT 
    usc.state,
    
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
    
    SUM(TotalPop) metro_county_Pop

FROM us_census.kaggle_data usc
LEFT JOIN us_census.metro mtr
ON usc.state = mtr.state AND usc.county = mtr.county
GROUP BY 1, 2, 3, 4;