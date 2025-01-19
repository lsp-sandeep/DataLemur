-- Rank the each product in category
-- based on sales and rating
WITH RANKING AS (
  SELECT
    p.category_name,
    p.product_name,
    ROW_NUMBER() OVER(
      PARTITION BY p.category_name
      ORDER BY ps.sales_quantity DESC, ps.rating DESC
    ) AS product_rank
  FROM products AS p
  LEFT JOIN product_sales AS ps
    ON p.product_id = ps.product_id
)
-- Select the top ranking product
SELECT
  category_name,
  product_name
FROM RANKING
WHERE product_rank = 1
;
