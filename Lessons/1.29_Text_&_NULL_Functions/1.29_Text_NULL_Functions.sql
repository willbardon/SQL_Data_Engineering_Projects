SELECT LENGTH('SQL');
SELECT CHAR_LENGTH('SQL');
SELECT UPPER('Sql');
SELECT LOWER('SQL');
SELECT LEFT('SQL', 2);
SELECT RIGHT('SQL', 2);
SELECT SUBSTRING('SQL', 2, 1);
SELECT CONCAT('SQL', '-','Functions');

--OR

SELECT 'SQL' || '-' || 'Functions';

--Trim functions

SELECT TRIM(' SQL ');
SELECT LTRIM(' SQL ');
SELECT RTRIM(' SQL ');

--Replace

SELECT REPLACE ('SQL', 'Q', '_');
SELECT REGEXP_REPLACE ('SQL', '[A-Z]+', 'sql');
SELECT REGEXP_REPLACE ('data.nerd@gmail.com', '^.*(@)', '\1');

--Final Example - Cleaning up the CASE function from earlier. Current function is case-sensitive

--Instead of wrapping each job_title in UPPER(), we should use a CTE instead:

WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) as job_title_clean
    FROM data_jobs.job_postings_fact
)

SELECT
    job_title,
    CASE    
        WHEN job_title_clean LIKE '%data'
            AND job_title_clean LIKE '%analyst' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data'
            AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        WHEN job_title_clean LIKE '%data'
            AND job_title_clean LIKE '%engineer' THEN 'Data Engineer'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;
        

--NULLIF/COALESCE Functions

--NULLIF(A, B) returns NULL if A = B

SELECT NULLIF(10, 20);

--What if we want to identify instances where salary is given as 0 and we want to replace that with NULL?
--This way we can calcute accurately.
SELECT
    MEDIAN(NULLIF(salary_year_avg, 0),)
    MEDIAN(NULLIF(salary_hour_avg, 0))
FROM    
    data_jobs.job_postings_fact
WHERE salary_hour_avg IS NOT NULL AND salary_year_avg IS NOT NULL
LIMIT 10;

--COALESE(A,B,C) returns the first non-NULL value.

SELECT COALESCE(NULL,1,2);

--What if we were converting to a standardized salary?

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM    
    data_jobs.job_postings_fact
WHERE salary_hour_avg IS NOT NULL AND salary_year_avg IS NOT NULL
LIMIT 10;