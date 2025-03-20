WITH not_friends AS (
  SELECT user_a_id, user_b_id
  FROM friendship_status
  WHERE status = 'not_friends'
),
private_attending_events AS (
  SELECT user_id, event_id
  FROM event_rsvp
  WHERE event_type = 'private'
  AND attendance_status IN ('going', 'maybe')
)
SELECT DISTINCT
  nf.user_a_id,
  nf.user_b_id
FROM not_friends AS nf
JOIN private_attending_events AS pae_a
  ON nf.user_a_id = pae_a.user_id
JOIN private_attending_events AS pae_b
  ON nf.user_b_id = pae_b.user_id
  AND pae_a.event_id = pae_b.event_id
GROUP BY 1, 2
HAVING COUNT(pae_b.event_id) >= 2
;