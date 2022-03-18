/* 
Difficulty: Medium
Company: Microsoft

Expensive Projects
Given a list of projects and employees mapped to each project, calculate by the 
amount of project budget allocated to each employee . The output should include the 
project title and the project budget per employee as an integer. Order your list by 
projects with the highest budget per employee first.

Table 1: ms_projects
id <int>
title <varchar>
budget <int>

Table 2: ms_emp_projects
emp_id <int>
project_id <int>
*/

/* Solution */
SELECT title, (budget/count(emp_id)) AS budget_emp_ratio
FROM ms_projects p
JOIN ms_emp_projects ep
ON p.id = ep.project_id
GROUP BY title, budget
ORDER by 2 DESC