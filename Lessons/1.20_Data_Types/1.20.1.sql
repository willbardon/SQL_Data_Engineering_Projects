SELECT
    COUNT(job_id) AS job_count,
    job_posted_date::DATE AS DT
FROM
    job_postings_fact
WHERE
    DT = '2024-12-31'
GROUP BY
    DT;


