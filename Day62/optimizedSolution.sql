SELECT
  mng.manager_name,
  COUNT(DISTINCT mng.emp_id) AS direct_reportees
FROM employees AS emp
JOIN employees AS mng
  ON emp.manager_id = mng.emp_id
JOIN employees AS srmng
  ON mng.manager_id = srmng.emp_id
GROUP BY 1
ORDER BY 2 DESC
;
