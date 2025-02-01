-- Calculate the yoe for top 2 domains
WITH AGG AS (
  SELECT
    employee_id,
    years_of_experience AS single_domain_yoe,
    SUM(years_of_experience) OVER(
      PARTITION BY employee_id
      ORDER BY years_of_experience ASC
      ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS double_domain_yoe
  FROM employee_expertise
)
-- Filter the employees that match the criteria
SELECT DISTINCT
  employee_id
FROM AGG
GROUP BY employee_id
HAVING MAX(single_domain_yoe) >= 8
OR MAX(double_domain_yoe) >= 12
;
