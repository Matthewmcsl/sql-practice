/* 
Difficulty: Hard
Company: Netflix

Top Percentile Fraud
ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent 
claims have increased significantly for their personal auto insurance portfolio. 
They have developed a ML based predictive model to identify propensity of fraudulent 
claims. Now, they assign highly experienced claim adjusters for top 5 percentile 
of claims identified by the model.

Your objective is to identify the top 5 percentile of claims from each state. 
Your output should be policy number, state, claim cost, and fraud score.

Table 1: fraud_score
policy_num <varchar>
state <varchar>
claim_cost <int>
fraud_cost <float>

Solution*/
SELECT policy_num, state, claim_cost, fraud_score
FROM 
    (
    SELECT *, 
    NTILE(100) OVER(PARTITION BY state ORDER BY fraud_score DESC) AS percentile
    FROM fraud_score
    ) f
WHERE f.percentile <= 5