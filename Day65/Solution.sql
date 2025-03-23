SELECT
  EXTRACT(WEEK FROM signup_date) - 21 AS week,
  ROUND(
    COUNT(user_id) FILTER(
      WHERE last_login BETWEEN signup_date AND signup_date + INTERVAL '28' DAY
    ) * 100.0/ COUNT(user_id),
    2
  ) AS churn_rate
FROM users
WHERE DATE_TRUNC('MONTH', signup_date) = '2022-06-01'
GROUP BY 1
ORDER BY 1
;
