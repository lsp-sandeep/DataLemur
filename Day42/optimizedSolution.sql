-- Aggreage the revenue from products other than photoshop
-- Filter for customers that bought photoshop
SELECT
  customer_id,
  SUM(revenue) FILTER(WHERE product <> 'Photoshop') AS revenue
FROM adobe_transactions
WHERE customer_id IN (
  SELECT DISTINCT customer_id FROM adobe_transactions
  WHERE product = 'Photoshop'
  )
GROUP BY 1
;