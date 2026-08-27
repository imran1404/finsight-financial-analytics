-- =====================================================
-- FinSight Banking Analysis
-- Account Analysis
-- =====================================================


-- 1. Account Type Analysis

SELECT
    account_type,
    COUNT(*) AS total_accounts,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;


-- 2. Customer Account & Loan Overview

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    ROUND(COALESCE(SUM(l.loan_amount), 0), 2) AS total_loan_value
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
LEFT JOIN loans l
ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_loan_value DESC
LIMIT 10;



-- 3. Account Mix Analysis

SELECT
    account_mix,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) AS customer_percentage
FROM (
    SELECT
        customer_id,
        GROUP_CONCAT(
            DISTINCT account_type
            ORDER BY account_type
        ) AS account_mix
    FROM accounts
    GROUP BY customer_id
)
GROUP BY account_mix
ORDER BY customer_count DESC;


-- 4. Account Balance Analysis

SELECT
    account_type,
    COUNT(*) AS total_accounts,
    ROUND(SUM(balance), 2) AS total_balance,
    ROUND(AVG(balance), 2) AS avg_balance,
    ROUND(MIN(balance), 2) AS min_balance,
    ROUND(MAX(balance), 2) AS max_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;



-- 5. Customer Account Ownership

SELECT
    customer_id,
    COUNT(account_id) AS total_accounts
FROM accounts
GROUP BY customer_id
ORDER BY total_accounts DESC
LIMIT 10;


-- 6. Account Balance Band Analysis

SELECT
    CASE
        WHEN balance < 10000 THEN 'Low (<10K)'
        WHEN balance < 50000 THEN 'Medium (10K-50K)'
        WHEN balance < 100000 THEN 'High (50K-100K)'
        ELSE 'Very High (100K+)'
    END AS balance_band,
    COUNT(*) AS total_accounts,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(balance), 2) AS total_balance,
    ROUND(AVG(balance), 2) AS avg_balance
FROM accounts
GROUP BY balance_band
ORDER BY total_balance DESC;


-- 7. Customer Account Count Analysis

SELECT
    customer_id,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY customer_id
ORDER BY total_accounts DESC;



-- 8. Account Activity by Type

SELECT
    a.account_type,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_usd), 2) AS avg_transaction_value
FROM accounts a
JOIN transactions t
ON a.account_id = t.account_id
GROUP BY a.account_type
ORDER BY total_transaction_value DESC;



-- 9. Top Accounts by Transaction Value

SELECT
    a.account_id,
    a.customer_id,
    a.account_type,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_usd), 2) AS avg_transaction_value
FROM accounts a
JOIN transactions t
ON a.account_id = t.account_id
GROUP BY
    a.account_id,
    a.customer_id,
    a.account_type
ORDER BY total_transaction_value DESC
LIMIT 10;



-- 10. Accounts With No Transactions

SELECT
COUNT(*) AS accounts_without_transactions
FROM accounts a
LEFT JOIN transactions t
ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;


























































