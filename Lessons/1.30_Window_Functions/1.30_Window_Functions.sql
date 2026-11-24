-- Count Rows - Aggregation Only
SELECT
    COUNT(*)
FROM    
    data_jobs.job_postings_fact;

-- Count Rows - Window Function. The parentheses define the window we want to look at.
SELECT
    job_id,
    COUNT(*) OVER ()

FROM    
    data_jobs.job_postings_fact;

--The PARTITION BY argument for window functions.
--Suppose we want the average salary_hour_avg for all job_title_short
--Partition allows us to run the AVG aggregation within each distinct job_title_short and display for each row

SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
    ) AS avg_hourly_by_title
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY
    RANDOM()
LIMIT 10;

--The ORDER BY argument for window functions.
--Suppose we want to rank job_title_short in order by salary
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL

--Note: In this case the ORDER BY within the window function is sufficient but you can't always rely on it.
--It's best practice to specify the general ORDER BY
ORDER BY
    salary_hour_avg DESC
LIMIT 10;

--PARTITION & ORDER BY

--Here we're going to get a running average for a subset of job_title_short ordered by job_posted_date

SELECT
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY
    job_title_short,
    job_posted_date
LIMIT 10;

-- PARTITION BY & ORDER BY - Ranking by job_title_short
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL

ORDER BY
    salary_hour_avg DESC,
    job_title_short
LIMIT 10;

--The ORDER BY in the window function is applied fully independently of the general ORDER BY

--Aggregation functions with window functions

SELECT
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    MIN(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
    AND job_title_short = 'Data Engineer'
ORDER BY
    job_title_short,
    job_posted_date
LIMIT 10;

--Row & Rank Functions

--RANK() & DENSE_RANK
SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    DENSE_RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC
LIMIT 140;

-- ROW_NUMBER()
SELECT 
    *,
    ROW_NUMBER() OVER (
        ORDER BY job_posted_date
    )

FROM job_postings_fact
ORDER BY job_posted_date
LIMIT 20;

--ROW_NUMBER can be used as a ranking function. It does not order ties by default, this must be specifed in the general ORDER BY

SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    ROW_NUMBER() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC,
    rank_hourly_salary
LIMIT 140;

--Navigation Functions
--Suppose we want to see how companies raise or lower salary offerings over time.

SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_posting_salary
    FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL

ORDER BY company_id, job_posted_date
LIMIT 60;

--Now suppose we want to calculate the change in salary between a company's postings:

SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_posting_salary,
    salary_year_avg - LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change
    FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL

ORDER BY company_id, job_posted_date
LIMIT 60;

--LEAD

SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LEAD(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS next_posting_salary,
    salary_year_avg - LEAD(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change
    FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL

ORDER BY company_id, job_posted_date
LIMIT 60;
