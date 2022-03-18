/* 
Difficulty: Medium
Company: Salesforce

New Products
You are given a table of product launches by company by year. Write a query to count the number 
of products launched by companies for 2020 compared to the previous year. Output the name of the 
companies and a count of net products released for 2020 compared to the previous year. If a company 
is new or had no products in 2019, then any product released in 2020 would be considered as new.

Table 1: car_launches
year <int>
company_name <varchar>
product_name <varchar>
*/

/* Solution - CTE*/
WITH y2020 AS(
SELECT company_name, COUNT(product_name) AS y2020_products
FROM car_launches
WHERE year = '2020'
GROUP BY 1
)
,
y2019 AS(
SELECT company_name, COUNT(product_name) AS y2019_products
FROM car_launches
WHERE year = '2019'
GROUP BY 1
)

SELECT y2020.company_name, (y2020_products - y2019_products) AS net_products
FROM y2020 FULL OUTER JOIN y2019
ON y2020.company_name = y2019.company_name


/* Solution 2 - CASE WHEN */
SELECT
company_name,
(COUNT(CASE WHEN year = '2020' THEN product_name ELSE NULL END) - 
COUNT(CASE WHEN year = '2019' THEN product_name ELSE NULL END)) AS net_products
FROM car_launches
GROUP BY 1