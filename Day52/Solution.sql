WITH AGG AS (
  SELECT
    L.listing_id,
    365 - SUM(
      LEAST(COALESCE(checkout_date, '2021-01-01'), '2021-12-31')
      - GREATEST(COALESCE(checkin_date, '2021-01-01'), '2021-01-01')
    ) AS vacant_days
  FROM listings AS L
  LEFT JOIN bookings AS B
  ON B.listing_id = L.listing_id
  WHERE L.is_active = 1
  AND (COALESCE(EXTRACT(YEAR FROM B.checkin_date), 2021) = 2021
  OR COALESCE(EXTRACT(YEAR FROM B.checkout_date), 2021) = 2021)
  GROUP BY L.listing_id
)
SELECT ROUND(AVG(vacant_days), 0) AS avg_vacant_days
FROM AGG
;