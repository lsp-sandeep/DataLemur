-- Use range between to count consecutive filings
WITH filings AS (
  SELECT
    user_id,
    COUNT(filing_id) OVER(
      PARTITION BY user_id
      ORDER BY EXTRACT(YEAR FROM filing_date)
      RANGE BETWEEN '2' PRECEDING AND CURRENT ROW
    ) AS count_filings
  FROM filed_taxes
  WHERE product LIKE 'TurboTax%'
)
SELECT DISTINCT
  user_id
FROM filings
WHERE count_filings >= 3
;
