-- Calculate the overall and department average salary for each month
WITH AGG AS (
  SELECT DISTINCT
    TO_CHAR(s.payment_date, 'MM-YYYY') AS payment_date,
    e.department_id,
    SUM(amount) OVER(
        PARTITION BY TO_CHAR(s.payment_date, 'MM-YYYY')
    ) * 1.0 / COUNT(s.employee_id) OVER(
        PARTITION BY TO_CHAR(s.payment_date, 'MM-YYYY')
    ) AS overall_average_salary,
    SUM(amount) OVER(
        PARTITION BY TO_CHAR(s.payment_date, 'MM-YYYY'), e.department_id
    ) * 1.0 / COUNT(s.employee_id) OVER(
        PARTITION BY TO_CHAR(s.payment_date, 'MM-YYYY'), e.department_id
    ) AS department_average_salary
  FROM employee AS e
  JOIN salary AS s
    ON e.employee_id = s.employee_id
)
-- Compare the department and average salary and create the comparison flag
SELECT
  department_id,
  payment_date,
  CASE
  WHEN department_average_salary > overall_average_salary THEN 'higher'
  WHEN department_average_salary < overall_average_salary THEN 'lower'
  ELSE 'same' END AS comparison
FROM AGG
WHERE payment_date = '03-2024'
;
