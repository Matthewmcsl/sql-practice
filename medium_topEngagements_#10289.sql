/* 
Difficulty: Medium
Company: Facebook

Top Engagements
We have two tables that contain search results. The 'fb_search_results' table contains the search results 
from a user's search. In this table the `result_id` column is a key that corresponds to the `search_id` column 
of the `fb_search_events` table. The `position` column refers to the position that the result was displayed to 
the user. The 'fb_search_events' is a table that stores whether or not the user clicked on a particular search result.

Write a query to calculate the percentage of search results, out of all the results, that were positioned in the top 3 
and clicked by the user.

Table 1: fb_search_results
query <varchar>
result_id <int>
position <int>
notes <varchar>

Table 2: fb_search_events
search_id <int>
query <varchar>
has_clicked <varchar>
*/

/* Solution 1 */ CASE-WHEN
SELECT
    (SUM(CASE WHEN position <= 3 AND has_clicked='yes' THEN 1.0 ELSE 0.0 END)/ COUNT(*) *100) AS percentage
--OR (COUNT(CASE WHEN position <= 3 AND has_clicked = 'yes' THEN 1 ELSE NULL END)*1.0/COUNT(*)*100)
FROM 
    fb_search_results r
JOIN
    fb_search_events e
ON 
    r.result_id = e.search_id


/* Solution 2 */
SELECT (COUNT(*)::FLOAT / (SELECT COUNT (*) FROM fb_search_results)) * 100
FROM fb_search_results r
INNER JOIN fb_search_events e
ON r.result_id = e.search_id
WHERE position <=3 AND has_clicked = 'yes'