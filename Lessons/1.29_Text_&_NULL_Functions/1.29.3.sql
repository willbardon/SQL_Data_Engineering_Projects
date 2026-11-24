SELECT
    job_id,
    NULLIF(job_via, 'Unknown') AS job_source_cleansed
FROM data_jobs.job_postings_fact;