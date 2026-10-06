-- Identify the most in-demand skills across all Data Analyst job postings
SELECT 
    sd.skills,
    COUNT(DISTINCT sjd.job_id) AS demand_count
FROM
    job_postings_fact jpf
JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 5;





