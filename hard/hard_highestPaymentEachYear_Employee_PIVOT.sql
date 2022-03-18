/*
https://platform.stratascratch.com/coding/10145-make-a-pivot-table-to-find-the-highest-payment-in-each-year-for-each-employee?python=

Make a pivot table to find the highest payment in each year for each employee

Make a pivot table to find the highest payment in each year for each employee.
Find payment details for 2011, 2012, 2013, and 2014. 
Output payment details along with the corresponding employee name.
Order records by the employee name in ascending order
*/

SELECT 
    employeename,
    MAX(CASE WHEN year = '2011' THEN totalpay ELSE 0 END) AS pay_2011,
    MAX(CASE WHEN year = '2012' THEN totalpay ELSE 0 END) AS pay_2012,
    MAX(CASE WHEN year = '2013' THEN totalpay ELSE 0 END) AS pay_2013,
    MAX(CASE WHEN year = '2014' THEN totalpay ELSE 0 END) AS pay_2014
FROM sf_public_salaries
GROUP BY 1
ORDER BY 1 ASC