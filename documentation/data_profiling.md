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



## 3. Accounts Table Profiling

### 3.1 Table Overview

The `accounts` table contains banking account information linked to customers.

| Attribute | Result |
|---|---:|
| Table | `accounts` |
| Rows | 75,000 |
| Columns | 5 |
| Identifier | `account_id` |

Columns:

- `account_id`
- `customer_id`
- `account_type`
- `balance_usd`
- `open_date`

---

### 3.2 Row Count and Uniqueness

The `accounts` table contains **75,000 records**.

`account_id` was checked for uniqueness:

| Check | Result |
|---|---:|
| Total rows | 75,000 |
| Unique `account_id` | 75,000 |
| Duplicate `account_id` | 0 |

This confirms that each account has a unique identifier.

---

### 3.3 NULL Analysis

NULL values were checked across key account fields.

| Column | NULL Records |
|---|---:|
| `account_id` | 0 |
| `customer_id` | 0 |
| `account_type` | 0 |
| `balance_usd` | 0 |
| `open_date` | 0 |

No missing values were identified in the profiled account fields.

---

### 3.4 Customer Relationship Integrity

The `customer_id` field was checked for both NULL values and unmatched customer records.

| Check | Result |
|---|---:|
| Accounts with NULL `customer_id` | 0 |
| Orphan accounts | 0 |

Every account is associated with a valid customer record in the `customers` table.

---

### 3.5 Account Type Distribution

Account types were grouped to understand the distribution of banking products.

| Account Type | Account Count |
|---|---:|
| Savings | 25,102 |
| Checking | 25,080 |
| Business | 24,818 |

The three account types are relatively evenly distributed, with approximately 25,000 accounts in each category.

---

### 3.6 Balance Analysis

Balance statistics were analyzed by account type.

| Account Type | Account Count | Average Balance | Minimum Balance | Maximum Balance |
|---|---:|---:|---:|---:|
| Checking | 25,080 | $100,097.20 | $13.67 | $199,999.79 |
| Savings | 25,102 | $99,963.17 | $22.89 | $199,991.35 |
| Business | 24,818 | $99,702.86 | $22.19 | $199,998.45 |

Checking accounts have the highest average balance at approximately **$100,097**, while Business accounts have the lowest average balance at approximately **$99,703**.

---

### 3.7 Balance Distribution

Account balances were segmented into ranges to understand the distribution beyond the average.

| Balance Range | Account Count |
|---|---:|
| 1M+ | 37,454 |
| 50K - 1M | 18,774 |
| 10K - 50K | 15,019 |
| Below 10K | 3,753 |

The majority of accounts fall into the **1M+** category based on the dataset's balance values.

---

### 3.8 Negative Balance Check

Accounts with negative balances were checked.

| Check | Result |
|---|---:|
| Accounts with negative balance | 0 |

No negative account balances were identified.

---

### 3.9 Account Opening Date Analysis

Account opening dates were analyzed by account type.

| Account Type | First Account | Latest Account | Account Count |
|---|---|---|---:|
| Checking | 2019-01-01 | 2025-12-31 | 25,080 |
| Business | 2019-01-01 | 2025-12-31 | 24,818 |
| Savings | 2019-01-01 | 2025-12-31 | 25,102 |

All three account types span the same overall period from **2019 to 2025**.

---

### 3.10 Accounts Data Quality Summary

The profiling indicates that the `accounts` table is structurally clean and suitable for downstream analysis.

**Key findings:**

- 75,000 account records are available.
- `account_id` is unique across all records.
- No NULL values were identified in the key account fields.
- All accounts have a valid `customer_id`.
- No orphan accounts were identified.
- Three account types are present: Checking, Savings, and Business.
- No negative balances were identified.
- Account opening dates are available for all records.
- Account records span from 2019 through 2025.

The `accounts` table is therefore suitable for further SQL analysis and integration with other banking tables.



## 3.11 Cards Data Quality Summary

The profiling indicates that the `cards` table is structurally clean and suitable for downstream analysis.

Key findings:

- 100,000 card records are available.
- `card_id` is fully populated and unique across all records.
- No NULL values were identified in `card_id`.
- All cards have a valid `account_id`.
- No orphan cards were identified.
- Two card types are present: Debit and Credit.
- Debit cards account for 50,004 records, while Credit cards account for 49,996 records.
- All cards have a valid `expiration_date`.
- 12,561 cards are expired, while 87,439 cards remain active based on the 2025 year-end reference date.
- Card expiration dates span from 2025 through 2032.
- Cards are distributed relatively evenly across expiration years and card types.
- Accounts with cards have between 1 and 8 cards, with an average of 1.81 cards per account.

