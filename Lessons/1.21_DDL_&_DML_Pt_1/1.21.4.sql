USE company_jobs;
CREATE TABLE IF NOT EXISTS dev.applications_fact (
    application_id INT PRIMARY KEY,
    candidate_id INT,
    job_id INT,
    date_applied DATE,
    application_status TEXT,
    internal_candidate BOOLEAN
);
SELECT * FROM dev.applications_fact;