-- Get the data to transaction date level
WITH TXNS AS (
  SELECT DISTINCT
    user_id,
    DATE(transaction_date) as transaction_date,
    1 AS transaction_flag
  FROM transactions
),
-- Check the difference between current transaction and
-- the transaction date 2 rows above
TXN_SPREE AS (
  SELECT DISTINCT
    user_id,
    transaction_date - LAG(transaction_date, 2) OVER(
      PARTITION BY user_id ORDER BY transaction_date ASC
    ) + 1 AS spree_flag
  FROM TXNS
)
-- Select the distinct users with the difference of 3
SELECT DISTINCT
  user_id
FROM TXN_SPREE
WHERE spree_flag = 3
ORDER BY user_id
;

