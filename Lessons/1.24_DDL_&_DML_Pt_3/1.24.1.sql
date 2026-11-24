CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.priority_skills (
    skill_id INT PRIMARY KEY,
    skill_name TEXT,
    priority_lvl INT
);

DROP TABLE staging.priority_skills;

INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl) VALUES
    (1, 'python', 1),
    (0, 'sql', 1),
    (183, 'tableau', 2);

SELECT * FROM information_schema.schemata;

SELECT * FROM staging.priority_skills;