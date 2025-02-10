-- Create CTE of first bookings for each user
WITH FIRST_BOOK AS (
  SELECT DISTINCT ON (user_id)
    user_id, b.booking_id, COALESCE(channel, 'OTHER') AS channel
  FROM bookings AS b
  LEFT JOIN booking_attribution AS ba
    ON b.booking_id = ba.booking_id
  ORDER BY user_id, booking_date ASC
)
-- Calculate booking percentage and display the first
SELECT
  channel,
  ROUND(
    COUNT(booking_id) * 100.0
    / (SELECT COUNT(booking_id) FROM FIRST_BOOK),
    0
  ) AS first_booking_pct
FROM FIRST_BOOK
WHERE channel <> 'OTHER'
GROUP BY channel
ORDER BY 2 DESC
LIMIT 1
;