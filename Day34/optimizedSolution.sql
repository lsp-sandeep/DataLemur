-- Rank the drugs based on units sold for each manufacturer
WITH RANKED AS (
  SELECT
    manufacturer,
    drug,
    ROW_NUMBER() OVER(
      PARTITION BY manufacturer
      ORDER BY units_sold DESC
    ) AS drug_rank
  FROM pharmacy_sales
)
-- Filter the top 2 drugs for each manufacturer
SELECT
    manufacturer,
    drug AS top_drugs
FROM RANKED
WHERE drug_rank BETWEEN 1 AND 2
ORDER BY manufacturer, drug_rank
;