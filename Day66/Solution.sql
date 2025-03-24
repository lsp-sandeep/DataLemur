-- Calculate the distinct no of clients for each employee
-- Use this flag to identify single client consultants
WITH RAW AS (
  SELECT
    employee_id,
    COUNT(DISTINCT client_name) AS count_clients
  FROM employees AS E
  LEFT JOIN consulting_engagements AS CE
    ON E.engagement_id = CE.engagement_id
  GROUP BY 1
)
SELECT
  client_name,
  COUNT(DISTINCT E.employee_id) AS total_consultants,
  COUNT(DISTINCT E.employee_id) FILTER(
    WHERE count_clients = 1
    ) AS single_client_consultants
FROM employees AS E
LEFT JOIN consulting_engagements AS CE
  ON E.engagement_id = CE.engagement_id
LEFT JOIN RAW AS R
  ON E.employee_id = R.employee_id
GROUP BY 1
ORDER BY 1
;