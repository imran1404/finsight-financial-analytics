-- FinSight Banking Analysis
-- Card Analysis


-- 1. Overall Card Portfolio

SELECT
    COUNT(DISTINCT card_id) AS total_cards,
    COUNT(DISTINCT account_id) AS accounts_with_cards,
    COUNT(DISTINCT card_type) AS card_types
FROM cards;



-- 2. Card Type Distribution

SELECT
    card_type,
    COUNT(*) AS total_cards,
    COUNT(DISTINCT account_id) AS accounts_with_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;



-- 3. Cards per Account

SELECT
    account_id,
    COUNT(card_id) AS total_cards
FROM cards
GROUP BY account_id
ORDER BY total_cards DESC;


-- 4. Card Distribution by Account Type

SELECT
    a.account_type,
    COUNT(c.card_id) AS total_cards,
    COUNT(DISTINCT a.account_id) AS accounts_with_cards
FROM accounts a
JOIN cards c
ON a.account_id = c.account_id
GROUP BY a.account_type
ORDER BY total_cards DESC;


-- 5. Card Expiration Status

SELECT
    CASE
        WHEN DATE(expiration_date) < DATE('now') THEN 'Expired'
        ELSE 'Active'
    END AS card_status,
    COUNT(*) AS total_cards
FROM cards
GROUP BY card_status
ORDER BY total_cards DESC;



-- 6. Card Expiration by Year

SELECT
    STRFTIME('%Y', expiration_date) AS expiration_year,
    COUNT(*) AS total_cards
FROM cards
GROUP BY expiration_year
ORDER BY expiration_year;


-- 7. Card Expiration by Card Type

SELECT
    card_type,
    COUNT(*) AS total_cards,
    COUNT(
        CASE
            WHEN DATE(expiration_date) < DATE('now')
            THEN 1
        END
    ) AS expired_cards,
    COUNT(
        CASE
            WHEN DATE(expiration_date) >= DATE('now')
            THEN 1
        END
    ) AS active_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;


-- 8. Accounts With Multiple Cards

SELECT
    account_id,
    COUNT(card_id) AS total_cards
FROM cards
GROUP BY account_id
HAVING COUNT(card_id) > 1
ORDER BY total_cards DESC;


-- 9. Cards by Customer

SELECT
    a.customer_id,
    COUNT(c.card_id) AS total_cards,
    COUNT(DISTINCT c.card_type) AS card_types
FROM accounts a
JOIN cards c
ON a.account_id = c.account_id
GROUP BY a.customer_id
ORDER BY total_cards DESC
LIMIT 10;



-- 10. Customer Card Portfolio

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    COUNT(card.card_id) AS total_cards,
    COUNT(DISTINCT card.card_type) AS card_types
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
JOIN cards card
ON a.account_id = card.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_cards DESC
LIMIT 10;


















































































