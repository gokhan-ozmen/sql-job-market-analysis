-- Calculate average salary by skill for Data Analyst roles with reported salaries
SELECT
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg)) as avg_salary,
    COUNT(DISTINCT jpf.job_id) as demand_count
FROM
    job_postings_fact jpf
JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL 
GROUP BY sd.skills

-- Require at least 10 job postings to reduce the influence of very small samples
HAVING COUNT(DISTINCT jpf.job_id) >= 10
ORDER BY avg_salary DESC
LIMIT 25;