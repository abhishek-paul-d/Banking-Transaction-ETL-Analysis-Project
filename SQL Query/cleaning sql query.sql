-- Remove invalid transactions and add transaction_month
CREATE TABLE clean_transactions AS
SELECT *,
       DATE_TRUNC('month', transaction_date) AS transaction_month
FROM raw_transactions
WHERE amount > 0
  AND transaction_type IN ('Deposit', 'Withdrawal', 'Transfer');

-- Keep only accounts with valid customer_id and branch_id
CREATE TABLE clean_accounts AS
SELECT *
FROM raw_accounts
WHERE customer_id IS NOT NULL
  AND branch_id IS NOT NULL;

-- Remove duplicates and rows with null customer_id
CREATE TABLE clean_customers AS
SELECT DISTINCT *
FROM raw_customers
WHERE customer_id IS NOT NULL;

-- Remove duplicates and rows with null branch_id
CREATE TABLE clean_branches AS
SELECT DISTINCT *
FROM raw_branches
WHERE branch_id IS NOT NULL;
select * from clean_accounts

SELECT COUNT(*) AS total_raw_transactions FROM raw_transactions;
SELECT COUNT(*) AS total_clean_transactions FROM clean_transactions;

SELECT COUNT(*) AS total_raw_accounts FROM raw_accounts;
SELECT COUNT(*) AS total_clean_accounts FROM clean_accounts;

SELECT COUNT(*) AS total_raw_customers FROM raw_customers;
SELECT COUNT(*) AS total_clean_customers FROM clean_customers;

SELECT COUNT(*) AS total_raw_branches FROM raw_branches;
SELECT COUNT(*) AS total_clean_branches FROM clean_branches;