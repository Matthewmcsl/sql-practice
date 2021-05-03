/* 
Difficulty: Easy
Company: Amazon

Total Cost Of Orders
Find the total cost of each customer's orders. 
Output customer's id, first name, and the total order cost. 
Order records by customer's first name alphabetically.

Table 1: customers
id <int>
first_name <varchar>
last_name <varchar>
city <varchar>
address <varchar>
phone_number <varchar>

Table 2: orders
id <int>
cust_id <int>
order_date <datetime>
order_quantity <int>
order_details <varchar>
order_cost <int>
*/

/* Solution 1 */
SELECT
distinct(cust_id),
first_name,
SUM(order_cost)
FROM customers c
JOIN orders o
ON c.id = o.cust_id
GROUP BY cust_id, first_name
ORDER BY first_name ASC