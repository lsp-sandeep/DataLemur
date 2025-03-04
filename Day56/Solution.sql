WITH AGG AS (
  -- Calculate the growth using lag
  SELECT
    TO_CHAR(date, 'Mon-YYYY') AS mth_yr,
    ticker,
    open - LAG(open) OVER(
      PARTITION BY ticker
      ORDER BY date ASC
    ) AS growth
  FROM stock_prices
),
TRANS AS (
  -- Calculate the count of degrowth
  SELECT
    mth_yr,
    ticker,
    growth,
    SUM(CASE WHEN growth < 0 THEN 1 END) OVER(
      PARTITION BY mth_yr
    ) AS count_degrowth
  FROM AGG
)
-- Filter the only degrowth stock
SELECT
  mth_yr,
  ticker
FROM TRANS
WHERE growth < 0 AND count_degrowth = 1
ORDER BY mth_yr
;
