CREATE TABLE dim_customers AS
SELECT customer_id,
       name,
       email,
       city,
       state
FROM clean_customers;

CREATE TABLE dim_branches AS
SELECT branch_id,
       branch_name,
       city AS branch_city,
       state AS branch_state
FROM clean_branches;

CREATE TABLE dim_accounts AS
SELECT account_id,
       customer_id,
       branch_id,
       account_type,
       opening_date,
       balance
FROM clean_accounts;

CREATE TABLE dim_date AS
SELECT DISTINCT 
       transaction_date AS full_date,
       EXTRACT(YEAR FROM transaction_date) AS year,
       EXTRACT(MONTH FROM transaction_date) AS month,
       EXTRACT(DAY FROM transaction_date) AS day,
       TO_CHAR(transaction_date, 'Day') AS day_name,
       DATE_TRUNC('quarter', transaction_date) AS quarter_start
FROM clean_transactions;

CREATE TABLE fact_transactions AS
SELECT t.transaction_id,
       t.account_id,
       a.customer_id,
       a.branch_id,
       t.transaction_type,
       t.amount,
       t.transaction_date,
       DATE_TRUNC('month', t.transaction_date) AS transaction_month
FROM clean_transactions t
JOIN clean_accounts a ON t.account_id = a.account_id;