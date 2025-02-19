-- Use the formula to calculate the total compensation
SELECT
  ec.employee_id,
  (
    ec.base
    + ec.commission * SUM(d.deal_size)
    + ec.commission * (MAX(ec.accelerator) - 1) * GREATEST(0, SUM(d.deal_size) - ec.quota)
  ) AS total_compensation
FROM employee_contract AS ec
LEFT JOIN deals AS d
 ON ec.employee_id = d.employee_id
GROUP BY ec.employee_id, ec.base, ec.commission, ec.accelerator, ec.quota
ORDER BY 2 DESC, 1
;