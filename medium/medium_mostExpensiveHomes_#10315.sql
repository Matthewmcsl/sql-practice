/* 
Difficulty: Medium
Company: Zillow

Cities With The Most Expensive Homes
Write a query that identifies cities with higher than 
average home prices when compared to the national average. 
Output the city names.

Table 1: zillow_transactions
id <int>
state <varchar>
city <varchar>
street_address <varchar>
mkt_price <int>
*/

/* Solution */
-- 'HAVING' is used in placewhen trying to use the 'WHERE' keyword on an aggregate function
SELECT 
city
FROM zillow_transactions
GROUP BY 1
HAVING AVG(mkt_price) > 
    (SELECT AVG(mkt_price) FROM zillow_transactions)