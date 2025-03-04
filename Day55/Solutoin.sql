-- Calculate the next product using lead function
-- Count the followup customer by filtering for current and next product
WITH AGG AS (
  SELECT
    customer_id,
    product_name,
    LEAD(product_name, 1) OVER(
      PARTITION BY customer_id
      ORDER BY t.transaction_timestamp, t.transaction_id
    ) next_product_name
  FROM transactions AS t
)
SELECT
  ROUND(
    COUNT(customer_id) FILTER(
      WHERE product_name = 'iPhone' AND next_product_name = 'AirPods'
    ) * 100.0 / COUNT(customer_id) FILTER(
      WHERE product_name = 'iPhone'
    ), 0
  ) AS follow_up_percentage
FROM AGG
;