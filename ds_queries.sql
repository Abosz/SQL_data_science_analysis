SELECT * FROM ds_salaries;

-- Chcecking for missing values
SELECT COUNT(*)
FROM ds_salaries ds 
WHERE job_title IS NULL;

SELECT COUNT(*)
FROM ds_salaries ds 
WHERE salary_in_usd IS NULL;

-- We have most of the data from year 2023
SELECT DISTINCT work_year, COUNT(job_title) AS Quantity
FROM ds_salaries ds
GROUP BY work_year
ORDER BY Quantity DESC;

-- The hishest salary in USD is on senior level. 
SELECT experience_level AS ExpLevel, avg(salary_in_usd) AS AvgSalary
FROM ds_salaries
GROUP BY ExpLevel
ORDER BY AvgSalary DESC;

-- Added max and min salary to [revious query]
SELECT experience_level AS ExpLevel, 
AVG(salary_in_usd) AS AvgSalary,
MAX(salary_in_usd) AS MaxSalary,
MIN(salary_in_usd) AS MinSalary
FROM ds_salaries
GROUP BY ExpLevel
ORDER BY AvgSalary DESC;


-- Senior position are mostly remote.
SELECT experience_level AS ExpLevel, COUNT(remote_ratio) AS Remote
FROM ds_salaries
GROUP BY experience_level
ORDER BY Remote DESC;

-- Most of specialist are Data Engineers. 
SELECT job_title AS Job,
COUNT(job_title) AS Quantity
FROM ds_salaries ds 
GROUP BY Job
ORDER BY Quantity DESC;

-- Avg salary on each position
SELECT job_title AS Job,
COUNT(job_title) AS Quantity,
AVG(salary_in_usd) AS AvgSalary
FROM ds_salaries ds 
GROUP BY Job
ORDER BY Quantity DESC;

-- Most of companies are located in United States.
SELECT company_location,
COUNT(job_title) AS Quantity
FROM ds_salaries ds 
GROUP BY company_location
ORDER BY Quantity DESC;

-- Same for companies with highest number of Data Scietists.
SELECT company_location,
COUNT(job_title) AS Quantity
FROM ds_salaries ds 
WHERE job_title = "Data Scientist"
GROUP BY company_location
ORDER BY Quantity DESC;

-- Also for Data Analyst.
SELECT company_location,
COUNT(job_title) AS Quantity
FROM ds_salaries ds 
WHERE job_title = "Data Analyst"
GROUP BY company_location
ORDER BY Quantity DESC;

--And Data Engineers.
SELECT company_location,
COUNT(job_title) AS Quantity
FROM ds_salaries ds 
WHERE job_title = "Data Engineer"
GROUP BY company_location
ORDER BY Quantity DESC;

-- FT as emloypment type is most popular.
SELECT employment_type, COUNT(job_title) AS Quantity
FROM ds_salaries ds 
GROUP BY  employment_type
ORDER BY Quantity DESC;

-- Most of roles are stationary work, but there are only 300 less position fully remote positions.
SELECT remote_ratio,
COUNT(job_title) AS Quantity
FROM ds_salaries ds
GROUP BY remote_ratio
ORDER BY Quantity DESC;

-- Creating VIEW for data scientist, data analyst, data engineers only.
CREATE VIEW SAE AS 
SELECT *
FROM ds_salaries ds 
WHERE job_title IN ("Data Scientist", "Data Analyst", "Data Engineer");

-- Checking how avg salary is distributed in data analyst field in US.
SELECT experience_level,
job_title,
salary_in_usd,
AVG(salary_in_usd) OVER(PARTITION BY experience_level ORDER BY salary_in_usd) AS AvgSalary
FROM SAE
WHERE job_title = "Data Analyst" AND company_location = "US";

-- Similar for Data Scientist role...
SELECT experience_level,
job_title,
salary_in_usd,
AVG(salary_in_usd) OVER(PARTITION BY experience_level ORDER BY salary_in_usd) AS AvgSalary
FROM SAE
WHERE job_title = "Data Scientist" AND company_location = "US";

-- ... and Data Engineers.
SELECT experience_level,
job_title,
salary_in_usd,
AVG(salary_in_usd) OVER(PARTITION BY experience_level ORDER BY salary_in_usd) AS AvgSalary
FROM SAE
WHERE job_title = "Data Engineer" AND company_location = "US";

