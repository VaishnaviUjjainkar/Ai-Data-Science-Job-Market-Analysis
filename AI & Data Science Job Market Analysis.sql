CREATE DATABASE ai_job_project;
USE ai_job_project;

SELECT * FROM ai_job_market LIMIT 10;

-- Total records
SELECT COUNT(*) FROM ai_job_market;

-- Columns check
DESCRIBE ai_job_market;

-- Unique job roles
SELECT DISTINCT job_title FROM ai_job_market;

-- DATA VALIDATION --
-- Check nulls
SELECT COUNT(*) - COUNT(salary) AS missing_salary
FROM ai_job_market;

-- Check duplicates
SELECT job_title, COUNT(*)
FROM ai_job_market
GROUP BY job_title
HAVING COUNT(*) > 1;

-- CORE BUSINESS ANALYSIS --
-- 1. Demand Analysis
SELECT job_title, COUNT(*) AS demand
FROM ai_job_market
GROUP BY job_title
ORDER BY demand DESC;
-- Insight:- The analysis shows that certain job roles dominate the job market in terms of demand. Roles like Data Analyst, Data Scientist, and AI Engineer appear frequently, indicating that companies are actively hiring for these positions. This highlights the growing importance of data-driven decision-making across industries.--

-- 2. Salary Analysis
SELECT job_title, AVG(salary)
FROM ai_job_market
GROUP BY job_title
ORDER BY AVG(salary) DESC;
-- Insight:- The salary analysis reveals that technical roles such as AI Engineer and Machine Learning Engineer tend to offer higher average salaries compared to other roles. This indicates that advanced technical skills and specialization are highly valued in the market.

-- 3. Experience Analysis
SELECT experience_level, AVG(salary)
FROM ai_job_market
GROUP BY experience_level;
-- Insight:- There is a clear positive relationship between experience level and salary. Entry-level positions offer lower salaries, while mid-level and senior roles show a significant increase. This demonstrates strong career growth potential in the AI and data science field.


-- 4. Country Analysis
SELECT country, COUNT(*) AS jobs
FROM ai_job_market
GROUP BY country
ORDER BY jobs DESC;
-- Insight:- Some countries have a significantly higher number of job postings, indicating they are major hubs for AI and data science jobs. This suggests better job opportunities and stronger demand in those regions.

-- 5. Work Type Analysis
SELECT remote_type, AVG(salary)
FROM ai_job_market
GROUP BY remote_type;
-- Insight:- The salary comparison across remote, onsite, and hybrid roles shows that remote jobs are competitive in terms of salary. This indicates that companies are increasingly adopting flexible work models without compromising compensation.

-- ADVANCED ANALYSIS --
-- Window Function
SELECT job_title, avg_salary,
RANK() OVER (ORDER BY avg_salary DESC) AS rnk
FROM (
    SELECT job_title, AVG(salary) AS avg_salary
    FROM ai_job_market
    GROUP BY job_title
) t;
-- Insight:- Ranking job roles based on average salary helps identify the highest-paying roles in the industry. This provides valuable insight into which career paths offer the best financial rewards.

-- Salary Category Analysis(Subquery)
SELECT * FROM ai_job_market
WHERE salary > (SELECT AVG(salary) FROM ai_job_market);
-- Insight:- Only a subset of jobs offer salaries above the overall average. These positions are typically associated with higher skill requirements and experience levels, making them more competitive.

-- Above Average Salary Jobs(CASE WHEN)
SELECT CASE WHEN salary > 100000 THEN 'High'
WHEN salary > 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_category,
COUNT(*)
FROM ai_job_market
GROUP BY salary_category;

-- SKILLS ANALYSIS 
SELECT SUM(skills_python),
SUM(skills_sql),
SUM(skills_ml)
FROM ai_job_market;
-- Insight:- The analysis shows that skills like Python, SQL, and Machine Learning are widely required across job postings. This highlights their importance as core technical skills in the AI and data science domain.

-- TIME ANALYSIS 
SELECT job_posting_year, COUNT(*)
FROM ai_job_market
GROUP BY job_posting_year;
-- Insight:- The year-wise job posting trend indicates growth in job opportunities over time. This reflects the rapid expansion of the AI and data science industry.

