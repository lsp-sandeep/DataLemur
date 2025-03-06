-- Session 1 start time is between session 2 end points
-- Session 2 start time is between session 1 end points
SELECT
  ls.session_id,
  COUNT(rs.session_id) AS concurrent_sessions
FROM sessions AS ls
LEFT JOIN sessions AS rs
  ON ls.session_id != rs.session_id AND (
    (rs.start_time BETWEEN ls.start_time AND ls.end_time)
    OR (ls.start_time BETWEEN rs.start_time AND rs.end_time)
  )
GROUP BY 1
HAVING COUNT(rs.session_id) > 0
ORDER BY 2 DESC
;