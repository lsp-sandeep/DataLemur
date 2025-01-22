/*
Do a full outer join on the advertiser and daily pay
And update the status based on the conditions
*/
SELECT
  CASE
  WHEN ad.user_id IS NULL THEN dp.user_id
  ELSE ad.user_id END AS user_id,
  CASE
  WHEN ad.user_id IS NULL THEN 'NEW'
  WHEN dp.user_id IS NULL THEN 'CHURN'
  WHEN ad.status = 'CHURN' THEN 'RESURRECT'
  ELSE 'EXISTING' END AS new_status
FROM advertiser AS ad
FULL OUTER JOIN (SELECT DISTINCT user_id FROM daily_pay) AS dp
  ON ad.user_id = dp.user_id
ORDER BY 1
;
