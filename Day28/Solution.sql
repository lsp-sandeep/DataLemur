-- Create inner join of product and transactions
-- Calculate the sum of amount as total revenue
SELECT
  product_line,
  SUM(amount) AS total_revenue
FROM product_info AS p
INNER JOIN transactions AS t
  ON p.product_id = t.product_id
GROUP BY product_line
ORDER BY total_revenue DESC
;