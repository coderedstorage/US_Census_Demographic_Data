CREATE OR REPLACE VIEW us_census.metro_adj AS 
WITH relevant_sates AS
(SELECT distinct state FROM us_census.metro) 
SELECT 
    usc.state,
    
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
    END top_10_metro,
    
    SUM(TotalPop) TotalPop, 
    SUM(Men) Men, 
    SUM(Women) Women,
    SUM(Hispanic*TotalPop)/sum(TotalPop)*100 Hispanic,
    SUM(White*TotalPop)/sum(TotalPop)*100 White,
    SUM(Black*TotalPop)/sum(TotalPop)*100 Black,
    SUM(Native*TotalPop)/sum(TotalPop)*100 Native,
    SUM(Asian*TotalPop)/sum(TotalPop)*100 Asian,
    SUM(Pacific*TotalPop)/sum(TotalPop)*100 Pacific

FROM us_census.kaggle_data usc
LEFT JOIN us_census.metro mtr
ON usc.state = mtr.state AND usc.county = mtr.county
GROUP BY 1, 2, 3, 4;