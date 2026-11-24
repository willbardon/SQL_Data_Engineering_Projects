WITH job_skill_counts AS (
    SELECT
        jpf.job_id,
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS skill_count
    FROM
        job_postings_fact AS jpf
        INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    GROUP BY
        jpf.job_id,
        jpf.company_id
    ),
    company_avg_skill_counts AS (
        SELECT
            company_id,
            AVG(skill_count) AS avg_skills_per_company
        FROM
            job_skill_counts
        GROUP BY
            company_id
        )
SELECT
    js.job_id,
    js.skill_count,
    ca.avg_skills_per_company
FROM
    job_skill_counts AS js
    INNER JOIN company_avg_skill_counts AS ca ON ca.company_id = js.company_id
WHERE
    js.skill_count > ca.avg_skills_per_company
ORDER BY
    js.skill_count DESC
LIMIT 100;





