-- Calculate the total duration using group by
WITH AGG AS (
  SELECT
    user_id,
    session_type,
    SUM(duration) AS duration
  FROM sessions
  WHERE start_date BETWEEN '2022-01-01' AND '2022-02-01'
  GROUP BY 1, 2
)
-- Rank the durations using dense rank
SELECT
  user_id,
  session_type,
  DENSE_RANK() OVER(
    PARTITION BY session_type
    ORDER BY duration DESC
  ) AS ranking
FROM AGG
;