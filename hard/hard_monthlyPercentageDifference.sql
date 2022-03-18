/*
https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?python=

Monthly Percentage Difference

Given a table of purchases by date, calculate the month-over-month percentage change 
in revenue. The output should include the year-month date (YYYY-MM) and percentage 
change, rounded to the 2nd decimal point, and sorted from the beginning of the year 
to the end of the year.

The percentage change column will be populated from the 2nd month forward and can 
be calculated as:
((this month's revenue - last month's revenue) / last month's revenue)*100.
*/

#NOTE: MySql solution

WITH agg AS(
    SELECT *, 
        COALESCE(LAG(this_mth, 1) OVER(ORDER BY date), 0) AS prev_mth
    FROM(
        SELECT 
        DATE_FORMAT(created_at, '%Y-%m') AS date,
        SUM(value) as this_mth
        FROM sf_transactions
        GROUP BY 1) t
)

SELECT date, ROUND(((this_mth - prev_mth)/ prev_mth)*100,2) AS pct_change 
FROM agg
ORDER BY 1 ASC