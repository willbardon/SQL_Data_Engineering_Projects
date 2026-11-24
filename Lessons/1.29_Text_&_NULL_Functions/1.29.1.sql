SELECT
    UPPER(name) AS standardized_company_name
FROM data_jobs.company_dim
ORDER BY standardized_company_name;