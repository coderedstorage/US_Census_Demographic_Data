CREATE OR REPLACE VIEW us_census.metro_adj AS
SELECT 
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
GROUP BY 1, 2, 3;