-- SQL-Based Analytical Study of AI & Data Science Job Market --

-- 1.A company wants to expand globally and needs to understand hiring trends. Identify the top 3 most in-demand job roles in each country so that the company can focus on high-demand roles in each region.
SELECT country, job_title, demand
FROM (
    SELECT country, job_title, COUNT(*) AS demand,
           RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rnk
    FROM ai_job_market
    GROUP BY country, job_title
) t
WHERE rnk <= 3;

-- 2.An HR team wants to identify which job roles are growing over time. Analyze year-wise job postings and find roles that show increasing demand.
SELECT job_title, job_posting_year, COUNT(*) AS jobs
FROM ai_job_market
GROUP BY job_title, job_posting_year
ORDER BY job_title, job_posting_year;

-- 3.A company wants to hire efficiently based on experience levels. Identify the most demanded job role for each experience level (Entry, Mid, Senior).
SELECT experience_level, job_title, demand
FROM (
    SELECT experience_level, job_title, COUNT(*) AS demand,
           RANK() OVER (PARTITION BY experience_level ORDER BY COUNT(*) DESC) AS rnk
    FROM ai_job_market
    GROUP BY experience_level, job_title
) t
WHERE rnk = 1;

-- 4.A company is planning to adopt remote work policies. Analyze which countries have the highest percentage of remote jobs.
SELECT country,
SUM(CASE WHEN remote_type='Remote' THEN 1 ELSE 0 END)*100.0/COUNT(*) AS remote_pct
FROM ai_job_market
GROUP BY country;

-- 5. Identify the top 10 highest-paying job roles to understand premium opportunities in the job market.
SELECT job_title, salary
FROM ai_job_market
ORDER BY salary DESC
LIMIT 10;

-- 6. Identify job roles with the highest average salary to understand which roles are financially rewarding.
SELECT job_title, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY job_title
ORDER BY avg_salary DESC
LIMIT 10;

-- 7. HR wants to understand which roles have stable salaries. Analyze salary variation (standard deviation) for each job role.
SELECT job_title, STDDEV(salary) AS salary_variation
FROM ai_job_market
GROUP BY job_title;

-- 8. Identify job roles where salary varies significantly, indicating high-risk, high-reward opportunities.
SELECT job_title, STDDEV(salary) AS variance
FROM ai_job_market
GROUP BY job_title
ORDER BY variance DESC;

-- 9. Analyze how combinations of skills (Python, SQL, ML) impact salary and identify highest-paying skill combinations.
SELECT skills_python, skills_sql, skills_ml,
AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY skills_python, skills_sql, skills_ml
ORDER BY avg_salary DESC
LIMIT 5;

-- 10. Identify which skills are most common among above-average salary jobs.
SELECT SUM(skills_python) AS python,
SUM(skills_sql) AS sql_count,
SUM(skills_ml) AS ml
FROM ai_job_market
WHERE salary > (SELECT AVG(salary) FROM ai_job_market);

-- 11. Freshers want to know which skills to learn. Identify the most required skills for entry-level jobs.
SELECT SUM(skills_python),
SUM(skills_sql),
SUM(skills_ml)
FROM ai_job_market
WHERE experience_level='Entry';

-- 12. Companies want multi-skilled candidates. Calculate the percentage of jobs requiring 3 or more skills.
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ai_job_market) AS percentage
FROM ai_job_market
WHERE skills_python + skills_sql + skills_ml >= 3;

-- 13. Analyze how salary increases with experience to understand career growth potential.
SELECT experience_level, AVG(salary)
FROM ai_job_market
GROUP BY experience_level;

-- 14. Identify which experience level has the highest number of job openings.
SELECT experience_level, SUM(job_openings)
FROM ai_job_market
GROUP BY experience_level
ORDER BY SUM(job_openings) DESC;

-- 15. Identify the highest-paying job role in each country to understand regional salary trends.
SELECT country, job_title, salary
FROM (
    SELECT country, job_title, salary,
    RANK() OVER (PARTITION BY country ORDER BY salary DESC) AS rnk
    FROM ai_job_market
) t
WHERE rnk = 1;

