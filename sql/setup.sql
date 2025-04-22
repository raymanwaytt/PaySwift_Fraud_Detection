CREATE TABLE transactions (
    transaction_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10),
    amount DECIMAL(12,2),
    timestamp TIMESTAMP,
    type VARCHAR(20),
    region VARCHAR(20),
    is_fraud BOOLEAN
);


CREATE TABLE users (
    user_id VARCHAR(10) PRIMARY KEY,
    account_age_days INT,
    avg_transaction_value DECIMAL(12,2)
);


CREATE TABLE logins (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(10),
    timestamp TIMESTAMP,
    login_status VARCHAR(20),
    failed_attempts INT
);