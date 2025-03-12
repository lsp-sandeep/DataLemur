-- Make a two way friendship table
-- Count the followers among friends excluding followed pages
-- Rank the followers and pring the top page
WITH friends AS (
  SELECT
    user_id, friend_id
  FROM friendship
  UNION ALL
  SELECT
    friend_id, user_id 
  FROM friendship
),
AGG AS (
  SELECT
    f.user_id,
    fpf.page_id,
    COUNT(f.friend_id) AS followers
  FROM friends AS f
  LEFT JOIN page_following AS fpf
    ON f.friend_id = fpf.user_id
  WHERE NOT EXISTS (
    SELECT id
    FROM page_following AS upf
    WHERE f.user_id = upf.user_id
    AND fpf.page_id = upf.page_id
  )
  GROUP BY 1, 2
),
RANKED AS (
  SELECT
    user_id,
    page_id,
    DENSE_RANK() OVER(
      PARTITION BY user_id
      ORDER BY followers DESC
    ) AS page_rank
  FROM AGG
)
SELECT
  user_id,
  page_id
FROM RANKED
WHERE page_rank = 1
;
