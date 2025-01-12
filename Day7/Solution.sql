-- Count the policy holders in the sub query
SELECT
  COUNT(policy_holder_id) AS policy_holder_count
FROM (
  -- Select the policy holders with >= 3 calls
  SELECT
    policy_holder_id
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS T
;