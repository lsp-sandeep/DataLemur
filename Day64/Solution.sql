WITH RAW AS (
  SELECT
    rental_id,
    STRING_AGG(amenity, '|' ORDER BY amenity) AS amenity_key
  FROM rental_amenities
  GROUP BY 1
)
SELECT COUNT(L.rental_id) count_matches
FROM RAW AS L
JOIN RAW AS R
  ON L.amenity_key = R.amenity_key
  AND L.rental_id < R.rental_id
;