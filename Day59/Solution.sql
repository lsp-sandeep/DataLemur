-- Use inner join to filter the time period and case when to flag the issue
-- Count the orders pct that satisfy the flag criteria
SELECT
  ROUND(
    COUNT(
      DISTINCT CASE
      WHEN o.status IN ('completed incorrectly', 'never received') THEN o.order_id
      WHEN EXTRACT(EPOCH FROM (t.actual_delivery_timestamp - o.order_timestamp))/60 > 30 THEN o.order_id
      ELSE NULL END
    ) * 100.0 / COUNT(DISTINCT o.order_id),
    2
  ) AS bad_experience_pct
FROM customers AS c
JOIN orders AS o
  ON c.customer_id = o.customer_id
  AND DATE_TRUNC('month', c.signup_timestamp) = '2022-06-01'
  AND o.order_timestamp BETWEEN c.signup_timestamp AND c.signup_timestamp + INTERVAL '14 day'
LEFT JOIN trips AS t
  ON o.trip_id = t.trip_id
;