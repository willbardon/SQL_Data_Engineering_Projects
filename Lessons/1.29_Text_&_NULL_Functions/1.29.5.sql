SELECT
    name,
    LOWER(TRIM(name)) as normalized_name
FROM data_jobs.company_dim;