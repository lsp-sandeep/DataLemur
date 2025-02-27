
WITH AGG AS (
  SELECT
    item_count,
    ROUND(
      SUM(order_occurrences) OVER(
        ORDER BY item_count
        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
      ) * 100 / SUM(order_occurrences) OVER(), 1
    ) AS prev_cum_orders_pct,
    ROUND(
      SUM(order_occurrences) OVER(
        ORDER BY item_count
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) * 100 / SUM(order_occurrences) OVER(), 1
    ) AS cum_orders_pct
  FROM items_per_order
)
SELECT
  (SUM(item_count) * 1.0 / COUNT(item_count))::DECIMAL AS median
FROM AGG
WHERE 50 BETWEEN prev_cum_orders_pct AND cum_orders_pct 
;
