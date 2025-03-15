WITH RAW AS (
  SELECT
    emp.manager_name,
    emp.manager_id,
    mng.manager_id AS direct_report_id,
    emp.emp_id,
    CASE WHEN
    COUNT(mng.manager_id) OVER(
      PARTITION BY emp.manager_id
    ) > 0 THEN 1
    ELSE 0 END AS srm_flag
  FROM employees AS emp
  LEFT JOIN employees AS mng
    ON emp.emp_id = mng.manager_id
)
SELECT
  r.manager_name,
  COUNT(r.direct_report_id) AS direct_reportees
FROM RAW AS r
LEFT JOIN RAW AS rm
  ON r.emp_id = rm.manager_id
WHERE r.srm_flag = 1
GROUP BY r.manager_name, r.manager_id
HAVING SUM(COALESCE(rm.srm_flag, 0)) = 0
ORDER BY 2 DESC
;