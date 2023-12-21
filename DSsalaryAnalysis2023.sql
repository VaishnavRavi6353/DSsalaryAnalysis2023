-- Visulaizing data
select * from DSsalary2023..ds_salaries

-- Avereage salary(in USD) for each job 
select job_title,avg(salary_in_usd) as avgsalary
from DSsalary2023..ds_salaries
group by job_title 
order by avgsalary desc 

-- Maximum salary(in USD) for each job 
select job_title,max(salary_in_usd) as maxsalary
from DSsalary2023..ds_salaries
group by job_title 
order by maxsalary desc 

-- Different Job
select distinct(job_title)
from DSsalary2023..ds_salaries

--Maximum and Average Salary For Each Year
select work_year,job_title,max(salary_in_usd) as maxsalary,
avg(salary_in_usd) as avgsalary, count(job_title) 
over (partition by job_title) as NoOfEmployee
from DSsalary2023..ds_salaries
group by work_year,job_title 
order by work_year desc

--Avg salary based on company size per job post
select job_title, company_size, 
COUNT(job_title) over (partition by job_title) as NoOfCompanies, 
avg(salary_in_usd) AS AvgSalary
from DSsalary2023..ds_salaries
group by job_title,company_size
order by job_title,company_size


--Creating temp table 
drop table if exists #tableForExport
CREATE TABLE #tableForExport
(job_title varchar(100),company_size varchar(50), NoOfComapnies int, AvgSalary int)
select job_title, company_size, 
COUNT(job_title) over (partition by job_title) as NoOfCompanies, 
avg(salary_in_usd) AS AvgSalary
from DSsalary2023..ds_salaries
group by job_title,company_size
order by job_title,company_size


select * from #tableForExport
