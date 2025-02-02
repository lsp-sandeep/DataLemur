-- Join the transaction and payout table
-- Calculate the total payout for each store
SELECT
  tt.store_id,
  SUM(tp.payout_amount) AS payout_total
FROM trade_in_transactions AS tt
LEFT JOIN trade_in_payouts AS tp
  ON tt.model_id = tp.model_id
GROUP BY tt.store_id
ORDER BY payout_total DESC
;
