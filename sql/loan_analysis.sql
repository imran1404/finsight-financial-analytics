-- =====================================================
-- FinSight Banking Analysis
-- Loan Analysis
-- =====================================================


-- 1. Overall Loan Portfolio
SELECT
    COUNT(*) AS total_loans,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(loan_amount), 2) AS total_loan_value,
    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
    ROUND(MIN(loan_amount), 2) AS min_loan_amount,
    ROUND(MAX(loan_amount), 2) AS max_loan_amount,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM loans;



-- 2. Interest Rate Band Analysis

SELECT
    CASE
        WHEN interest_rate < 5 THEN 'Below 5%'
        WHEN interest_rate < 10 THEN '5% - 10%'
        WHEN interest_rate < 15 THEN '10% - 15%'
        ELSE '15% and above'
    END AS interest_rate_band,
    COUNT(*) AS total_loans,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(loan_amount), 2) AS total_loan_value,
    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM loans
GROUP BY interest_rate_band
ORDER BY total_loan_value DESC;



-- 3. Loan Size Band Analysis

SELECT
    CASE
        WHEN loan_amount < 50000 THEN 'Small (<50K)'
        WHEN loan_amount < 100000 THEN 'Medium (50K-100K)'
        WHEN loan_amount < 250000 THEN 'Large (100K-250K)'
        ELSE 'Very Large (250K+)'
    END AS loan_size_band,
    COUNT(*) AS total_loans,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(loan_amount), 2) AS total_loan_value,
    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
    ROUND(MIN(interest_rate), 2) AS min_interest_rate,
    ROUND(MAX(interest_rate), 2) AS max_interest_rate
FROM loans
GROUP BY loan_size_band
ORDER BY total_loan_value DESC;



-- 4. Yearly Loan Analysis

SELECT
    STRFTIME('%Y', start_date) AS loan_year,
    COUNT(*) AS total_loans,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(loan_amount), 2) AS total_loan_value,
    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM loans
GROUP BY loan_year
ORDER BY loan_year;



-- 5. Customer Loan Performance

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(l.loan_id) AS total_loans,
    ROUND(SUM(l.loan_amount), 2) AS total_loan_value,
    ROUND(AVG(l.loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(l.interest_rate), 2) AS avg_interest_rate
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_loan_value DESC
LIMIT 10;





























