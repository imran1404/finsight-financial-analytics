# FinSight — Data Profiling

## 1. Purpose

This document records the initial data profiling performed on the FinSight banking dataset.

The objective is to validate table structure, identify data-quality issues, understand value distributions, and determine whether the available fields are suitable for downstream SQL analysis and Power BI reporting.

---

# 2. Customer Table Profiling

## 2.1 Table Overview

| Attribute | Result |
|---|---:|
| Table | customers |
| Total Rows | 50,000 |
| Total Columns | 7 |
| Primary Identifier | customer_id |

### Columns

1. customer_id
2. first_name
3. last_name
4. email
5. city
6. credit_score
7. created_at

---

# 3. Customer ID Validation

## 3.1 Row Count vs Unique Customer IDs

The total number of customer records was compared with the number of distinct customer IDs.

| Metric | Result |
|---|---:|
| Total Rows | 50,000 |
| Unique Customer IDs | 50,000 |

### Finding

The number of total records matches the number of distinct customer IDs.

**Conclusion:** No duplicate customer IDs were identified during the initial profiling.

---

## 3.2 NULL Customer IDs

The customer identifier was checked for missing values.

| Metric | Result |
|---|---:|
| NULL Customer IDs | 0 |

### Finding

No customer records contain a NULL `customer_id`.

**Conclusion:** `customer_id` is complete and unique within the customer dataset.

---

# 4. Credit Score Profiling

## 4.1 Credit Score Range

| Metric | Score |
|---|---:|
| Minimum Credit Score | 300 |
| Maximum Credit Score | 850 |

### Finding

The observed credit score range is 300–850.

No out-of-range values were identified through the minimum and maximum validation.

---

## 4.2 NULL Credit Scores

| Metric | Result |
|---|---:|
| NULL Credit Scores | 0 |

### Finding

No customer records contain a NULL credit score.

**Conclusion:** Credit score is complete within the current customer dataset.

---

# 5. City Profiling

## 5.1 Distinct City Values

| Metric | Result |
|---|---:|
| Distinct City Values | 25,112 |
| NULL City Values | 0 |

### Finding

The dataset contains 25,112 distinct city values across 50,000 customers.

The highest-frequency values include examples such as:

- South Michael
- East Michael
- New Michael
- Port Michael
- New Jennifer

### Data Quality Observation

The city values appear to be synthetic/generated rather than standardized real-world geographic locations.

### Analytical Decision

The `city` column should not currently be treated as a reliable geographic dimension for real-world location analysis.

The field will be retained in the dataset, but geographic business conclusions should not be drawn from it without further standardization or validation.

---

# 6. Customer Creation Date Profiling

## 6.1 Date Range

| Metric | Result |
|---|---|
| First Customer Date | 2019-01-01 01:27:50 |
| Latest Customer Date | 2025-12-31 23:16:56 |

### Finding

The customer dataset covers approximately seven years of customer creation activity.

### Analytical Opportunity

The `created_at` field can support:

- Customer acquisition trends
- Monthly customer growth
- Year-over-year customer growth
- Customer cohort analysis
- Time-based customer segmentation

---

# 7. Customer Data Quality Summary

| Data Quality Check | Result | Status |
|---|---:|---|
| Customer Row Count | 50,000 | PASS |
| Unique Customer IDs | 50,000 | PASS |
| NULL Customer IDs | 0 | PASS |
| Credit Score Minimum | 300 | PASS |
| Credit Score Maximum | 850 | PASS |
| NULL Credit Scores | 0 | PASS |
| Distinct Cities | 25,112 | REVIEW |
| NULL Cities | 0 | PASS |
| Customer Date Range | 2019–2025 | PASS |

---

# 8. Key Profiling Conclusions

1. The `customers` table contains 50,000 records.
2. `customer_id` is unique across the current dataset.
3. No NULL customer IDs were identified.
4. Credit scores range from 300 to 850.
5. No NULL credit scores were identified.
6. The `city` field contains a very high number of distinct synthetic-looking values.
7. The city field should therefore be treated cautiously for geographic analysis.
8. Customer creation dates span from January 2019 through December 2025.
9. The customer creation date provides a strong foundation for time-based analysis.

---

# 9. Profiling Status

**Customer Table: COMPLETED**

Next profiling target:

**accounts**
