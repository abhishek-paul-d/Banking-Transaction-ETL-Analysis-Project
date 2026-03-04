CREATE TABLE raw_branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE raw_customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE raw_accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    account_type VARCHAR(50),
    opening_date DATE,
    balance NUMERIC
);
CREATE TABLE raw_transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20), -- Deposit, Withdrawal, Transfer
    amount NUMERIC,
    transaction_date TIMESTAMP
);
SELECT * FROM raw_accounts