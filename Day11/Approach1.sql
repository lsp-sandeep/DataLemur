-- Get the data to transaction date level
WITH TXNS AS (
  SELECT DISTINCT
    user_id,
    DATE(transaction_date) as transaction_date
  FROM transactions
)
SELECT DISTINCT
  T1.user_id
FROM transactions AS T1
INNER JOIN TXNS AS T2 ON DATE(T1.transaction_date) = DATE(T2.transaction_date) - 1
INNER JOIN TXNS AS T3 ON DATE(T1.transaction_date) = DATE(T3.transaction_date) - 2
ORDER BY T1.user_id
;
