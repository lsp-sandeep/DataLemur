-- Use window function to calculate the rolling 3 day sum
SELECT DISTINCT
  user_id,
  transaction_date,
  SUM(amount) OVER(
    PARTITION BY user_id
    ORDER BY transaction_date
    RANGE BETWEEN '2 DAY' PRECEDING AND CURRENT ROW
  ) AS rolling_earnings_3d
FROM user_transactions
ORDER BY user_id, transaction_date
;
