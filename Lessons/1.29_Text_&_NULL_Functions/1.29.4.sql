SELECT
    job_id,
    COALESCE(job_schedule_type,'Not Specified') AS schedule_info
FROM data_jobs.job_postings_fact;