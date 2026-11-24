SELECT
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(QUARTER FROM job_posted_date) AS job_posted_quarter,
    job_posted_year || '-' || job_posted_quarter AS job_posted_year_quarter,
    COUNT(job_id) AS job_postings_fact
FROM data_jobs.job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) IN (2023, 2024)
GROUP BY
    EXTRACT(QUARTER FROM job_posted_date),
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(YEAR FROM job_posted_date) || '-' || EXTRACT(QUARTER FROM job_posted_date)
ORDER BY
    job_posted_year_quarter;

