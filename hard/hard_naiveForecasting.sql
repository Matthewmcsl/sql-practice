/*
https://platform.stratascratch.com/coding/10313-naive-forecasting?python=

Naive Forecasting

Some forecasting methods are extremely simple and surprisingly effective. 
Naïve forecast is one of them; we simply set all forecasts to be the value 
of the last observation. Our goal is to develop a naïve forecast for a new 
metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost) 
in our dataset and measure its accuracy.

To develop this forecast,  sum "distance to travel"  and "monetary cost" values 
at a monthly level before calculating "distance per dollar". This value becomes
your actual value for the current month. The next step is to populate the forecasted
value for each month. This can be achieved simply by getting the previous month's 
value in a separate column. Now, we have actual and forecasted values. This is your
naïve forecast. Let’s evaluate our model by calculating an error matrix called root
mean squared error (RMSE). RMSE is defined as sqrt(mean(square(actual - forecast)). 
Report out the RMSE rounded to the 2nd decimal spot.
*/

#NOTE: MySql solution

WITH agg_month AS(
    SELECT 
        DATE_FORMAT(request_date, '%Y-%m') AS mth, 
        SUM(distance_to_travel) AS total_dist, 
        SUM(monetary_cost) AS total_cost
    FROM uber_request_logs
    GROUP BY 1)


SELECT ROUND(SQRT(AVG(POWER(ABS(dist_per_dollar-prev_dist_per_dollar), 2))), 2) AS RMSE FROM(
    SELECT 
        *, 
        LAG(dist_per_dollar, 1) OVER(ORDER BY mth) AS prev_dist_per_dollar
    FROM(SELECT mth, (total_dist/total_cost) AS dist_per_dollar FROM agg_month) t )t2
WHERE prev_dist_per_dollar IS NOT NULL