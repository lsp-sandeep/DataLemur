SELECT
  country,
  SUM(num_search) AS total_search,
  CASE WHEN
    SUM(num_search) > 0 THEN
      ROUND(
        SUM(num_search * invalid_result_pct) / SUM(num_search), 2
      )
  ELSE 0 END AS invalid_searches_pct
FROM search_category
WHERE invalid_result_pct IS NOT NULL
GROUP BY 1
HAVING SUM(COALESCE(num_search, 0)) > 0
ORDER BY 1
;
