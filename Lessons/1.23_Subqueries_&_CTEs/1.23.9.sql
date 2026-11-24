SELECT
    sd.skills
FROM
    data_jobs.skills_dim AS sd
WHERE
    NOT EXISTS(
        SELECT 1
        FROM data_jobs.job_postings_fact AS jpf
        JOIN data_jobs.skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
        WHERE jpf.job_title_short = 'Senior Data Engineer'
        AND
        sjd.skill_id = sd.skill_id
        );