-- FinSight Banking Analysis
-- Customer Analysis

-- 1. Customer Portfolio Overview

SELECT COUNT(DISTINCT c.customer_id) AS total_customers,
       COUNT(DISTINCT a.account_id) AS total_accounts,
       COUNT(DISTINCT l.loan_id) AS total_loans,
       ROUND(SUM(a.balance), 2) AS total_account_balance,
      ROUND(SUM(l.loan_amount), 2) AS total_loan_value
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
LEFT JOIN loans l
ON c.customer_id = l.customer_id;


-- 2. Customer Transaction Activity

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_usd), 2) AS avg_transaction_value
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
JOIN transactions t
ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_transaction_value DESC
LIMIT 10;



-- 3. Customers With Both Accounts and Loans

SELECT
    COUNT(*) AS customers_with_both_products,
    ROUND(COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM customers),2) AS customer_percentage
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
)
AND EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.customer_id = c.customer_id
);



-- 4. Customers With No Loans

SELECT
    COUNT(*) AS customers_without_loans,
    ROUND(
    COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM customers), 2) AS customer_percentage
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.customer_id = c.customer_id
);



-- 5. Customer Lending-to-Deposit Exposure

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(
    COALESCE(
    (SELECT SUM(a.balance_usd)
    FROM accounts a
    WHERE a.customer_id = c.customer_id),0),2) AS total_account_balance,
ROUND(COALESCE(
            (SELECT SUM(l.loan_amount)
             FROM loans l
             WHERE l.customer_id = c.customer_id),
            0
        ),
        2
    ) AS total_loan_value,
    ROUND(
    COALESCE(
    (SELECT SUM(l.loan_amount)
    FROM loans l
    WHERE l.customer_id = c.customer_id), 0)* 100.0/NULLIF(
    (SELECT SUM(a.balance_usd)
    FROM accounts a
    WHERE a.customer_id = c.customer_id), 0),2) AS loan_to_deposit_ratio
FROM customers c
ORDER BY loan_to_deposit_ratio DESC
LIMIT 10;



-- 7. Most Active Customers

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(t.transaction_id) AS total_transactions
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
JOIN transactions t
ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_transactions DESC
LIMIT 10;


-- 8. Customer Account Type Combination

SELECT
    CASE
        WHEN COUNT(DISTINCT account_type) = 1 THEN '1 Account Type'
        WHEN COUNT(DISTINCT account_type) = 2 THEN '2 Account Types'
        WHEN COUNT(DISTINCT account_type) = 3 THEN '3 Account Types'
    END AS account_type_count,
    COUNT(*) AS customer_count
FROM accounts
GROUP BY customer_id
ORDER BY account_type_count;



-- 9. Customers by Total Account Balance

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(a.balance_usd), 2) AS total_balance,
    COUNT(a.account_id) AS total_accounts
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_balance DESC
LIMIT 10;



-- 10. Customer Credit Score Segmentation

SELECT
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score < 670 THEN 'Fair'
        WHEN credit_score < 740 THEN 'Good'
        WHEN credit_score < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END AS credit_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(credit_score), 2) AS avg_credit_score
FROM customers
GROUP BY credit_segment
ORDER BY avg_credit_score;














































































