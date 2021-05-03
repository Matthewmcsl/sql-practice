/* 
Difficulty: Medium
Company: Amazon

Finding User Purchases
Write a query that'll identify returning active users. 
A returning active user is a user that has made a second 
purchase within 7 days of any other of their purchases. 
Output a list of user_ids of these returning active users.

Table 1: amazon_transactions
id <int>
user_id <int>
item <varchar>
created_at <datetime>
revenue <int>
*/

/* Solution */
WITH prev_date AS(
    SELECT
    user_id,
    created_at,
    LAG(created_at, 1) OVER (PARTITION BY user_id ORDER BY created_at) AS prev
    FROM amazon_transactions
)

SELECT
DISTINCT (user_id)
FROM prev_date 
WHERE (CAST(created_at AS date) - CAST(prev AS date)) < 8 