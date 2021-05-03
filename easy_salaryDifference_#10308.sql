/* 
Difficulty: Easy
Company: Dropbox

Salary Differences
Write a query that calculates the difference between the highest salaries found 
in the marketing and engineering departments. Output just the difference in salaries.


Table 1: db_employee

id <int>
first_name <varchar>
last_name <varchar>
salary <int>
department_id <int>

Table 2: db_dept
id <int>
department <varchar>
*/

/* Solution 1 */
WITH main_list AS (
    SELECT 
    distinct(department),
    max(salary) as salary, 
    dense_rank() OVER (ORDER BY max(salary) desc)
    FROM db_employee e 
    INNER JOIN db_dept d
    ON e.department_id = d.id
    GROUP BY department
)

SELECT
    (SELECT salary 
    FROM main_list 
    WHERE department = 'marketing') 
- 
    (SELECT salary 
    FROM main_list
    where department = 'engineering')

AS salary_difference


/* Solution 2 */
WITH merged_db AS(
    SELECT 
    distinct (department),
    max(salary) as highest_salary
    FROM db_employee e
    INNER JOIN db_dept d
    ON e.department_id = d.id
    WHERE department IN ('engineering', 'marketing')
    GROUP BY department
)

SELECT(
    ABS(
        (SELECT highest_salary
        FROM merged_db
        ORDER by 1 DESC 
        LIMIT 1)
        - 
        (SELECT highest_salary
        FROM merged_db
        ORDER BY 1 ASC
        LIMIT 1)
        )
) 

AS salary_difference
