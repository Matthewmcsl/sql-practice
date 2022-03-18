/* 
Difficulty: Medium
Company: Box

Cass Performance
You are given a table containing assignment scores of students in a class. 
Write a query that identifies the largest difference in total score of all assignments.
Output just the difference in total score between the two students.

Table 1: box_scores
id <int>
student <varchar>
assignment1 <int>
assignment2 <int>
assignment3 <int>
*/


/* Solution */
SELECT max(score) - min(score) AS difference_in_scores
FROM
    (SELECT student, sum(assignment1+assignment2+assignment3) AS score 
    FROM box_scores
    group by 1) AS scores


/* Re practice - confidence 4/5 */
WITH total_score AS(
    SELECT id, student, (assignment1 + assignment2 + assignment3) as total
    FROM box_scores
)

SELECT MAX(total)-MIN(total) AS difference_in_scores
FROM total_score