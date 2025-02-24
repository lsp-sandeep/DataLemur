-- Use lag to calculate month on month change in close price
SELECT
  ticker,
  date,
  close,
  ROUND(
    100.0 * (close - LAG(close, 1) OVER(PARTITION BY ticker ORDER BY date ASC))
    / LAG(close, 1) OVER(PARTITION BY ticker ORDER BY date ASC),
    2
  ) AS intermth_change_pct
FROM stock_prices
;