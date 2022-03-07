/*https://platform.stratascratch.com/coding/10284-popularity-percentage?python=

Popularity Percentage
Find the popularity percentage for each user on Meta/Facebook. 
The popularity percentage is defined as the total number of friends the user has divided 
by the total number of users on the platform, then converted into a percentage by multiplying 
by 100. Output each user along with their popularity percentage.
Order records in ascending order by user id. 
The 'user1' and 'user2' column are pairs of friends.

*/

-- RANK function serves as the primary key to merge both CTEs later on

With total_friends AS(
    SELECT user1, COUNT(user2) AS n_friends, RANK() OVER(PARTITION BY 1 ORDER BY 1 DESC) -- rank col used as primary key to merge
    FROM(
        SELECT user1, user2 FROM facebook_friends
        UNION
        SELECT user2, user1 FROM facebook_friends
        ORDER BY 1 ASC -- rows of unique friends combination
        ) master_list
    GROUP BY 1
)
,
total_users AS(
    SELECT COUNT(*) AS ttl_users, RANK() OVER(PARTITION BY 1 ORDER BY 1 DESC) FROM(
        SELECT user1 FROM facebook_friends
        UNION
        SELECT user2 FROM facebook_friends
        ) n_unique_people
)

SELECT user1, (n_friends/ttl_users::FLOAT)*100 AS pct
FROM(
    SELECT user1, n_friends, ttl_users
    FROM total_friends tf
    JOIN total_users tu
    ON tf.rank = tu.rank
    ) temp
ORDER BY 1 ASC