The `cards` table is therefore suitable for further analysis of card distribution, expiration patterns, account relationships, and card portfolio composition.



## 3.12 Loans Table Profiling

The `loans` table contains loan information linked to customers.

### 3.12.1 Table Overview

Attribute | Result
--- | ---
Table | `loans`
Rows | 30,000
Columns | 5
Identifier | `loan_id`

Columns:

* `loan_id`
* `customer_id`
* `loan_amount`
* `interest_rate`
* `start_date`

---

### 3.12.2 Loan ID Validation

The `loan_id` field was checked for NULL values and uniqueness.

Check | Result
--- | ---
Total Rows | 30,000
Non-NULL `loan_id` | 30,000
NULL `loan_id` | 0
Unique `loan_id` | 30,000

The total number of loan records matches the number of unique loan IDs.

Conclusion: `loan_id` is fully populated and unique across the dataset.

---

### 3.12.3 Customer Relationship Analysis

The `customer_id` field was checked for missing values and customer coverage.

Check | Result
--- | ---
Total Loan Records | 30,000
Non-NULL `customer_id` | 30,000
NULL `customer_id` | 0
Distinct Customers with Loans | 22,540

The 30,000 loan records are associated with 22,540 distinct customers.

The customer relationship was also validated against the `customers` table to identify potential orphan loan records.

---

### 3.12.4 Loan Amount Analysis

Loan amount statistics were analyzed to identify missing and invalid monetary values.

Metric | Result
--- | ---
Total Loan Records | 30,000
Non-NULL `loan_amount` | 30,000
NULL `loan_amount` | 0
Minimum Loan Amount | 1,015.54
Maximum Loan Amount | 299,996.69
Average Loan Amount | 150,436.66
Invalid Loan Amounts | 0

No NULL, zero, or negative loan amounts were identified.

Conclusion: `loan_amount` is complete and contains valid positive monetary values.

---

### 3.12.5 Interest Rate Analysis

Interest rates were profiled for completeness, range, and invalid values.

Metric | Result
--- | ---
Total Loan Records | 30,000
Non-NULL `interest_rate` | 30,000
NULL `interest_rate` | 0
Minimum Interest Rate | 2%
Maximum Interest Rate | 15%
Average Interest Rate | 8.54%
Invalid Interest Rates | 0

All interest rate values fall within the observed 2%–15% range.

Conclusion: `interest_rate` is complete and contains no invalid values based on the profiling rules applied.

---

### 3.12.6 Loan Start Date Analysis

The `start_date` field was checked for completeness, date range, and valid datetime values.

Metric | Result
--- | ---
Total Loan Records | 30,000
Non-NULL `start_date` | 30,000
NULL `start_date` | 0
Earliest Start Date | 2019-01-01 00:29:38
Latest Start Date | 2025-12-31 20:11:50
Invalid Datetime Values | 0

All loan records contain valid start dates.

The loan records span from January 2019 through December 2025.

---

### 3.12.7 Loans Data Quality Summary

Data Quality Check | Result | Status
--- | --- | ---
Loan Row Count | 30,000 | PASS
Unique `loan_id` | 30,000 | PASS
NULL `loan_id` | 0 | PASS
NULL `customer_id` | 0 | PASS
Distinct Customers with Loans | 22,540 | INFO
NULL `loan_amount` | 0 | PASS
Invalid Loan Amounts | 0 | PASS
NULL `interest_rate` | 0 | PASS
Invalid Interest Rates | 0 | PASS
NULL `start_date` | 0 | PASS
Invalid Start Dates | 0 | PASS
Loan Date Range | 2019–2025 | PASS

---

### 3.12.8 Key Profiling Conclusions

1. The `loans` table contains 30,000 records.
2. `loan_id` is fully populated and unique across all loan records.
3. No NULL `customer_id` values were identified.
4. The dataset contains 22,540 distinct customers with loans.
5. Loan amounts range from $1,015.54 to $299,996.69.
6. No zero or negative loan amounts were identified.
7. The average loan amount is approximately $150,436.66.
8. Interest rates range from 2% to 15%, with an average of 8.54%.
9. No NULL or invalid interest rates were identified.
10. All loan records contain valid `start_date` values.
11. Loan start dates span from January 2019 through December 2025.
12. The `loans` table is structurally clean and suitable for downstream SQL analysis, subject to the customer relationship integrity check.

---

### 3.12.9 Profiling Status

Loans Table: COMPLETED




