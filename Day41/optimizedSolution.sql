-- Use Max and Filter to get email for each type in separate columns
SELECT
  user_id,
  MAX(email) FILTER(WHERE email_type = 'personal') AS personal_email,
  MAX(email) FILTER(WHERE email_type = 'business') AS business_email,
  MAX(email) FILTER(WHERE email_type = 'recovery') AS recovery_email
FROM users
GROUP BY 1
ORDER BY 1
;