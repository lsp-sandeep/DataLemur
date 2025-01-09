-- Calculate the profit as
-- the difference between the sales and the cost
SELECT
  drug,
  total_sales - cogs as total_profit
FROM pharmacy_sales
-- Order by the profit
ORDER BY 2 DESC
-- Show the top 3 rows as most profitable drugs
LIMIT 3
;