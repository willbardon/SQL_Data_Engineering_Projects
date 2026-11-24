ALTER TABLE dev.applications_fact 
ADD COLUMN follow_up_timestamp TIMESTAMPTZ;

DESCRIBE dev.applications_fact;