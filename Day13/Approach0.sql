-- Get the caller and reciever country by joining with base table
-- Calculate the ratio of count of rows with different countries to total rows
SELECT
  ROUND(
    SUM(
      CASE WHEN pic.country_id <> pir.country_id THEN 1 ELSE 0 END
    ) * 100.0 / COUNT(pc.caller_id),
    1
  ) AS international_calls_pct
FROM phone_calls AS pc
LEFT JOIN phone_info AS pic ON pc.caller_id = pic.caller_id
LEFT JOIN phone_info AS pir ON pc.receiver_id = pir.caller_id
;