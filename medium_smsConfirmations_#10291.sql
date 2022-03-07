/* 
Difficulty: Medium
Company: Facebook

SMS Confirmations from Users
Facebook sends SMS texts when users attempt to 2FA (2-factor authenticate) into the platform to log in. 
In order to successfully 2FA they must confirm they received the SMS text message. Confirmation texts are 
only valid on the date they were sent. Unfortunately, there was an ETL problem with the database where 
friend requests and invalid confirmation records were inserted into the logs, which are stored in the 
'fb_sms_sends' table. These message types should not be in the table. Fortunately, the 'fb_confirmers' 
table contains valid confirmation records so you can use this table to identify SMS text messages that 
were confirmed by the user.

Calculate the percentage of confirmed SMS texts for August 4, 2020.

Table 1: fb_sms_sends
ds <datetime>
country <varchar>
carrier <varchar>
phone_number <int>
type <varchar>

Table 2: fb_confirmers
date <datetime>
phone_number <int>
*/

/* Solution 1 */

SELECT(Valid/Total::float4) * 100 AS perc
FROM(
    SELECT COUNT(*) AS Total,
            SUM(CASE WHEN a.phone_number = b.phone_number THEN 1 ELSE 0 END) as Valid
    FROM fb_sms_sends a
    LEFT JOIN fb_confirmers b
    ON a.ds = b.date
    ) n


# INCOMPLETE YET