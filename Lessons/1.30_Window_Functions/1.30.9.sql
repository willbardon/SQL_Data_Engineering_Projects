WITH lag_cte AS (
    SELECT
        company_id,
        job_posted_date,
        LAG(job_posted_date) OVER(PARTITION BY company_id ORDER BY job_posted_date) AS prev_date
    FROM job_postings_fact
        )

SELECT
    company_id,
    job_posted_date,
    prev_date,
    EXTRACT(DAY FROM job_posted_date - prev_date) AS days_between_postings
FROM
    lag_cte
WHERE prev_date IS NOT NULL;
