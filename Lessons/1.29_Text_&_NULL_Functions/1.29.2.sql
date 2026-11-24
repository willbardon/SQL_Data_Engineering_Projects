SELECT
    job_id,
    TRIM(job_location) AS job_location_clean
FROM data_jobs.job_postings_fact;