## 3.13 Merchants Data Profiling

The `merchants` table was profiled to assess record completeness, identifier uniqueness, duplicate values, and geographic coverage.

### 3.13.1 Record and Identifier Analysis

The `merchant_id` field was checked for missing values and uniqueness.

| Check | Result |
|---|---:|
| Total Merchant Records | 5,000 |
| Non-NULL `merchant_id` | 5,000 |
| NULL `merchant_id` | 0 |
| Unique `merchant_id` | 5,000 |

All 5,000 merchant records contain a non-NULL and unique `merchant_id`.

### 3.13.2 Merchant Name Analysis

The `merchant_name` field was checked for missing, blank, and repeated values.

| Check | Result |
|---|---:|
| Total Merchant Records | 5,000 |
| Non-NULL `merchant_name` | 5,000 |
| NULL `merchant_name` | 0 |
| Blank `merchant_name` | 0 |
| Unique Merchant Names | 4,592 |
| Repeated Merchant Names | 261 |

There are 4,592 unique merchant names across 5,000 records.

Repeated merchant names were investigated further to determine whether they represented duplicate merchant records.

The `merchant_name` and `city` combination was checked for duplicate records.

| Check | Result |
|---|---:|
| Duplicate `merchant_name + city` combinations | 0 |

No duplicate records were identified based on the combination of `merchant_name` and `city`.

Therefore, repeated merchant names were not treated as data-quality errors.

### 3.13.3 City Analysis

The `city` field was checked for missing, blank, and unique values.

| Check | Result |
|---|---:|
| Total Merchant Records | 5,000 |
| Non-NULL `city` | 5,000 |
| NULL `city` | 0 |
| Blank `city` | 0 |
| Unique Cities | 4,317 |

All merchant records contain a non-NULL and non-blank city value.

### 3.13.4 Merchants Data Quality Summary

The `merchants` table contains 5,000 records with complete and unique merchant identifiers.

No NULL or blank values were identified in the `merchant_id`, `merchant_name`, or `city` fields.

Although 261 merchant names appear more than once, further validation confirmed that no duplicate `merchant_name + city` combinations exist. These repeated names were therefore considered legitimate repeated merchant names rather than duplicate records.

Overall, the `merchants` table passed the basic data-quality checks and requires no immediate cleaning.




## 3.14 Transactions Data Profiling

The `transactions` table was profiled to assess record completeness, identifier uniqueness, referential integrity, transaction amount validity, date validity, and yearly transaction distribution.

### 3.14.1 Record and Transaction ID Analysis

The `transaction_id` field was checked for missing values and uniqueness.

| Check | Result |
|---|---:|
| Total Transactions | 1,000,000 |
| Non-NULL `transaction_id` | 1,000,000 |
| NULL `transaction_id` | 0 |
| Unique `transaction_id` | 1,000,000 |

All 1,000,000 transaction records contain a non-NULL and unique `transaction_id`.

### 3.14.2 Account ID Analysis

The `account_id` field was checked for missing values, uniqueness, and referential integrity.

| Check | Result |
|---|---:|
| Total Transactions | 1,000,000 |
| Non-NULL `account_id` | 1,000,000 |
| NULL `account_id` | 0 |
| Distinct Accounts | 75,000 |
| Orphan Transactions | 0 |

All transactions contain a valid `account_id`, and no transactions reference an account that does not exist in the `accounts` table.

### 3.14.3 Merchant ID Analysis

The `merchant_id` field was checked for missing values, uniqueness, and referential integrity.

| Check | Result |
|---|---:|
| Total Transactions | 1,000,000 |
| Non-NULL `merchant_id` | 1,000,000 |
| NULL `merchant_id` | 0 |
| Distinct Merchants | 5,000 |
| Orphan Transactions | 0 |

All transactions contain a valid `merchant_id`, and no transactions reference a merchant that does not exist in the `merchants` table.

### 3.14.4 Transaction Amount Analysis

The `amount_usd` field was assessed for missing values, invalid values, minimum, maximum, and average transaction amounts.

| Check | Result |
|---|---:|
| Total Transactions | 1,000,000 |
| Non-NULL `amount_usd` | 1,000,000 |
| NULL `amount_usd` | 0 |
| Minimum Amount | $1.02 |
| Maximum Amount | $9,999.98 |
| Average Amount | $5,001.16 |
| Invalid Amounts (`<= 0`) | 0 |

All transaction amounts are populated and positive. No zero or negative transaction amounts were identified.

### 3.14.5 Transaction Date Analysis

