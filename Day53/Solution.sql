WITH RAW AS (
  SELECT
    policy_holder_id,
    COUNT(case_id) OVER(
      PARTITION BY policy_holder_id
      ORDER BY call_date
      RANGE BETWEEN '7 DAY' PRECEDING AND CURRENT ROW
    ) AS repeat_caller
  FROM callers
)
SELECT 
  COUNT(DISTINCT policy_holder_id) AS policy_holder_count
FROM RAW
WHERE repeat_caller > 1
;