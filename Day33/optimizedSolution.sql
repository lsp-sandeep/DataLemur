-- Rank the transactions for each user
WITH RANKED AS (
  SELECT
    user_id,
    spend,
    transaction_date,
    ROW_NUMBER() OVER(
      PARTITION BY user_id
      ORDER BY transaction_date ASC
    ) AS txn_rank
  FROM transactions
)
-- Filter the 3rd transaction
SELECT
  user_id, spend, transaction_date
FROM RANKED
WHERE txn_rank = 3
;
