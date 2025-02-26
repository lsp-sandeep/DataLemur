WITH AGG AS (
  SELECT
    mt.contact_id,
    crm.email,
    EXTRACT(YEAR FROM event_date)*100 + EXTRACT(WEEK FROM event_date) AS year_week,
    COUNT(event_id) AS count_touches,
    COUNT(
      CASE
      WHEN event_type = 'trial_request' THEN event_id
      ELSE NULL END
    ) AS count_trials
  FROM marketing_touches AS mt
  LEFT JOIN crm_contacts AS crm
    ON mt.contact_id = crm.contact_id
  GROUP BY 1, 2, 3
),
AGG2 AS (
  SELECT
    contact_id,
    email,
    SUM(CASE WHEN count_touches > 0 THEN 1 ELSE 0 END) OVER(
      PARTITION BY contact_id
      ORDER BY year_week
      RANGE BETWEEN '2' PRECEDING AND CURRENT ROW
    ) AS touch_streak,
    SUM(count_trials) OVER(
      PARTITION BY contact_id
    ) AS count_trials
  FROM AGG
)
SELECT
  email
FROM AGG2
WHERE touch_streak >= 3 AND count_trials > 0
;
