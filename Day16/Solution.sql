-- Calculate the maximum footage for prime eligible items
WITH PRIME AS (
  SELECT
    FLOOR(
      500000 / SUM(square_footage)
    ) * COUNT(item_id) AS item_count,
    FLOOR(
      500000 / SUM(square_footage)
    ) * SUM(square_footage) AS square_footage
  FROM inventory
  WHERE item_type = 'prime_eligible'
),
-- Calculate the remaining footage for non prime eligible items
NON_PRIME AS (
  SELECT
    FLOOR(
      (500000 - (SELECT MAX(square_footage) FROM PRIME))
      / SUM(square_footage)
    ) * COUNT(item_id) AS item_count,
    FLOOR(
      (500000 - (SELECT MAX(square_footage) FROM PRIME))
      / SUM(square_footage)
    ) * SUM(square_footage) AS square_footage
  FROM inventory
  WHERE item_type = 'not_prime'
)
-- Add the prime and non prime item counts
SELECT
  'prime_eligible' AS item_type,
  item_count
FROM PRIME
UNION ALL
SELECT
  'not_prime' AS item_type,
  item_count
FROM NON_PRIME
;