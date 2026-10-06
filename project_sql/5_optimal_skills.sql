-- Analyze remote Data Analyst roles with reported salaries
-- Group by skill name to avoid duplicate skill names stored under different skill IDs
SELECT
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg)) as avg_salary,
    COUNT(DISTINCT sjd.job_id) as demand_count
 FROM job_postings_fact jpf
 JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
 JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
 WHERE 
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL AND
    jpf.job_work_from_home = TRUE
GROUP BY sd.skills

-- Exclude low-demand skills to focus on more established market signals
HAVING COUNT(DISTINCT sjd.job_id) > 25
ORDER BY
     avg_salary DESC,
     demand_count DESC
LIMIT 25;
