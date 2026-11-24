SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_posted_date::DATE,
    EXTRACT(YEAR FROM jpf.job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM jpf.job_posted_date) AS job_posted_month,
    EXTRACT(DAY FROM jpf.job_posted_date) AS job_posted_day,
    EXTRACT(QUARTER FROM jpf.job_posted_date) AS job_posted_quarter
FROM data_jobs.job_postings_fact AS jpf
WHERE jpf.job_posted_date BETWEEN '2023-01-01' AND '2024-12-31';