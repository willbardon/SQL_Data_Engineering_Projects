SELECT
    name
FROM data_jobs.company_dim
WHERE
    EXISTS(
        SELECT 1
            
        FROM data_jobs.job_postings_fact
        WHERE job_postings_fact.company_id = company_dim.company_id);