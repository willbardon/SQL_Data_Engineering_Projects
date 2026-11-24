CREATE SCHEMA work_mode_mart;
USE company_jobs;

CREATE TABLE work_mode_mart.remote_jobs AS 
SELECT
    j.job_title,
    j.company_id,
    j.job_location
FROM data_jobs.job_postings_fact AS j
WHERE
    j.job_work_from_home = TRUE
    AND
    j.job_location = 'Anywhere'
    ;

SELECT COUNT(*) FROM work_mode_mart.remote_jobs;

