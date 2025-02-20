-- Use sum window funciton with order by order_date
SELECT
  order_date,
  product_type,
  SUM(quantity) OVER(
    PARTITION BY product_type
    ORDER BY order_date ASC
  ) AS cum_purchased
FROM total_trans
ORDER BY 1
;