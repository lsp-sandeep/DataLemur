-- Rank the months for each ticker
-- Both in ascending and descending order of open price
WITH RANKED AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS mth,
    open,
    ROW_NUMBER() OVER(
      PARTITION BY ticker
      ORDER BY open DESC
    ) AS top_rank,
    ROW_NUMBER() OVER(
      PARTITION BY ticker
      ORDER BY open ASC
    ) AS bottom_rank
  FROM stock_prices
)
-- Do a self join on ranked cte
-- where the left is filtered for the top_rank = 1
-- and the right is filtered for bottom_rank = 1
SELECT
  H.ticker,
  -- The month and open from left are highest
  H.mth AS highest_mth,
  H.open AS highest_open,
  -- The month and open from the right are lowest
  L.mth AS lowest_mth,
  L.open AS lowest_open
FROM (SELECT * FROM RANKED WHERE top_rank = 1) AS H
LEFT JOIN (SELECT * FROM RANKED WHERE bottom_rank = 1) AS L
  ON H.ticker = L.ticker
ORDER BY ticker
;

