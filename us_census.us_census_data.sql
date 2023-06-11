CREATE OR REPLACE VIEW us_census.us_census_data AS 

WITH metro_pop AS
(SELECT 
    usc.state,
    mtr.metropolitan,
    mtr.major_msa,
    SUM(TotalPop) metro_Pop,
    CASE WHEN SUM(TotalPop) >= 200000 
    THEN 'Y' 
    ELSE 'N'
    END metro_above_200K_midsize_or_larger
FROM us_census.kaggle_data usc
LEFT JOIN us_census.metro mtr
ON usc.state = mtr.state AND usc.county = mtr.county
WHERE mtr.major_msa IS NOT NULL
GROUP BY 1, 2, 3),

state_has_metro AS
(SELECT DISTINCT state FROM us_census.metro),

US_avg_IncomePerCap AS
(SELECT SUM(TotalPop*IncomePerCap)/SUM(TotalPop) FROM us_census.kaggle_data)

SELECT 
    usc.*,
    scd.state_code,
    scd.region,
    scd.division,
    scd.incorporated_territory,
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
    ELSE 'Y' END state_has_metro,
    
	CASE 
    WHEN mtr.metropolitan IS NOT NULL
    THEN mtp.metro_pop
    ELSE usc.TotalPop
    END cons_metro_county_pop,
    
	CASE 
    WHEN mtr.metropolitan IS NOT NULL
    THEN mtp.metro_above_200K_midsize_or_larger
    ELSE "other counties"
    END metro_above_200K_midsize_or_larger

FROM us_census.kaggle_data usc
LEFT JOIN us_census.metro mtr
ON TRIM(usc.state) = TRIM(mtr.state) AND TRIM(usc.county) = TRIM(mtr.county)
LEFT JOIN metro_pop mtp
ON TRIM(mtr.state) = TRIM(mtp.state) AND mtr.metropolitan = mtp.metropolitan
LEFT JOIN us_census.state_code scd
ON TRIM(usc.state) = TRIM(scd.state)