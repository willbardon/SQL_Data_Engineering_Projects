WITH core_skills AS (
    SELECT
        skill_id,
        type AS skill_type
    FROM
        data_jobs.skills_dim
    WHERE
        type IN ('programming', 'databases')
            )

SELECT
    skill_type,
    COUNT(DISTINCT(job_id))
FROM
    data_jobs.skills_job_dim
    INNER JOIN
    core_skills ON data_jobs.skills_job_dim.skill_id = core_skills.skill_id
GROUP BY
    skill_type
ORDER BY
    COUNT(DISTINCT(job_id)) DESC;