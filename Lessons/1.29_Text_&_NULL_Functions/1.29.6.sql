SELECT
    job_id,
    COALESCE(TRIM(job_location),'Remote') AS job_location_clean
FROM data_jobs.job_postings_fact
WHERE TRIM(job_location) IS NULL;