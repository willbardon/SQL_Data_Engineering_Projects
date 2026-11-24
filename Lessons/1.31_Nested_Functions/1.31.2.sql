SELECT
    cd.name AS company_name,
    ARRAY_AGG(DISTINCT(jpf.job_location)) AS hiring_locations
FROM
    job_postings_fact AS jpf
    INNER JOIN company_dim AS cd ON cd.company_id=jpf.company_id
GROUP BY
    cd.name;