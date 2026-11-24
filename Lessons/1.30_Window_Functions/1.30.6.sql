SELECT
*
FROM
    (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        ROW_NUMBER() OVER (PARTITION BY job_title_short) AS rank
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
    )
WHERE
    rank <= 3
    ;



