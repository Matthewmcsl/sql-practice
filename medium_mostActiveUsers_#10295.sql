/* 
Difficulty: Medium
Company: Facebook

Facebook Messenger stores the number of messages between 
users in a table named 'fb_messages'. In this table 'user1' 
is the sender, 'user2' is the receiver, and 'msg_count' is 
the number of messages exchanged between them.
Find the top 10 most active users on Facebook Messenger 
by counting their total number of messages sent and received.

Table 1: fb_messages
id <int>
date <datetime>
user1 <varchar>
user2 <varchar>
msg_count <int>
*/

/* Solution 1 - using CTE + COALESCE*/
WITH msg_sent AS(
    SELECT 
    user1, SUM(msg_count) as sent
    FROM fb_messages
    GROUP BY user1
)
,
msg_rcvd AS (
    SELECT user2, SUM(msg_count) as rcvd
    FROM fb_messages
    GROUP BY user2
)

SELECT 
user1, 
user2, 
sent, 
rcvd,
COALESCE(sent,0)+COALESCE(rcvd,0) AS total_msg
FROM msg_sent
FULL OUTER JOIN msg_rcvd
ON user1 = user2
ORDER BY total_msg DESC 
LIMIT 10


/* Solution 2 - UNION ALL (after viewing other solutions)*/
SELECT user1, SUM(msg_count) AS total_messages
FROM
(
    SELECT user1, msg_count FROM fb_messages
    UNION ALL
    SELECT user2, msg_count FROM fb_messages
) AS summary
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10