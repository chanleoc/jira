SELECT
    "account_id" AS "user_id"
    ,"display_name" AS "user_name"
    ,"active" AS "active"
    ,"email_address" AS "user_email"
FROM "users"
WHERE
    "account_type" != 'app'