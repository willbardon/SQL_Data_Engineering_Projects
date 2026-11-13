SELECT
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR), --"more" unique identifier    
    CAST(job_work_from_home AS INT) AS job_work_from_home, --from boolean to numberic value
    CAST(job_posted_date AS DATE) AS job_posted_date,
    CAST(salary_year_avg AS DECIMAL(10, 0)) AS salary_year_avg --from double to no decimal places
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 10;

SELECT
    job_id::VARCHAR || '-' || company_id::VARCHAR AS unique_id, --"more" unique identifier    
    job_work_from_home::INT AS job_work_from_home, --from boolean to numberic value
    job_posted_date::DATE AS job_posted_date,
    salary_year_avg::DECIMAL(10, 0) AS salary_year_avg --from double to no decimal places
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
LIMIT 10;

SELECT (3.5 +5)::DECIMAL(1,0);