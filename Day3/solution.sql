-- Query to calculate the average items per order
SELECT
  -- Round the result to 1 decimal
  ROUND(
    -- Sum the total items orders = item count * orders
    SUM(item_count::DECIMAL * order_occurrences)
    -- Divide with the total no of orders
    / SUM(order_occurrences),
    1
  ) AS mean
FROM items_per_order
;