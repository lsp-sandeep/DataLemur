-- Use filter function to calculate the revenue i.e. product of cost and seats
-- and count the unique customer in each segment
SELECT
  (
    SUM(yearly_seat_cost * num_seats) FILTER(WHERE employee_count < 100)
    / COUNT(DISTINCT cst.customer_id) FILTER(WHERE employee_count < 100)
  ) AS smb_avg_revenue,
  (
    SUM(yearly_seat_cost * num_seats) FILTER(WHERE employee_count BETWEEN 100 AND 999)
    / COUNT(DISTINCT cst.customer_id) FILTER(WHERE employee_count BETWEEN 100 AND 999)
  ) AS mid_avg_revenue,
  (
    SUM(yearly_seat_cost * num_seats) FILTER(WHERE employee_count >= 1000)
    / COUNT(DISTINCT cst.customer_id) FILTER(WHERE employee_count >= 1000)
  ) AS enterprise_avg_revenue
FROM contracts AS cnt
LEFT JOIN customers AS cst
  ON cnt.customer_id = cst.customer_id
;