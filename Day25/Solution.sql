-- Group by the customer id
-- and select the maximum purchase amount
SELECT
  customer_id,
  MAX(purchase_amount) AS purchase_amount
FROM transactions
GROUP BY customer_id
ORDER BY purchase_amount DESC
;