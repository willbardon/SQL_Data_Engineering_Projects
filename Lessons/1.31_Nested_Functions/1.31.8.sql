WITH agg_company_salaries AS (
    SELECT
        company_id,
        AVG(salary_year_avg) AS avg_company_salary,
        ARRAY_AGG(salary_year_avg) AS salary_array
    FROM 
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
    GROUP BY
        company_id
        ),
    salary_flat AS (
        SELECT
            company_id,
            avg_company_salary,
            UNNEST(salary_array) AS specific_salary
        FROM
            agg_company_salaries
            )
SELECT
    company_id,
    specific_salary,
    avg_company_salary
FROM
    salary_flat
WHERE
    specific_salary > (avg_company_salary * 1.5);
