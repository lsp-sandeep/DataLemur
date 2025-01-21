-- Calculate the running sum pct and lag running sum pct
WITH USER_PCT AS (
  SELECT
    searches,
    SUM(num_users) OVER(
      ORDER BY searches
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) * 100.0 / SUM(num_users) OVER() AS user_pct,
    SUM(num_users) OVER(
      ORDER BY searches
      ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    ) * 100.0 / SUM(num_users) OVER() AS lag_user_pct
  FROM search_frequency
)
-- Filter for running sum pct >= 50 and lag sum pct <= 50
SELECT
  ROUND(SUM(searches) * 1.0 / 2, 1) AS median
FROM USER_PCT
WHERE user_pct >= 50 AND lag_user_pct <= 50
;