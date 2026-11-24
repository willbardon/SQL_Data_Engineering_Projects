WITH company_skill_counts AS (
        SELECT
            jpf.company_id,
            ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS skill_count
        FROM
            job_postings_fact AS jpf
            INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
        GROUP BY
            jpf.company_id
        ),
     company_name_cte AS (
        SELECT
            csc.company_id,
            cd.name AS company_name,
            DENSE_RANK() OVER(ORDER BY csc.skill_count DESC) AS skill_rank
        FROM
            company_skill_counts AS csc
            INNER JOIN company_dim AS cd ON cd.company_id = csc.company_id
     )
SELECT
    company_name,
    skill_rank
FROM
    company_name_cte
WHERE
    skill_rank <= 10;
