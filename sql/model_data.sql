-- Export all 10K txns with features for fraud model
SELECT 
    t.transaction_id,
    t.amount,
    EXTRACT(HOUR FROM t.timestamp) AS hour,
    t.region,
    COALESCE(u.account_age_days, 180) AS account_age_days,
    COALESCE((
        SELECT SUM(l.failed_attempts)
        FROM logins l
        WHERE l.user_id = t.user_id
        AND l.timestamp BETWEEN t.timestamp - INTERVAL '1 hour' AND t.timestamp + INTERVAL '1 hour'
    ), 0) AS failed_attempts,
	t.type, 
	(SELECT COUNT(*) FROM transactions t2 WHERE t2.user_id = t.user_id AND t2.is_fraud = TRUE) AS user_fraud_count,
    t.is_fraud
FROM transactions t
LEFT JOIN users u ON t.user_id = u.user_id
ORDER BY t.transaction_id;