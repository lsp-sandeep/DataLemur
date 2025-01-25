-- Use window function to calculate
-- the number of payments made in the last 10 minutes
WITH FLAGGED AS (
  SELECT
    COUNT(transaction_id) OVER(
      PARTITION BY merchant_id, credit_card_id, amount
      ORDER BY transaction_timestamp
      RANGE BETWEEN '10 MINUTE' PRECEDING AND CURRENT ROW
    ) AS payment_flag
  FROM transactions
)
-- Count the payments that are duplicated
SELECT
  COUNT(payment_flag) AS payment_count
FROM FLAGGED
WHERE payment_flag > 1
;