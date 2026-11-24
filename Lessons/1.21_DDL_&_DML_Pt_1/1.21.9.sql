UPDATE dev.applications_fact
SET date_applied = '2025-12-19'
WHERE application_id = 1;

UPDATE dev.applications_fact
SET date_applied = '2025-12-20'
WHERE application_id = 2;

UPDATE dev.applications_fact
SET date_applied = '2025-12-10'
WHERE application_id = 3;

UPDATE dev.applications_fact
SET date_applied = '2025-12-08'
WHERE application_id = 4;

SELECT application_id, date_applied FROM dev.applications_fact;