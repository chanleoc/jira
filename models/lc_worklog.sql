SELECT
    w."id" AS "worklog_id" -- PK
    ,w."issue_id" as "task_id"
    ,i."task_name"
    ,w."author_account_id" AS "user_id"
    ,w."author_display_name" AS "user_name"
    ,w."comment" AS "comment"
--    ,"created" AS "worklog_created"
    ,TO_CHAR(CONVERT_TIMEZONE('Etc/UTC', TRY_TO_TIMESTAMP(w."created",'YYYY-MM-DDTHH24:MI:SS.FF3+TZHTZM')),'YYYY-MM-DDTHH:MI:SSTZH') AS "created"
    ,TO_CHAR(CONVERT_TIMEZONE('Etc/UTC', TRY_TO_TIMESTAMP(w."started",'YYYY-MM-DDTHH24:MI:SS.FF3+TZHTZM')),'YYYY-MM-DDTHH:MI:SSTZH') AS "worklog_start"
    ,TO_CHAR(DATEADD(SECOND, w."time_spent_seconds"::INT, CONVERT_TIMEZONE('Etc/UTC', TRY_TO_TIMESTAMP(w."started",'YYYY-MM-DDTHH24:MI:SS.FF3+TZHTZM'))),'YYYY-MM-DDTHH:MI:SSTZH') AS "worklog_end"
    ,TO_DATE(TRY_TO_TIMESTAMP(w."started",'YYYY-MM-DDTHH24:MI:SS.FF3+TZHTZM')) AS "worklog_date"
    ,w."time_spent_seconds" AS "duration_s"
--    ,"time_spent" AS "duration_human"
    ,i."project_name"
    ,i."project_id"
FROM "worklogs" w
LEFT JOIN {{ ref('lc_tasks') }} i ON -- FULL JOIN FOR PS projects only
    w."issue_id"::VARCHAR(255) = i."task_id"::VARCHAR(255)
ORDER BY "worklog_start" DESC