-- 16. Analyze how job demand for different roles has changed over the years.
SELECT job_title, job_posting_year, COUNT(*) AS demand
FROM ai_job_market
GROUP BY job_title, job_posting_year
ORDER BY job_title, job_posting_year;

-- 17. Compare the average salary difference between remote and onsite job roles.
SELECT MAX(CASE WHEN remote_type = 'Remote' THEN avg_salary END) -
MAX(CASE WHEN remote_type = 'Onsite' THEN avg_salary END) AS salary_difference
FROM (
    SELECT remote_type, AVG(salary) AS avg_salary
    FROM ai_job_market
    GROUP BY remote_type
) t;

-- 18. Identify which combination of skills leads to higher salaries.
SELECT skills_python, skills_sql, skills_ml, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY skills_python, skills_sql, skills_ml
ORDER BY avg_salary DESC
LIMIT 5;

-- 19. Identify job roles with the highest number of openings.
SELECT job_title, SUM(job_openings) AS total_openings
FROM ai_job_market
GROUP BY job_title
ORDER BY total_openings DESC
LIMIT 10;

-- 20. Identify countries that offer the highest average salary for AI and data science jobs.
SELECT country, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY country
ORDER BY avg_salary DESC
LIMIT 10;

-- 21. Calculate the percentage of job postings requiring each skill.
SELECT 
(SUM(skills_python)/COUNT(*))*100 AS python_percent,
(SUM(skills_sql)/COUNT(*))*100 AS sql_percent,
(SUM(skills_ml)/COUNT(*))*100 AS ml_percent
FROM ai_job_market;

-- 22. Identify which experience level earns the highest salary for each job role.
SELECT job_title, experience_level, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY job_title, experience_level
ORDER BY job_title, avg_salary DESC;

-- 23. Identify job roles that offer both high demand and high salary.
SELECT job_title, COUNT(*) AS demand, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY job_title
HAVING COUNT(*) > 100
ORDER BY avg_salary DESC;

-- 24. Analyze job roles that have shown consistent growth in demand over the years and also offer high average salaries. The goal is to identify roles that are both trending and financially rewarding.
SELECT job_title,
COUNT(*) AS total_jobs,
AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY job_title
HAVING COUNT(*) > 100
AND AVG(salary) > (SELECT AVG(salary) FROM ai_job_market)
ORDER BY total_jobs DESC, avg_salary DESC;

-- 25. Evaluate how possessing multiple skills (Python, SQL, and Machine Learning) impacts both salary levels and job availability compared to jobs requiring fewer skills.
SELECT 
(skills_python + skills_sql + skills_ml) AS total_skills,
COUNT(*) AS job_count,
AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY total_skills
ORDER BY total_skills DESC;

-- 26. Analyze how salary has changed over the years for different experience levels to understand career growth trends in the AI job market.
SELECT experience_level, job_posting_year, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY experience_level, job_posting_year
ORDER BY experience_level, job_posting_year;

-- 27. Evaluate whether job roles with higher demand also offer higher salaries, or if there is a trade-off between demand and salary.
SELECT job_title, COUNT(*) AS demand, AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY job_title
ORDER BY demand DESC, avg_salary DESC;

-- 28. Identify high-demand job roles and analyze which key skills are missing or less common in those roles.
SELECT job_title,
COUNT(*) AS demand,
AVG(skills_python) AS python_req,
AVG(skills_sql) AS sql_req,
AVG(skills_ml) AS ml_req
FROM ai_job_market
GROUP BY job_title
ORDER BY demand DESC;

-- 29. Analyze how job opportunities are distributed across countries and job roles to identify major hiring hubs.
SELECT country, job_title, COUNT(*) AS job_count
FROM ai_job_market
GROUP BY country, job_title
ORDER BY job_count DESC;

-- 30. Analyze how high-paying jobs are distributed based on the number of skills required.
SELECT 
(skills_python + skills_sql + skills_ml) AS total_skills,
COUNT(*) AS job_count,
AVG(salary) AS avg_salary
FROM ai_job_market
WHERE salary > (SELECT AVG(salary) FROM ai_job_market)
GROUP BY total_skills
ORDER BY total_skills DESC;

