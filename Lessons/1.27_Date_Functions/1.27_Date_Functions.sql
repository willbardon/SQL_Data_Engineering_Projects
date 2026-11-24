SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT 
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestampz
FROM job_postings_fact
LIMIT 10;

--EXTRACT Function

SELECT
    job_posted_date,
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    EXTRACT(DAY FROM job_posted_date) AS job_posted_day
FROM job_postings_fact
LIMIT 10;

--EXTRACT is useful for aggregation:


SELECT

    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY 
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY
    job_posted_year,
    job_posted_month
;

--Date Truncate DATE_TRUNC

SELECT job_posted_date,
    DATE_TRUNC('month', job_posted_date) AS job_posted_month
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;

SELECT job_posted_date,
    DATE_TRUNC('year', job_posted_date) AS truncated_year,
    DATE_TRUNC('quarter', job_posted_date) AS truncated_year,
    DATE_TRUNC('month', job_posted_date) AS truncated_month,
    DATE_TRUNC('week', job_posted_date) AS truncated_week,
    DATE_TRUNC('day', job_posted_date) AS truncated_day,
    DATE_TRUNC('hour', job_posted_date) AS truncated_hour
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 10;


--DATE_TRUNC helps simplify aggregation compared to EXTRACT. Now we need only one item in GROUP BY and ORDER BY:
SELECT

    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Engineer'
    AND
    EXTRACT(YEAR FROM job_posted_date) = 2024
    -- Alternatively: DATE_TRUNC('year', job_posted_date) = '2024-01-01' (longer but more robust)
GROUP BY 
    DATE_TRUNC('month', job_posted_date)
ORDER BY

    job_posted_month;

--AT TIME ZONE

SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ;

SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'EST';

--When you have timestamps without timezones, it's treated as a local time zone in Duck Db and most databases.
--We need to specify what the timezone is in UTC then back to local.
SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM
    job_postings_fact
WHERE
    job_location LIKE '%New York, NY%';

--Suppose we want to identify the most active job posting times:

SELECT
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS posted_hour,
    COUNT(job_id)
FROM
    job_postings_fact
WHERE
    job_location LIKE '%New York, NY%'
GROUP BY
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')
ORDER BY
    posted_hour;