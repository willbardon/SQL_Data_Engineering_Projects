CREATE TEMP TABLE ds_skills_count_temp AS
SELECT
    sd.skills,
    COUNT(jpf.job_id)
FROM
    data_jobs.job_postings_fact AS jpf
    LEFT JOIN
    data_jobs.skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    LEFT JOIN
    data_jobs.skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Scientist'
GROUP BY sd.skills;

SELECT * FROM ds_skills_count_temp;
USE company_jobs;