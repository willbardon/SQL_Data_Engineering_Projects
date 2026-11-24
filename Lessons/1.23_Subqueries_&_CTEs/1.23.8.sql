SELECT
    jpf.job_id,
    jpf.job_title_short
FROM
    data_jobs.job_postings_fact AS jpf
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND
    EXISTS(
        SELECT 1
        FROM data_jobs.skills_job_dim AS sjd
        LEFT JOIN data_jobs.skills_dim AS sd  ON sjd.skill_id = sd.skill_id
        WHERE 
            sjd.job_id = jpf.job_id
            AND
            sd.skills = 'python');

