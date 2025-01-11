-- Calculate the sum of sales at the manufacturer level
SELECT
  manufacturer,
  -- Format to $ million dividing the sum by 1000000 and rounding to 0
  -- Cast the rounded figure to a varchar and concat with the prefix and suffix
  '$' || ROUND(sum(total_sales) / 1000000, 0)::VARCHAR || ' million' as sale
FROM pharmacy_sales
GROUP BY manufacturer
-- Order by the sum of sales since the sale is in string format
ORDER BY sum(total_sales) DESC, manufacturer ASC
;
