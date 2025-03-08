-- 1) Calculate the net transaction amount for each day
-- 2) Calculate the cumulative sum of the net amount for each month
WITH AGG AS (
  SELECT
    DATE(transaction_date) AS transaction_date,
    SUM(
      CASE
      WHEN type = 'withdrawal' THEN -1*amount
      ELSE amount END
    ) AS net_daily_txn
  FROM transactions
  GROUP BY 1
)
SELECT
  transaction_date,
  SUM(net_daily_txn) OVER(
    PARTITION BY TO_CHAR(transaction_date, 'Mon-YYYY')
    ORDER BY transaction_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS balance
FROM AGG
ORDER BY 1
;
