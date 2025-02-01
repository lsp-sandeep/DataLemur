-- Use filter to count and calculate the percentage
SELECT
  COUNT(review_id) FILTER(WHERE review_stars >= 4) AS business_count,
  (
    COUNT(review_id) FILTER(WHERE review_stars >= 4)
    * 100 / COUNT(review_id)
  ) AS top_rated_pct
FROM reviews
;