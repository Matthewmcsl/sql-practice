/* 
Difficulty: Medium
Company: Airbnb

Rank guests based on their ages
Output the guest id along with the corresponding rank.
Order records by the age in descending order.

Table 1: airbnb_guests
guest_id <int>
nationality <varchar>
gender <varchar>
age <int>

/* Solution */ RANK
SELECT 
    guest_id, 
    RANK() OVER(ORDER BY age DESC) rank
FROM 
    airbnb_guests
