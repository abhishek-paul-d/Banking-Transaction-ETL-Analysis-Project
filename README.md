# Banking Transaction ETL & Analysis Project
## Project Overview

This project simulates a banking transaction analytics system. The goal is to build an end-to-end ETL pipeline, clean raw data, model it into a star schema, and generate SQL queries to extract actionable insights.

This project demonstrates skills in:

ETL (Extract, Transform, Load) using PostgreSQL

Data cleaning & transformation for unstructured/unclean datasets

Star schema design for analytics

Analytical SQL queries for reporting

It is aligned with data analyst job requirements, showing your ability to handle raw data, transform it, and derive business insights.

Data Description

The project uses synthetic banking data stored in CSV files:

File Name	Description
customers.csv	Customer details: customer_id, name, email, city, state. Includes some missing and duplicate records to simulate unclean data.
branches.csv	Branch information: branch_id, branch_name, city, state. Includes some missing or duplicate values.
accounts.csv	Bank accounts: account_id, customer_id, branch_id, account_type, opening_date, balance. Some rows have null foreign keys to simulate data quality issues.
transactions.csv	Transactions: transaction_id, account_id, transaction_type, amount, transaction_date. Includes negative, zero, or invalid amounts/types for cleaning practice.

ETL Steps
1. Load Raw Data

Imported CSV files into PostgreSQL tables prefixed with raw_ (e.g., raw_customers).

2. Clean Data

Removed duplicates and null values from customers and branches.

Removed accounts with null customer_id or branch_id.

Removed invalid or negative transactions and added a transaction_month column.

SQL Examples:

-- Clean transactions
CREATE TABLE clean_transactions AS
SELECT *,
       DATE_TRUNC('month', transaction_date) AS transaction_month
FROM raw_transactions
WHERE amount > 0
  AND transaction_type IN ('Deposit', 'Withdrawal', 'Transfer');
-- Clean accounts
CREATE TABLE clean_accounts AS
SELECT *
FROM raw_accounts
WHERE customer_id IS NOT NULL
  AND branch_id IS NOT NULL;
3. Build Star Schema
Dimension Tables

dim_customers: Customer details

dim_branches: Branch details

dim_accounts: Accounts linking customers and branches

dim_date: Extracted year, month, day, and quarter from transaction dates

Fact Table

fact_transactions: Stores transaction measures and links to dimensions

Example:

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
Analytical SQL Queries

The following are sample queries that generate insights for business analytics:

Total Transaction Amount by Transaction Type

SELECT transaction_type,
       SUM(amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions
GROUP BY transaction_type;

Total Transaction Amount by Branch

SELECT b.branch_name,
       SUM(f.amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_branches b ON f.branch_id = b.branch_id
GROUP BY b.branch_name
ORDER BY total_amount DESC;

Top Customers by Transaction Amount

SELECT c.name AS customer_name,
       SUM(f.amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_amount DESC
LIMIT 10;

Monthly Transaction Trend

SELECT DATE_TRUNC('month', transaction_date) AS month,
       SUM(amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions
GROUP BY month
ORDER BY month;

Average Transaction Amount by Account Type

SELECT a.account_type,
       AVG(f.amount) AS avg_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_accounts a ON f.account_id = a.account_id
GROUP BY a.account_type;

Total Transaction Amount by Customer City

SELECT c.city AS customer_city,
       SUM(f.amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_amount DESC;
Key Learnings & Takeaways

Built an end-to-end ETL pipeline using PostgreSQL.

Learned to handle unclean data, including nulls, duplicates, and invalid transactions.

Designed a star schema to optimize analytical queries.

Generated actionable insights for stakeholders:

Branches with highest transaction volume

Customer transaction patterns

Monthly transaction trends

Developed SQL skills for real-world data analysis, suitable for Data Analyst roles.


