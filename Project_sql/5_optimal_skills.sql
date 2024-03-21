/*
5.  What are the most optimal skills to learn?
(High demand and high paying)
*/

SELECT
    skills_dim.skill_id,
    skills,
    COUNT(job_postings_fact.job_id) as demand_count,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL 
GROUP BY 
    skills_dim.skill_id, 
    skills
HAVING 
    COUNT(job_postings_fact.job_id) > 50
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 10;
