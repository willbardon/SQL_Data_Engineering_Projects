CREATE TABLE company_salary_stats AS
    SELECT
        company_id,
        AVG(salary_year_avg)::INT AS avg_yearly_salary,
        COUNT(job_id) AS job_count
    FROM data_jobs.job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY
        company_id;

SELECT * FROM company_salary_stats LIMIT 10;

DROP TABLE company_salary_stats;