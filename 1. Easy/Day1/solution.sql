'''
IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees.
The objective is to generate data to populate a histogram that shows the number of unique queries run by
employees during the third quarter of 2023 (July to September). Additionally, it should count the number
of employees who did not run any queries during this period.

Display the number of unique queries as histogram categories,
along with the count of employees who executed that number of unique queries.
'''

SELECT
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM (
  SELECT
    e.employee_id,
    COUNT(
      DISTINCT CASE
      WHEN DATE(q.query_starttime) BETWEEN '2023-07-01' AND '2023-09-30'
      THEN q.query_id
      ELSE NULL END
    ) as unique_queries
  FROM employees as e
  LEFT JOIN queries as q ON e.employee_id = q.employee_id
  GROUP BY 1
) AS T
GROUP BY 1
ORDER BY 1
;
