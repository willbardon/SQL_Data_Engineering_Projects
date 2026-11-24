USE company_jobs;

UPDATE dev.applications_fact
SET internal_candidate = TRUE
WHERE application_id = 1;

SELECT * FROM dev.applications_fact;