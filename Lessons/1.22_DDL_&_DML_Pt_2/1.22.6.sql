CREATE TEMP TABLE top_hiring_companies_temp AS
SELECT
    jpf.company_id,
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM
    data_jobs.job_postings_fact AS jpf
    INNER JOIN
    data_jobs.company_dim AS cd ON jpf.company_id = cd.company_id
GROUP BY
    jpf.company_id,
    cd.name
HAVING
    COUNT(jpf.job_id) > 10;

SELECT * FROM top_hiring_companies_temp;