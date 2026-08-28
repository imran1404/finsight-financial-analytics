-- FinSight Banking Analysis
-- Branch Analysis

-- 1. Branch Portfolio Overview

SELECT
    COUNT(*) AS total_branches,
    COUNT(country) AS countries,
    COUNT(DISTINCT city) AS cities
FROM branches;


-- 2. Branch Manager Workload

SELECT
    manager_name,
    COUNT(branch_id) AS total_branches
FROM branches
GROUP BY manager_name
ORDER BY total_branches DESC;


-- 3. Branch Name Distribution

SELECT
    branch_name,
    COUNT(*) AS branch_count
FROM branches
GROUP BY branch_name
ORDER BY branch_count DESC;


-- 4. Manager Workload Distribution

SELECT
    CASE
        WHEN branch_count = 1 THEN '1 Branch'
        ELSE 'Multiple Branches'
    END AS manager_workload,
    COUNT(*) AS manager_count
FROM (
    SELECT
        manager_name,
        COUNT(branch_id) AS branch_count
    FROM branches
    GROUP BY manager_name
) AS manager_summary
GROUP BY manager_workload
ORDER BY manager_count DESC;


-- 5. Average Branches per Manager

SELECT
    COUNT(DISTINCT manager_name) AS total_managers,
    COUNT(branch_id) AS total_branches,
    ROUND(
        COUNT(branch_id) * 1.0 / COUNT(DISTINCT manager_name),
        2
    ) AS avg_branches_per_manager
FROM branches;


-- 6. Branch Name Duplication Check

SELECT
    branch_name,
    COUNT(branch_id) AS branch_count
FROM branches
GROUP BY branch_name
HAVING COUNT(branch_id) > 1
ORDER BY branch_count DESC;


-- 7. Branch Data Quality Summary

SELECT
    COUNT(*) AS total_branches,
    SUM(CASE WHEN branch_id IS NULL THEN 1 ELSE 0 END) AS missing_branch_id,
    SUM(CASE WHEN branch_name IS NULL OR TRIM(branch_name) = '' THEN 1 ELSE 0 END) AS missing_branch_name,
    SUM(CASE WHEN manager_name IS NULL OR TRIM(manager_name) = '' THEN 1 ELSE 0 END) AS missing_manager_name,
    SUM(CASE WHEN city IS NULL OR TRIM(city) = '' THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN country IS NULL OR TRIM(country) = '' THEN 1 ELSE 0 END) AS missing_country
FROM branches;











































































