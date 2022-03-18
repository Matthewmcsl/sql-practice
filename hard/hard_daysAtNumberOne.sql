/*
https://platform.stratascratch.com/coding/10173-days-at-number-one?python=

Days At Number One
You have a table with US rankings of tracks and another table with worldwide 
rankings of tracks. Find the number of days a US track has been in the 1st position 
for both the US and worldwide rankings. Output the track name and the number of days 
in the 1st position. Order your output alphabetically by track name.
*/

SELECT trackname, COUNT(DISTINCT(trackname, date)) as n_days 
FROM(
    SELECT DISTINCT sdr.position, sdr.trackname, sdr.date 
        FROM spotify_daily_rankings_2017_us sdr
        JOIN spotify_worldwide_daily_song_ranking swd
        ON sdr.trackname = swd.trackname
        AND sdr.date = swd.date
        WHERE swd.position = '1'
        ) temp
GROUP BY 1
