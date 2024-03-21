# Introduction
## Exploring Data (Analyst) Job Market Trends in 2023📊🔍

👋 Welcome to our project focused on analyzing the job 📈 dynamics for data roles in the year 2023! Through this exploration, we aim to provide valuable insights into various aspects of the data job landscape. Key questions addressed include identifying the top-paying jobs 💰, understanding the essential skills required for these roles, uncovering the most in-demand skills 🔍, and identifying optimal skill acquisition pathways 🛣️. Leveraging a comprehensive dataset comprising job postings, company details, and skill information, we employ SQL queries to extract pertinent insights and guide professionals and enthusiasts in navigating the dynamic data job market effectively. Let's dive in and uncover the trends shaping the future of data careers! 🚀.

🔍SQL queries? Check them here: [Project_sql_folder](/Project_sql/) 

# Background

My quest for career advancement leads me to explore the job market in 2023. 🚀 Driven by curiosity and determination, I delve into data on job postings, company profiles, and skill requirements. Through challenges and discoveries, I uncover top-paying roles for Data Analyst, essential skills, and market trends, 📊 emerging not only as a skilled professional but also as a guide for others navigating the dynamic data job landscape. 🌟

Data hails from [Luke Barousse's SQL Course](https://lukebarousse.com/sql).

## The questions I wanted to answer through my SQL queries were:
1. What are the top-paying jobs for a Data Analyst?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for these roles?
4. What are the most in-demand skills for Data Analyst role?
5. What are the most optimal skills to learn?


# Tools I used 
I used the following tools
- **SQL:** Leveraged SQL queries to extract insights from the dataset, enabling efficient data analysis and exploration.
  
- **Postgres:** Utilized PostgreSQL as the database management system to store and manage the dataset, ensuring reliability and scalability.
  
- **VSCode:** Employed Visual Studio Code as the integrated development environment (IDE) for writing SQL scripts and managing project files, enhancing productivity and code readability.
  
- **Git:** Utilized Git for version control, allowing for collaborative development and tracking changes made to project files over time, ensuring project integrity and facilitating seamless collaboration.

# The analysis
Each query seeks to investigate specific aspects of the Data Analyst job market. Breakdown of the approach used 👇

## 1. Top-paying jobs for Data Analyst
In the provided SQL query, I extracted data from the "job_postings_fact" table, joining it with the "company_dim" table based on the company ID. Filtering criteria were applied to retrieve information specifically related to the job title "Data Analyst," with a non-null average yearly salary and a location specified as "Anywhere." The results were then sorted in descending order based on the average yearly salary and limited to the top 20 records.

```sql
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
INNER JOIN company_dim ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 20
```
### Summary of the result
The query returned a list of the top-paying jobs with the title "Data Analyst," along with their respective average yearly salaries and company names. The results showcase a variety of roles, ranging from traditional data analyst positions to director-level roles and specialized positions in analytics and data science. Companies such as Mantys, Meta, AT&T, and others offer competitive salaries for data-related roles, reflecting the demand for skilled professionals in this domain.

## 2. Skills required for the top-paying jobs

This SQL code retrieves data related to the top-paying Data Analyst jobs, focusing on those with a specified job title, location, and non-null average yearly salary. It first selects job details such as ID, title, salary, and company name from the [`job_postings_fact`](https://lukebarousse.com/sql) table, joining it with the [`company_dim`](https://lukebarousse.com/sql) table. The results are filtered and ordered by salary, limited to the top 20 highest-paying jobs. Then, it joins this dataset with the [`skills_job_dim`](https://lukebarousse.com/sql) and [`skills_dim`](https://lukebarousse.com/sql) tables to include the skills associated with each job. Finally, it selects the relevant columns and orders the result by salary.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT(20))

SELECT 
    top_paying_jobs.*,
    skills 
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
LIMIT 20
```
![Top Paying Roles](Images\Top_skills1.png)

### Insights

The result includes details of the top-paying Data Analyst jobs along with the skills required for each job. From the provided snippet, it's evident that skills such as SQL, Python, R, Azure, AWS, Excel, and others are in demand among these high-paying roles. This insight is valuable for individuals looking to pursue or advance their careers in data analysis, as it highlights the skills that are highly sought after in the current job market.

## 3. Most in-demand skills for these roles?
The SQL code below selects the top 10 most in-demand skills for the job title "Data Analyst" with a requirement for remote work. It achieves this by joining three tables: `job_postings_fact`, `skills_job_dim`, and `skills_dim` based on their respective IDs (`job_id` and `skill_id`). It then counts the occurrences of each skill in the job postings for data analyst roles that allow remote work and presents the results in descending order by the count of job postings that mention each skill. Finally, it limits the output to only the top 10 skills.

```sql
SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 10

```

### Result
| skills      | demand_count |
|-------------|--------------|
| sql         | 7291         |
| excel       | 4611         |
| python      | 4330         |
| tableau     | 3745         |
| power bi    | 2609         |
| r           | 2142         |
| sas         | 1866         |
| looker      | 868          |
| azure       | 821          |
| powerpoint  | 819          |

### Insights

The analysis of the result would provide insight into the most sought-after skills for remote data analyst positions. This information can be valuable for individuals seeking to enhance their skills for career advancement or for companies looking to tailor their hiring strategies to meet market demands.
## 4. What are the most in-demand skills for Data Analyst role?
This SQL code retrieves the average annual salary for Data Analyst positions that allow remote work, grouped by specific skills. It calculates the average salary by joining three tables: `job_postings_fact`, `skills_job_dim`, and `skills_dim`, based on their respective IDs (`job_id` and `skill_id`). It filters out records where the average salary is not available (`salary_year_avg IS NOT NULL`), and limits the search to Data Analyst roles that offer remote work (`job_work_from_home = TRUE`). Then, it groups the results by skills and orders them by the average salary in descending order, displaying the top 20 skills.

## 5. What are the most optimal skills to learn?



The analysis of the result provides insights into the skills that are associated with higher average salaries for remote Data Analyst positions. This information can be valuable for individuals looking to specialize or upskill in certain areas to potentially command higher salaries, and for companies to understand the market value of specific skill sets when hiring for remote Data Analyst roles.
# What I learnt

# Conclusions

