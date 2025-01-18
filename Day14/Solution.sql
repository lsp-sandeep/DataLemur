-- Count the cases filtered for call category is null or 'n/a'
SELECT
  ROUND(
    COUNT(case_id) FILTER(
      WHERE call_category IS NULL OR call_category = 'n/a'
    ) * 100.0 / COUNT(case_id),
    1
  ) AS uncategorized_call_pct
FROM callers
;
