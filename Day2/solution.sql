-- Query to calculate the range of issued amount for each credit card
SELECT
  card_name,
  -- For each card find the max and min issued amount
  -- and calculate the difference between the two
  MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC
;
