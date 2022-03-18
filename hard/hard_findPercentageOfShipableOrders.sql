/*
https://plahttps://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders?python=tform.stratascratch.com/coding/10171-find-the-genre-of-the-person-with-the-most-number-of-oscar-winnings?python=

Find the percentage of shipable orders
Consider an order is shipable if the customer's address is known.
*/

WITH src AS(
    SELECT 
        o.id AS order_id, 
        address,
        (CASE WHEN address IS NOT NULL THEN 1 ELSE 2 END) indicator
    FROM orders o JOIN customers c
    ON o.cust_id = c.id
)

SELECT (
    (SELECT COUNT(*) FROM src WHERE indicator = '1')*1.0/( SELECT count(*) FROM src)
)*100 AS pct_shipable



