WITH AGG AS (
  -- Count the off topic content for each category
  SELECT
    pin.place_category,
    COUNT(mur.content_id) AS content_count
  FROM place_info AS pin
  JOIN maps_ugc_review AS mur
    ON pin.place_id = mur.place_id
  WHERE mur.content_tag = 'Off-topic'
  GROUP BY 1
),
RANKED AS (
  -- Rank the categories by content count
  SELECT
    place_category,
    DENSE_RANK() OVER(ORDER BY content_count DESC) AS place_rank
  FROM AGG
)
-- Show the top content in asceding order
SELECT
  place_category
FROM RANKED
WHERE place_rank = 1
ORDER BY 1
;