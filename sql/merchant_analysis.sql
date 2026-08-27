-- FinSight Banking Analysis
-- Merchant Analysis


-- 1. Merchant Portfolio Overview

SELECT
    COUNT(*) AS total_merchants,
    COUNT(DISTINCT merchant_name) AS unique_merchant_names
FROM merchants;



-- 2. Merchant Transaction Performance

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



-- 3. Merchant Contribution to Transaction Value

WITH merchant_values AS (
    SELECT
        m.merchant_id,
        m.merchant_name,
        SUM(t.amount_usd) AS total_transaction_value
    FROM merchants m
    JOIN transactions t
    ON m.merchant_id = t.merchant_id
    GROUP BY
        m.merchant_id,
        m.merchant_name
)

SELECT
    merchant_id,
    merchant_name,
    ROUND(total_transaction_value, 2) AS total_transaction_value,
    ROUND(total_transaction_value * 100.0 /SUM(total_transaction_value) OVER (),2
    ) AS value_percentage
FROM merchant_values
ORDER BY total_transaction_value DESC
LIMIT 10;


-- 4. Merchant Transaction Frequency

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(AVG(t.amount_usd), 2) AS average_transaction_value
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY total_transactions DESC
LIMIT 10;


-- 5. Merchant Active Years

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(DISTINCT strftime('%Y',t.transaction_date)) AS active_years,
    MIN(strftime('%Y', t.transaction_date)) AS first_active_year,
    MAX(strftime('%Y',t.transaction_date)) AS latest_active_year
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY active_years DESC;


-- 6. Merchant Customer Reach

SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(DISTINCT a.customer_id) AS unique_customers,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
JOIN accounts a
ON t.account_id = a.account_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY unique_customers DESC
LIMIT 10;


-- 7. Merchant Average Customer Spend

WITH merchant_customer_spend AS (
    SELECT
        t.merchant_id,
        a.customer_id,
        SUM(t.amount_usd) AS customer_spend
    FROM transactions t
    JOIN accounts a
    ON t.account_id = a.account_id
    GROUP BY
        t.merchant_id,
        a.customer_id
)
SELECT
    m.merchant_id,
    m.merchant_name,
    COUNT(*) AS unique_customers,
    ROUND(AVG(mcs.customer_spend), 2) AS avg_customer_spend,
    ROUND(SUM(mcs.customer_spend), 2) AS total_transaction_value
FROM merchant_customer_spend mcs
JOIN merchants m
ON mcs.merchant_id = m.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name
ORDER BY avg_customer_spend DESC
LIMIT 10;


-- 8. Merchant Transaction Value Growth

SELECT
    m.merchant_id,
    m.merchant_name,

    ROUND(SUM(
        CASE
            WHEN strftime('%Y',t.transaction_date) = 2019
            THEN t.amount_usd
            ELSE 0
        END
    ), 2) AS value_2019,
    ROUND(SUM(
        CASE
            WHEN strftime('%Y',t.transaction_date) = 2025
            THEN t.amount_usd
            ELSE 0
        END
    ), 2) AS value_2025,
    ROUND(
        (
            SUM(
                CASE
                    WHEN strftime('%Y', t.transaction_date) = 2025
                    THEN t.amount_usd
                    ELSE 0
                END
            )
            -
            SUM(
                CASE
                    WHEN strftime('%Y', t.transaction_date) = 2019
                    THEN t.amount_usd
                    ELSE 0
                END
            )
        )
        /
        NULLIF(
            SUM(
                CASE
                    WHEN strftime('%Y', t.transaction_date) = 2019
                    THEN t.amount_usd
                    ELSE 0
                END
            ),
            0
        ) * 100,
        2
    ) AS growth_percentage

FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id

GROUP BY
    m.merchant_id,
    m.merchant_name

HAVING value_2019 > 0
ORDER BY growth_percentage DESC
LIMIT 10;


-- 9. Merchant Transaction Value by Year

SELECT
    m.merchant_id,
    m.merchant_name,
    STRFTIME('%Y', t.transaction_date) AS transaction_year,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_usd), 2) AS total_transaction_value
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    transaction_year
ORDER BY
    m.merchant_id,
    transaction_year;



-- 10. Merchant Share of Total Transaction Value

WITH merchant_totals AS (
    SELECT
        merchant_id,
        SUM(amount_usd) AS merchant_value
    FROM transactions
    GROUP BY merchant_id
)
SELECT
    m.merchant_id,
    m.merchant_name,
    ROUND(mt.merchant_value, 2) AS total_transaction_value,
    ROUND(mt.merchant_value * 100.0 /SUM(mt.merchant_value) OVER (),2
    ) AS value_share_percentage
FROM merchant_totals mt
JOIN merchants m
ON mt.merchant_id = m.merchant_id
ORDER BY value_share_percentage DESC
LIMIT 10;













































