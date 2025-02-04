-- Calculate the sales for each employee
-- Join with the quota to check if quota is met
SELECT
  d.employee_id,
  CASE
  WHEN d.sales >= sq.quota THEN 'yes'
  ELSE 'no' END AS made_quota
FROM (
  SELECT
    employee_id,
    SUM(deal_size) AS sales
  FROM deals
  GROUP BY 1
) AS d
LEFT JOIN sales_quotas AS sq
  ON d.employee_id = sq.employee_id
ORDER BY 1 ASC
;
