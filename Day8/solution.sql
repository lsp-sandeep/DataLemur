-- Multiply the num_seats and cost per seat
-- to get annual revenue per customer and
-- sum all the revenues to get total revenue
-- then divide it by the count of customers
-- to find the average deal size
SELECT
  ROUND(
    SUM(1.0 * num_seats * yearly_seat_cost)
    / COUNT(customer_id),
    2
  ) AS average_deal_size
FROM contracts
;
