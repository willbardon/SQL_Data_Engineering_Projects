WITH job_skill_counts AS (
    SELECT
        jpf.job_id,
        jpf.job_title_short,
        ARRAY_LENGTH(ARRAY_AGG(sjd.skill_id)) AS skill_counts
    FROM
        job_postings_fact AS jpf
        JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    WHERE   
        jpf.job_title_short IN ('Data Engineer', 'Data Analyst')
    GROUP by
        jpf.job_id,
        jpf.job_title_short
)

SELECT
    job_title_short,
    AVG(skill_counts)
FROM 
    job_skill_counts
GROUP BY
    job_title_short;