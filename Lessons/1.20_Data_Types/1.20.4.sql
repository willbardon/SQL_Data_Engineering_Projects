SELECT
    job_posted_date::DATE AS dt,
    dt::STRING,
    company_id::STRING,
    job_title_short,
    company_id||'-'||dt AS compound_key
FROM
    job_postings_fact
LIMIT 10;
