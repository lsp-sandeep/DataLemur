-- Approach 1
-- Create a rank based on the year and month
-- for each card name
WITH RANKED AS (
  SELECT
    card_name,
    issued_amount,
    ROW_NUMBER() OVER(
      PARTITION BY card_name
      ORDER BY issue_year, issue_month
    ) AS issue_year_month_rank
  FROM monthly_cards_issued
)
-- Filter for the first year month
SELECT
  card_name,
  issued_amount
FROM RANKED
WHERE issue_year_month_rank = 1
ORDER BY issued_amount DESC
;