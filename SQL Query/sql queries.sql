--Total Transaction amount by Transaction type
SELECT transaction_type,
       SUM(amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

--Total Transaction Amount by Branch
SELECT b.branch_name,
       SUM(f.amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_branches b ON f.branch_id = b.branch_id
GROUP BY b.branch_name
ORDER BY total_amount DESC;

--Total Top 10 Transaction Amount by Customer
SELECT c.name AS customer_name,
       SUM(f.amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_amount DESC
LIMIT 10;

--Monthly Transaction Trend
SELECT DATE_TRUNC('month', transaction_date) AS month,
       SUM(amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions
GROUP BY month
ORDER BY month;

--Average Transaction Amount by Account Type
SELECT a.account_type,
       AVG(f.amount) AS avg_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_accounts a ON f.account_id = a.account_id
GROUP BY a.account_type;

--Total Transaction Amount by Customer City
SELECT c.city AS customer_city,
       SUM(f.amount) AS total_amount,
       COUNT(*) AS transaction_count
FROM fact_transactions f
JOIN dim_customers c ON f.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_amount DESC;