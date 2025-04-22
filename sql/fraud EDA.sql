-- Average Transaction Amount for Fraud vs. Non-Fraud
SELECT 
    is_fraud,
    ROUND(AVG(amount)) AS avg_amount,
    COUNT(*) AS txn_count
FROM transactions
GROUP BY is_fraud;

-- Output: 
	-- legit: There's a total count of 8699 legit txn with an average of 23369
	-- fraud: There are	1301 fraud txn with 38148 on average


-- Percentage of Transactions Above 40K that are Fraudulent
SELECT 
    ROUND(COUNT(CASE WHEN is_fraud = TRUE THEN 1 END) * 100.0 / COUNT(*)) AS fraud_percentage,
    COUNT(*) AS total_above_40k
FROM transactions
WHERE amount > 40000;

-- Output: 30% of txn above 30k are fraudlent


-- Regions with High-Value Fraudulent Transactions (> 30K)
SELECT 
    region,
    AVG(amount) AS avg_fraud_amount,
    SUM(CAST(is_fraud AS INT)) AS fraud_count,
    COUNT(*) AS total_high_value
FROM transactions
WHERE amount > 30000 AND is_fraud = TRUE
GROUP BY region
ORDER BY fraud_count DESC;

-- Output: Cspe town has the mst txn greater than 30k, folllowed by lagos, Nairobi has the least but averages on peak at 40k+


-- Hours of the Day with the Most Fraud Cases
SELECT 
    EXTRACT(HOUR FROM timestamp) AS hour,
    SUM(is_fraud::int) AS fraud_count,
    COUNT(*) AS total_count,
    ROUND((SUM(is_fraud::int) * 100.0 / COUNT(*))) AS percentage_of_fraud_txn
FROM transactions
GROUP BY EXTRACT(HOUR FROM timestamp)
ORDER BY fraud_count DESC;

-- Output: Most transactions fall in between dark hours and peaks at 10PM


-- Users with Multiple Fraud Cases
SELECT 
    user_id,
    SUM(CAST(is_fraud AS INT)) AS fraud_count,
    COUNT(*) AS total_count,
	SUM(is_fraud::INT) * 100/COUNT(*) as percentage_of_fraud_txn
FROM transactions
GROUP BY user_id
HAVING SUM(CAST(is_fraud AS INT)) >= 2
ORDER BY percentage_of_fraud_txn DESC;

-- Output: USR480 has the most fraudlent txn, 7