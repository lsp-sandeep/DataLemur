-- FILTER the repeat purchasers using group by user and product
-- And having count distinct dates more than 2 for at least one group
-- Count the distinct users of the above criteria
WITH AGG AS (
  SELECT
    user_id
  FROM purchases
  GROUP BY user_id, product_id
  HAVING COUNT(DISTINCT purchase_date::DATE) >= 2
)
SELECT
  COUNT(DISTINCT user_id) AS repeat_purchasers
FROM AGG
;

