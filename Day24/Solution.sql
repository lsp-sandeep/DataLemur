-- Use filter and count functions to count the filings
SELECT
  COUNT(filing_id) FILTER(WHERE product LIKE 'TurboTax%') AS turbotax_total,
  COUNT(filing_id) FILTER(WHERE product LIKE 'QuickBooks%') AS quickbooks_total
FROM filed_taxes;
