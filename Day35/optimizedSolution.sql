-- Use string agg and order by to concatenate the product ids in order
-- Filter for combinations with more than 1 product using HAVING clause
SELECT DISTINCT
  STRING_AGG(product_id::VARCHAR, ',' ORDER BY product_id) AS combination
FROM transactions
GROUP BY transaction_id
HAVING COUNT(DISTINCT product_id) > 1
ORDER BY 1
;