-- Rank the transactions by date and spend
WITH RANKED AS (
  SELECT
    user_id,
    spend,
    ROW_NUMBER() OVER(
      PARTITION BY user_id
      ORDER BY transaction_date, spend DESC
    ) AS txn_rank
  FROM user_transactions
)
-- Count the users that meet the criteria
SELECT COUNT(user_id) AS users
FROM RANKED
WHERE txn_rank = 1
AND spend >= 50
;