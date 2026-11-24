SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS job_count,
    CASE
        WHEN job_count > 100 THEN '100+ WFH DE Jobs'
        WHEN job_count >= 50 THEN '50-100 WFH DE Jobs'
        WHEN job_count >= 25 THEN '25-49 WFH DE Jobs'
        ELSE 'Less than 25 WFE DE Jobs'
    END AS WFH_DE_job_category
FROM
    data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
    jpf.job_work_from_home = TRUE
    AND
    jpf.job_title_short = 'Data Engineer'
GROUP BY cd.name
ORDER BY job_count DESC;