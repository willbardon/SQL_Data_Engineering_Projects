CREATE DATABASE IF NOT EXISTS jobs_mart;



--DROP IF EXISTS DATABASE jobs_mart;

SELECT *FROM information_schema.schemata;


CREATE SCHEMA IF NOT EXISTS staging;



CREATE TABLE staging.preferred_roles (
    role_id INTEGER,
    role_name VARCHAR
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer');

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (3, 'Software Engineer');



ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT * FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role to priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;