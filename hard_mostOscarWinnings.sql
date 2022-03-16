/*
https://platform.stratascratch.com/coding/10171-find-the-genre-of-the-person-with-the-most-number-of-oscar-winnings?python=

Find the genre of the person with the most number of oscar winnings

If there are more than one person with the same number of oscar wins, 
return the first one in alphabetic order based on their name. 
Use the names as keys when joining the tables.
*/

/* === Own solution ===
    1. Join oscar_nominees table with nominee_information table - to get top_genre information
    2. Filter joined table on winner = 'TRUE" - to get only oscar wins
    3. DENSE_RANK over COUNT(*) - to get an descending order of n_wins (since each row represents a win)
    4. Turn it into a subquery, and get only the top_genre column with a LIMIT = 1

*/
WITH oscar_info AS(
    SELECT year, nominee, top_genre
    FROM oscar_nominees o JOIN nominee_information n
    ON nominee = name
    WHERE winner = 'TRUE'
)

SELECT top_genre FROM (
    SELECT nominee, top_genre, COUNT(*), DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) win_rank
    FROM oscar_info
    GROUP BY 1, 2
    LIMIT 1 ) solution

/*  Alternatively... */
SELECT top_genre FROM (
    SELECT DISTINCT(nominee), top_genre, COUNT(*) OVER(PARTITION BY nominee ) n_wins
    FROM oscar_info
    ORDER BY n_wins desc
    LIMIT 1
    ) solution
