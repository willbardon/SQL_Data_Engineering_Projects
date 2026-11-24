INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl) 
    VALUES
    (77,'aws',3);

MERGE INTO main.job_skill_priorities AS tgt
USING
    (SELECT *
    FROM staging.priority_skills AS ps
    LEFT JOIN data_jobs.skills_job_dim AS sjd ON
    sjd.skill_id = ps.skill_id
    ) AS src
ON tgt.skill_id = src.skill_id AND tgt.job_id = src.job_id

WHEN MATCHED AND tgt.priority_lvl IS DISTINCT FROM src.priority_lvl THEN
    UPDATE SET
        priority_lvl = src.priority_lvl,
        skill_name = src.skill_name

WHEN NOT MATCHED THEN
INSERT (
    job_id,
    skill_id,
    skill_name,
    priority_lvl,
    status
    
)

VALUES
(
    src.job_id,
    src.skill_id,
    src.skill_name,
    src.priority_lvl,
    'NEW_SKILL'
);

SELECT * FROM main.job_skill_priorities ORDER BY job_id;

SELECT * FROM staging.priority_skills;