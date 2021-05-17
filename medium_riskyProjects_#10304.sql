/* 
Difficulty: Medium
Company: LinkedIn

Risky Projects
Identify projects that are at risk for going overbudget. A project is 
considered to be overbudget if the cost of all employees assigned to the project 
is greater than the budget of the project. You'll need to prorate the cost of the 
employees to the duration of the project. For example, if the budget for a project 
that takes half a year to complete is $10K, then the total half-year salary of all 
employees assigned to the project should not exceed $10K.

Output a list of projects that are overbudget with their project name, 
project budget, and prorated total employee expense (rounded to the next dollar amount).

Table 1: linkedin_projects
id <int>
title <varchar>
budget <int>
start_date <datetime>
end_date <datetime>

Table 2: linkedin_emp_projects
emp_id <int>
project_id <int>

Table 3: linkedin_employees
id <int>
first_name <varchar>
last_name <varchar>
salary <int>
*/

/* 
-------------------Thought process-------------------
1. Assuming that employee salaries are 'yearly'.
2. Figure out which employees were assigned to which projects
3. Figure out the duration of each project - to prorate employee budget
4. Group members + salary by projects
5. Calculate prorated expense
*/

WITH assigned_projects AS(
SELECT p.id, title, budget, start_date, end_date, emp_id, first_name,
last_name, salary
FROM linkedin_projects p
JOIN linkedin_emp_projects ep
ON p.id = ep.project_id
JOIN linkedin_employees e
ON ep.emp_id = e.id
)

SELECT title, budget, CEILING((sum(salary)/365)*(end_date-start_date)) AS prorated_employee_expense
FROM assigned_projects
GROUP BY title, budget, start_date, end_date
HAVING ((sum(salary)/365)*(end_date-start_date)) > budget
ORDER BY title ASC

/* Originally used ROUND(value, 0) function but was not accepted even though 
output matches exactly as answer. A work around was presented - to use the ceiling
function to round prorated expenses to next dollar amount */