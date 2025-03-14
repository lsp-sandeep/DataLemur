SELECT
  EXTRACT(MONTH FROM CURR.login_date) AS month_no,
  COUNT(DISTINCT CURR.user_id) AS reactivated_users
FROM user_logins AS CURR
WHERE NOT EXISTS (
  SELECT user_id
  FROM user_logins AS PREV
  WHERE EXTRACT(MONTH FROM CURR.login_date) = EXTRACT(MONTH FROM PREV.login_date) + 1
  AND CURR.user_id = PREV.user_id
)
GROUP BY EXTRACT(MONTH FROM CURR.login_date)
HAVING COUNT(DISTINCT CURR.user_id) > 0
;