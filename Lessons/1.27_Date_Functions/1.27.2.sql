SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_location,
    jpf.job_posted_date AT TIME ZONE 'UTC' AS job_posted_date_utc,
    jpf.job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'HST'AS job_posted_date_hst_10,
    jpf.job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'PST' AS job_posted_date_pst_08,
    jpf.job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'MST' AS job_posted_date_mst_07,
    jpf.job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'CST' AS job_posted_date_cst_06,
    jpf.job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS job_posted_date_est_05,
    jpf.job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'GMT'AS job_posted_date_gmt_00
FROM
    data_jobs.job_postings_fact AS jpf
WHERE
    jpf.job_country = 'United States';


