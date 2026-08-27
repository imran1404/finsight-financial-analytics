-- FinSight Banking Analysis
-- Transaction Analysis


-- 1. Overall Transaction Performance

SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(amount_usd), 2) AS average_transaction_value,
    ROUND(MIN(amount_usd), 2) AS minimum_transaction_value,
    ROUND(MAX(amount_usd), 2) AS maximum_transaction_value
FROM transactions;


-- 2. Yearly Transaction Performance

SELECT
    strftime('%Y', transaction_date) AS transaction_year,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(amount_usd), 2) AS average_transaction_value
FROM transactions
GROUP BY transaction_year
ORDER BY transaction_year;


-- 3. Monthly Transaction Performance

SELECT
    strftime('%M', transaction_date) AS transaction_month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(amount_usd), 2) AS average_transaction_value
FROM transactions
GROUP BY transaction_month
ORDER BY total_transaction_value DESC;


-- 4. Top Merchants by Transaction Value

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_usd), 2) AS average_transaction_value
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY total_transaction_value DESC
LIMIT 10;


-- 5. Top Merchants by Transaction Volume

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_usd), 2) AS average_transaction_value
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY total_transactions DESC
LIMIT 10;


-- 6. Top Accounts by Transaction Value

SELECT
    a.account_id,
    a.customer_id,
    a.account_type,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_usd), 2) AS average_transaction_value
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    a.account_id,
    a.customer_id,
    a.account_type
ORDER BY total_transaction_value DESC
LIMIT 10;


-- 7. Transaction Amount Segmentation

SELECT
    CASE
        WHEN amount_usd < 1000 THEN 'Small (<1K)'
        WHEN amount_usd < 5000 THEN 'Medium (1K-5K)'
        WHEN amount_usd < 7500 THEN 'Large (5K-7.5K)'
        ELSE 'Very Large (7.5K+)'
    END AS transaction_band,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_usd), 2) AS total_transaction_value,
    ROUND(AVG(amount_usd), 2) AS average_transaction_value
FROM transactions
GROUP BY transaction_band
ORDER BY total_transaction_value DESC;



-- 8. Month-over-Month Transaction Growth

WITH monthly_transactions AS (
    SELECT
        strftime('%Y-%m', transaction_date) AS transaction_month,
        COUNT(*) AS total_transactions,
        SUM(amount_usd) AS total_transaction_value
    FROM transactions
    GROUP BY strftime('%Y-%m', transaction_date)
)
SELECT
    transaction_month,
    total_transactions,
    ROUND(total_transaction_value, 2) AS total_transaction_value,
    LAG(total_transaction_value) OVER (
    ORDER BY transaction_month
    ) AS previous_month_value,
    ROUND(
(total_transaction_value - LAG(total_transaction_value) OVER (
ORDER BY transaction_month)) * 100.0/ NULLIF(
    LAG(total_transaction_value) OVER (
    ORDER BY transaction_month), 0),2
    ) AS mom_growth_percentage
FROM monthly_transactions
ORDER BY transaction_month;



-- 9. Running Transaction Value

WITH monthly_transactions AS (
    SELECT STRFTIME('%Y-%m', transaction_date) AS transaction_month,
    SUM(amount_usd) AS monthly_transaction_value
    FROM transactions
    GROUP BY STRFTIME('%Y-%m', transaction_date)
)
SELECT transaction_month, ROUND(monthly_transaction_value, 2) AS monthly_transaction_value,
    ROUND(
    SUM(monthly_transaction_value) OVER (
    ORDER BY transaction_month
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2
    ) AS running_transaction_value
FROM monthly_transactions
ORDER BY transaction_month;


-- 10. Transaction Value Concentration by Customer

WITH customer_transactions AS (
    SELECT a.customer_id,
    SUM(t.amount_usd) AS customer_transaction_value
    FROM accounts a
    JOIN transactions t
    ON a.account_id = t.account_id
    GROUP BY a.customer_id
)
SELECT customer_id, ROUND(customer_transaction_value, 2) AS customer_transaction_value,
    ROUND( customer_transaction_value * 100.0 /SUM(customer_transaction_value) OVER (),2) AS transaction_value_percentage
FROM customer_transactions
ORDER BY customer_transaction_value DESC
LIMIT 10;


















































































