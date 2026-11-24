CREATE SCHEMA IF NOT EXISTS main;

CREATE OR REPLACE TABLE main.priority_jobs_snapshot (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR,
    priority_lvl INTEGER
);

INSERT INTO main.priority_jobs_snapshot (role_id, role_name, priority_lvl)
VALUES
    (1, 'Data Engineer', 2),
    (2, 'Senior Data Engineer', 1),
    (3, 'Software Engineer', 3),
    (4, 'Data Scientist', 3);

SELECT * FROM main.priority_jobs_snapshot;