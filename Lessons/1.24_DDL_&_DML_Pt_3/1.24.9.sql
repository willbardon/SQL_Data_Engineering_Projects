DELETE FROM staging.priority_skills WHERE skill_id = 1;

MERGE INTO main.job_skill_priorities AS tgt
USING (
    SELECT *
    FROM staging.priority_skills AS ps
        INNER JOIN data_jobs.skills_job_dim AS sjd ON ps.skill_id = sjd.skill_id
) AS src

ON tgt.job_id = src.job_id AND tgt.skill_id = src.skill_id

WHEN MATCHED AND tgt.skill_id IS DISTINCT FROM src.skill_id THEN
UPDATE SET
    priority_lvl = src.priority_lvl

WHEN NOT MATCHED THEN
    INSERT (
    job_id,
    skill_id,
    skill_name,
    priority_lvl,
    status
    )

VALUES(
    src.job_id,
    src.skill_id,
    src.skill_name,
    src.priority_lvl,
    'NEW SKILL'
)

WHEN NOT MATCHED BY SOURCE THEN DELETE;

SELECT * FROM main.job_skill_priorities WHERE skill_id = 1;