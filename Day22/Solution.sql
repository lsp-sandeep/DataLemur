-- Calculate the next status time for each record
WITH running_time AS (
  SELECT
    server_id,
    session_status,
    status_time AS start_time,
    LEAD(status_time) OVER(
      PARTITION BY server_id
      ORDER BY status_time ASC
    ) AS stop_time
  FROM server_utilization
)
-- Filter for the start records
-- Sum the difference of start and stop time
SELECT
  DATE_PART(
    'days',
    JUSTIFY_HOURS(SUM(stop_time - start_time))
  ) AS total_uptime_days
FROM running_time
WHERE session_status = 'start'
;