-- Creation of View for Reusable Analysis --
CREATE VIEW job_summary AS
SELECT job_title, 
       COUNT(*) AS demand, 
       AVG(salary) AS avg_salary
FROM ai_job_market
GROUP BY job_title;

SELECT * FROM job_summary;

-- Data Transformation --
SELECT *, (skills_python + skills_sql + skills_ml) AS total_skills
FROM ai_job_market;

-- Stored Procedure for Dynamic Salary-Based Filtering --
DELIMITER //

CREATE PROCEDURE GetHighSalaryJobs(IN min_salary INT)
BEGIN
    SELECT *
    FROM ai_job_market
    WHERE salary >= min_salary;
END //

DELIMITER ;

CALL GetHighSalaryJobs(80000);

-- Trigger for Automatic Salary Categorization --
ALTER TABLE ai_job_market 
ADD salary_category VARCHAR(20);

DELIMITER //

CREATE TRIGGER salary_category_trigger
BEFORE INSERT ON ai_job_market
FOR EACH ROW
BEGIN
    IF NEW.salary > 100000 THEN
        SET NEW.salary_category = 'High';
    ELSEIF NEW.salary > 50000 THEN
        SET NEW.salary_category = 'Medium';
    ELSE
        SET NEW.salary_category = 'Low';
    END IF;
END //

DELIMITER ;

-- Temporary Table for Intermediate Analysis --
CREATE TEMPORARY TABLE high_salary_jobs AS
SELECT * FROM ai_job_market
WHERE salary > (SELECT AVG(salary) FROM ai_job_market);

-- Advanced Join for Comparative Analysis --
SELECT a.job_title, a.salary, b.avg_salary
FROM ai_job_market a
JOIN (
    SELECT job_title, AVG(salary) AS avg_salary
    FROM ai_job_market
    GROUP BY job_title
) b
ON a.job_title = b.job_title;

-- Key Performance Indicators (KPI) Analysis --
SELECT COUNT(*) AS total_jobs,
AVG(salary) AS avg_salary,
MAX(salary) AS highest_salary,
MIN(salary) AS lowest_salary
FROM ai_job_market;

/* The comprehensive SQL-based analysis of the AI and Data Science job market dataset 
reveals several important trends related to job demand, salary distribution, skills 
requirements, and hiring patterns across different regions and experience levels.

The demand analysis indicates that roles such as Data Analyst, Data Scientist, and 
AI Engineer dominate the job market, highlighting the increasing reliance of organizations 
on data-driven decision-making. Country-level analysis further shows that certain regions 
act as major hiring hubs, offering a higher number of job opportunities compared to others.

Salary analysis demonstrates a strong relationship between experience level and compensation, 
where senior-level professionals earn significantly higher salaries compared to entry-level 
candidates. Additionally, specialized roles such as Machine Learning Engineer and AI Engineer 
tend to offer higher average salaries, indicating the premium value of advanced technical expertise.

Work type analysis reveals that remote and hybrid roles are becoming increasingly common and 
offer competitive salaries, suggesting a shift towards flexible work environments in the industry.

Skill-based analysis highlights that Python, SQL, and Machine Learning are the most in-demand 
technical skills across job postings. Furthermore, jobs requiring multiple skills tend to offer 
higher salaries, emphasizing the importance of being multi-skilled in the current job market.

Advanced SQL techniques such as window functions, subqueries, and aggregations were used to 
identify high-paying roles, top-performing job categories, and salary distribution patterns. 
Business-focused queries further helped in identifying the best career opportunities that offer 
both high demand and above-average salaries.

Time-based analysis shows a steady growth in job postings over the years, reflecting the rapid 
expansion of the AI and Data Science domain. This trend indicates strong future potential and 
increasing demand for skilled professionals in this field.

Overall, the analysis concludes that the AI and Data Science job market is highly dynamic and 
offers significant career opportunities for individuals who possess the right combination of 
technical skills, experience, and adaptability to industry trends./*























































