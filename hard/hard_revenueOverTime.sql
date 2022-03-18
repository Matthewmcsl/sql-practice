/*
https://platform.stratascratch.com/coding/10314-revenue-over-time?python=

Revenue Over Time

Find the 3-month rolling average of total revenue from purchases given a 
table with users, their purchase amount, and date purchased. Do not include 
returns which are represented by negative purchase values. Output the 
year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from 
earliest month to latest month. 

A 3-month rolling average is defined by 
calculating the average total revenue from all user purchases for the 
current month and previous two months. The first two months will not be a 
true 3-month rolling average since we are not given data from last year. 
Assume each month has at least one purchase.
*/

#NOTE: MySql solution

WITH agg_revenue AS
(
    SELECT CONCAT_WS('-', yr, LPAD(mth,2,'0')) AS period, SUM(purchase_amt) as total_rev
    FROM(
        SELECT user_id, YEAR(created_at) as yr, MONTH(created_at) AS mth, purchase_amt
        FROM amazon_purchases
        WHERE purchase_amt > 0) tmp
    GROUP BY 1
    )

SELECT period, 
AVG(total_rev) OVER(ORDER BY period ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3_mth_avg
FROM agg_revenue
ORDER BY 1 ASC