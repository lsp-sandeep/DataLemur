-- Calculate the loss as cogs - total_sales
SELECT
  manufacturer,
  COUNT(drug) AS drug_count,
  SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
-- Filter for the drugs with losses
WHERE cogs - total_sales > 0
-- Aggregate the count and sum of losses at manufacturer level
GROUP BY 1
-- Sort in the order of total losses from highest to lowest
ORDER BY 3 DESC
;