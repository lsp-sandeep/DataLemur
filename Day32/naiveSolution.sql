-- Calculation with out use of inbuilt functions
WITH agg AS (
  SELECT
    email_count,
    COUNT(user_id) AS frequency
  FROM inbox_stats
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1
)
SELECT
  SUM(email_count) / COUNT(user_id) AS mean,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY email_count) AS median,
  (SELECT MAX(email_count) FROM agg) AS mode
FROM inbox_stats
;