The `transaction_date` field was checked for missing values, valid date range, and invalid dates.

| Check | Result |
|---|---:|
| Total Transactions | 1,000,000 |
| Non-NULL `transaction_date` | 1,000,000 |
| NULL `transaction_date` | 0 |
| Earliest Transaction | 2019-01-01 |
| Latest Transaction | 2025-12-31 |
| Invalid Dates | 0 |

All transaction records contain valid dates within the expected 2019–2025 period.

### 3.14.6 Yearly Transaction Distribution

Transaction volume and transaction value were analyzed across each year.

| Year | Transaction Count |
|---|---:|
| 2019 | 143,046 |
| 2020 | 142,989 |
| 2021 | 142,765 |
| 2022 | 142,843 |
| 2023 | 142,969 |
| 2024 | 143,063 |
| 2025 | 142,325 |
| **Total** | **1,000,000** |

Transaction volume remains highly consistent across the seven-year period, with approximately 142,000–143,000 transactions recorded annually.

### 3.14.7 Key Profiling Conclusions

1. The `transactions` table contains 1,000,000 records.
2. `transaction_id` is fully populated and unique across all transaction records.
3. No NULL `account_id` values were identified.
4. The transactions involve 75,000 distinct accounts.
5. No orphan account references were identified.
6. No NULL `merchant_id` values were identified.
7. The transactions involve 5,000 distinct merchants.
8. No orphan merchant references were identified.
9. Transaction amounts range from $1.02 to $9,999.98.
10. The average transaction amount is approximately $5,001.16.
11. No zero or negative transaction amounts were identified.
12. All transaction records contain valid `transaction_date` values.
13. Transaction dates span from January 2019 through December 2025.
14. No invalid transaction dates were identified.
15. Transaction volume is consistently distributed across all seven years.
16. The `transactions` table is structurally clean and suitable for downstream financial transaction analysis.

### 3.14.8 Profiling Status

Transactions Table: COMPLETED



---

## 3.15 Branches Table Profiling

### 3.15.1 Row Count and Branch ID Integrity

The `branches` table contains **500 records**.

| Metric | Result |
|---|---:|
| Total rows | 500 |
| Non-NULL `branch_id` | 500 |
| NULL `branch_id` | 0 |
| Unique `branch_id` | 500 |

The `branch_id` field is fully populated and unique across all branch records, indicating strong identifier integrity.

---

### 3.15.2 Branch Name Completeness and Uniqueness

The `branch_name` field contains no NULL or blank values.

| Metric | Result |
|---|---:|
| Total rows | 500 |
| Non-NULL `branch_name` | 500 |
| NULL `branch_name` | 0 |
| Blank `branch_name` | 0 |

Duplicate analysis identified **8 branch names appearing more than once**. These represent multiple branch records sharing the same branch name and should not automatically be treated as data errors because each record has a unique `branch_id`.

---

### 3.15.3 Manager Name Completeness

The `manager_name` field is fully populated.

| Metric | Result |
|---|---:|
| Total rows | 500 |
| Non-NULL `manager_name` | 500 |
| NULL `manager_name` | 0 |
| Blank `manager_name` | 0 |

One manager, **Daniel Brown**, is associated with two branch records. This may represent a legitimate management assignment and does not constitute an identifier integrity issue.

---

### 3.15.4 Geographic Data Completeness

The `city` and `country` fields contain no populated values.

| Field | Total Rows | Non-NULL | NULL | Blank |
|---|---:|---:|---:|---:|
| `city` | 500 | 0 | 500 | 0 |
| `country` | 500 | 0 | 500 | 0 |

This represents a significant data completeness limitation. Geographic analysis at the city or country level cannot be reliably performed using the current `branches` table.

These missing values should be documented as a source-data limitation rather than manually populated without a verified source.

---

### 3.15.5 Key Profiling Conclusions

1. The `branches` table contains **500 records**.
2. `branch_id` is fully populated and unique across all 500 branch records.
3. No NULL or blank `branch_name` values were identified.
4. Eight branch names appear more than once across the dataset.
5. Duplicate branch names do not imply duplicate records because each branch has a unique `branch_id`.
6. `manager_name` is fully populated with no NULL or blank values.
7. Daniel Brown is associated with two branch records.
8. `city` is NULL for all 500 branch records.
9. `country` is NULL for all 500 branch records.
10. Geographic analysis using city or country cannot be performed reliably from the current branch data.
11. The branches table has strong identifier integrity but significant geographic data completeness limitations.

### 3.15.6 Profiling Status

**Branches Table: COMPLETED**











