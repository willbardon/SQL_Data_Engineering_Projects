WITH company_expenditure_cte AS (
    SELECT
        company_id,
        salary_year_avg,
        SUM(salary_year_avg) OVER(PARTITION BY company_id) AS company_expenditure
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
        )

SELECT
    jpf.job_id,
    jpf.job_title,
    jpf.job_posted_date,
    ce.salary_year_avg / ce.company_expenditure * 100 ||'%' AS percent_of_total_spend
FROM
    job_postings_fact AS jpf
    LEFT JOIN company_expenditure_cte AS ce ON ce.company_id = jpf.company_id;
