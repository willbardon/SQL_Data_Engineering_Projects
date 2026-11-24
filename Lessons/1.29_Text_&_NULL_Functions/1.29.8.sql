SELECT
    jpf.job_id,
    UPPER(COALESCE(cd.name,'Unknown')) AS company_name_standardized
FROM
    data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id
WHERE cd.name IS NULL;