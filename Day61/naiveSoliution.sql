WITH RAW AS (
  SELECT DISTINCT
    EXTRACT(MONTH FROM login_date) AS month_no,
    user_id
  FROM user_logins
)
SELECT
  CURR.month_no,
  CASE
  WHEN CURR.month_no = 1 THEN COUNT(CURR.user_id)
  ELSE COUNT(CURR.user_id) FILTER(WHERE PREV.user_id IS NULL)
  END AS reactivated_users
FROM RAW AS CURR
LEFT JOIN RAW AS PREV
  ON CURR.month_no = PREV.month_no + 1
  AND CURR.user_id = PREV.user_id
GROUP BY CURR.month_no
HAVING CASE
  WHEN CURR.month_no = 1 THEN COUNT(CURR.user_id)
  ELSE COUNT(CURR.user_id) FILTER(WHERE PREV.user_id IS NULL)
  END > 0
;