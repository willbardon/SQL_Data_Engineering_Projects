SELECT
    jpf.job_id,
    jpf.job_title,
    jpf.salary_year_avg,
    CASE
        WHEN jpf.job_title LIKE '%Senior%' OR jpf.job_title LIKE '%Lead%' OR jpf.job_title LIKE '%Manager%' THEN 'Senior/Lead/Manager'
        WHEN jpf.job_title LIKE '%Junior%' OR jpf.job_title LIKE '%Entry%' THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE    
        WHEN jpf.job_work_from_home = TRUE THEN 'Yes'
        ELSE 'No'
    END AS remote_option
FROM data_jobs.job_postings_fact AS jpf
WHERE salary_year_avg IS NOT NULL
ORDER BY jpf.job_id;