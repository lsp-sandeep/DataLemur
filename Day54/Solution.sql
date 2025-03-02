-- Count the count of long call
-- Calculate the growth from prev month using lag
WITH AGG AS (
  SELECT
    EXTRACT(YEAR FROM call_date) AS yr,
    EXTRACT(MONTH FROM call_date) AS mth,
    COUNT(case_id) FILTER(WHERE call_duration_secs > 300) AS long_calls
  FROM callers
  GROUP BY 1, 2
)
SELECT
  yr,
  mth,
  ROUND(
    (
      long_calls - LAG(long_calls, 1) OVER(
        ORDER BY yr, mth
      )
    ) * 100.0 / LAG(long_calls, 1) OVER(
      ORDER BY yr, mth
    ), 1
  ) AS long_calls_growth_pct
FROM AGG
