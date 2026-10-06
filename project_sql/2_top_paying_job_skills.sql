-- Identify the 10 highest-paying remote Data Analyst roles
WITH top_paying_jobs AS (
    SELECT
    jpf.job_id,
    jpf.job_title,
    cd.name AS company_name,
    jpf.job_country,
    jpf.salary_year_avg
FROM
    job_postings_fact jpf
LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_work_from_home = TRUE AND
    jpf.salary_year_avg IS NOT NULL
ORDER BY
    jpf.salary_year_avg DESC
LIMIT 10
)

-- Preserve all top-paying jobs, including those without recorded skill data
SELECT
    tpj.job_id,
    tpj.job_title,
    tpj.company_name,
    sd.skills,
    tpj.job_country,
    tpj.salary_year_avg
    

FROM top_paying_jobs tpj
LEFT JOIN skills_job_dim sjd ON tpj.job_id = sjd.job_id
LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
    tpj.salary_year_avg DESC;
