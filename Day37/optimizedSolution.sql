-- Calculate the next ride date for each ride
WITH trans_rides AS (
  SELECT
    user_id,
    ride_date,
    LEAD(ride_date, 1) OVER(
      PARTITION BY user_id
      ORDER BY ride_date
    ) AS next_ride_date
  FROM rides
)
-- Calculate the average delay on 2nd ride after
-- Joining on ride_date and registration_date and
-- filtering for the users with a 2nd ride
SELECT
  ROUND(
    AVG(tr.next_ride_date - tr.ride_date),
    2
  ) AS average_delay
FROM trans_rides AS tr
JOIN users AS u
  ON tr.user_id = u.user_id
  AND tr.ride_date = u.registration_date
WHERE tr.next_ride_date IS NOT NULL
;