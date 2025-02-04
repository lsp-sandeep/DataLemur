-- Filter for the april month event date
-- Calculate the percentage of webinars
SELECT
  ROUND(
    COUNT(event_id) FILTER(WHERE event_type = 'webinar')
    * 100 / COUNT(event_id),
    0
  ) AS webinar_pct
FROM marketing_touches
WHERE DATE_TRUNC('month', event_date) = '2022-04-01'
;
