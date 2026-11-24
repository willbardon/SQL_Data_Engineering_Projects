--We can create lists in SQL using []

SELECT [1,1,1,2];

--To put into rows we use the UNNEST() function:

SELECT UNNEST([1,1,1,2]);

--We create table B:


SELECT UNNEST([1,1,3]);

--To combine these tables without duplictation we use the UNION operator:

SELECT UNNEST([1,1,1,2])
UNION
SELECT UNNEST([1,1,3]);

--To combine these tables with all values from each we use the UNION ALL operator:

SELECT UNNEST([1,1,1,2])
UNION ALL
SELECT UNNEST([1,1,3]);

--To return only rows in both tables without duplication we use the INTERSECT operator:

SELECT UNNEST([1,1,1,2])
INTERSECT
SELECT UNNEST([1,1,3]);

-- To return only rows in both tables with duplication we use the INTERSECT ALL operator.
-- Repeat instances of values in one table that do not have a corresponding repeat value in the other table will not be returned however.

SELECT UNNEST([1,1,1,2])
INTERSECT ALL
SELECT UNNEST([1,1,3]);

-- To return values that exist only in Table A without duplication, we use the EXCEPT operator:

SELECT UNNEST([1,1,1,2])
EXCEPT
SELECT UNNEST([1,1,3]);

-- To return values in Table A that do not have a correponding pair value in Table B, we use the INTERSECT ALL operator.
-- This is the complement of INTERSECT ALL. Only pairs across tables are removed. Unlike EXCEPT, EXCEPT ALL returns "1" once from A here because there is one instance of it without a corresponding "1" in B. 

SELECT UNNEST([1,1,1,2])
EXCEPT ALL
SELECT UNNEST([1,1,3]);

--Real World Example


CREATE TEMP TABLE jobs_2023 AS 
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

CREATE TEMP TABLE jobs_2024 AS 
SELECT * EXCLUDE (job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

-- Which unique job postings appeared in either 2023 or 2024?

SELECT * FROM jobs_2023
UNION
SELECT * FROM jobs_2024;

SELECT 
    'jobs_2023' AS table_name,
    COUNT(*)    AS record_count
FROM jobs_2023
UNION
SELECT 
    'jobs_2024' AS table_name,
    COUNT(*) 
FROM jobs_2024;

-- Which job postings appeared in 2023 but not in 2024?

SELECT * FROM jobs_2023
EXCEPT
SELECT * FROM jobs_2024;

-- Which job postings remain after subtracting matching 2024 postings, one-for-one?

SELECT * FROM jobs_2023
EXCEPT ALL
SELECT * FROM jobs_2024;

-- Which job postings appeared in both 2023 and 2024?

SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;

-- Which job postings appeared in both years, preserving duplicate counts?

SELECT * FROM jobs_2023
INTERSECT ALL
SELECT * FROM jobs_2024;

