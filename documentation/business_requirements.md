# FinSight — Business Requirements

## 1. Project Overview

FinSight is a financial analytics project designed to analyze banking data across customers, accounts, transactions, cards, loans, and branches. The project aims to transform raw financial data into meaningful business insights through data cleaning, SQL analysis, KPI development, and interactive Power BI reporting.


## 2. Business Objective

The primary objective of FinSight is to provide data-driven insights into the bank's financial performance, customer behavior, transaction activity, loan portfolio, card usage, and branch operations. The analysis will help identify important trends, high-value customer segments, operational performance gaps, and potential financial risk areas to support better business decision-making.


## 3. Business Problems

### 3.1 Customer Behavior
The bank lacks a consolidated understanding of customer activity, financial behavior, and customer value.

### 3.2 Account Performance
The bank needs better visibility into account balances, account types, and account activity.

### 3.3 Transaction Performance
The bank needs to understand transaction volume, transaction value, transaction types, and changes over time.

### 3.4 Loan Risk
The bank needs to identify loan performance patterns and areas associated with delinquency or default.

### 3.5 Card Usage
The bank needs to understand card adoption, usage, spending behavior, and customer engagement.

### 3.6 Branch Performance
The bank needs to compare branches based on customer activity, transaction performance, account balances, and loan activity.


## 4. Analytical Domains

### 4.1 Customer Analytics
Analyze customer profiles, activity levels, financial behavior, product relationships, segmentation, and customer value.

### 4.2 Account Analytics
Analyze account types, account status, balances, account activity, and balance distribution.

### 4.3 Transaction Analytics
Analyze transaction volume, transaction value, transaction types, time-based trends, customer transaction behavior, and potential anomalies.

### 4.4 Card Analytics
Analyze card adoption, card status, spending activity, transaction frequency, utilization, and customer card behavior.

### 4.5 Loan Analytics
Analyze loan products, loan amounts, outstanding balances, repayment behavior, delinquency, defaults, and loan risk patterns.

### 4.6 Branch Analytics
Analyze branch-level customer activity, account balances, transaction performance, loan portfolios, and overall branch performance.


# FinSight — Business Questions & Analytical Solutions

## 5. Business Questions

This section defines the key business questions that FinSight will answer through SQL analysis, KPI development, and Power BI reporting. The analytical solutions describe how each question will be addressed using the available financial data.

---

## 5.1 Customer Analytics

### Q1. How many customers does the bank have?

**Analytical Solution:**
Calculate the distinct number of customers using `COUNT(DISTINCT customer_id)`.

**Expected Output:**
Total customer count.

---

### Q2. What percentage of customers are active?

**Analytical Solution:**
Define an active customer based on recent financial activity, such as having at least one qualifying transaction within a defined period. Calculate:

`Active Customers / Total Customers × 100`

**Expected Output:**
Customer activity rate.

---

### Q3. Which customer segments have the highest financial activity?

**Analytical Solution:**
Create customer segments based on measurable behavioral attributes such as transaction frequency, transaction value, account balance, and product usage. Compare activity metrics across segments.

**Expected Output:**
Customer segment ranking by financial activity.

---

### Q4. Which customers have the highest overall financial value?

**Analytical Solution:**
Develop a customer value framework using factors such as account balances, transaction activity, card spending, and loan relationships. Rank customers using the resulting value score.

**Expected Output:**
Top high-value customers and their financial contribution.

---

### Q5. Which customers use multiple banking products?

**Analytical Solution:**
Identify whether each customer owns or uses products such as accounts, cards, and loans. Count the number of distinct products associated with each customer.

**Expected Output:**
Customers ranked by number of banking products used.

---

### Q6. How does customer activity change over time?

**Analytical Solution:**
Calculate customer activity by month or quarter and compare periods using trend analysis and month-over-month calculations.

**Expected Output:**
Customer activity trend over time.

---

# 5.2 Account Analytics

### Q7. How many accounts does the bank maintain?

**Analytical Solution:**
Calculate the distinct number of accounts using `COUNT(DISTINCT account_id)`.

**Expected Output:**
Total number of accounts.

---

### Q8. Which account types are most common?

**Analytical Solution:**
Group accounts by account type and count the number of accounts in each category.

**Expected Output:**
Account type distribution.

---

### Q9. Which account types hold the highest total balance?

**Analytical Solution:**
Calculate the total account balance using `SUM(balance)` for each account type.

**Expected Output:**
Account types ranked by total balance.

---

### Q10. What is the average account balance by account type?

**Analytical Solution:**
Calculate `AVG(balance)` grouped by account type.

**Expected Output:**
Average balance for each account category.

---

### Q11. What percentage of accounts are active?

**Analytical Solution:**
Count accounts classified as active and divide by total accounts.

`Active Accounts / Total Accounts × 100`

**Expected Output:**
Account activity rate.

---

### Q12. How is the total deposit balance distributed across customers?

**Analytical Solution:**
Aggregate account balances at the customer level and analyze balance concentration using rankings, percentages, and customer segments.

**Expected Output:**
Customer deposit distribution and concentration.

---

# 5.3 Transaction Analytics

### Q13. What is the total number of transactions?

**Analytical Solution:**
Calculate the number of unique transactions using `COUNT(DISTINCT transaction_id)`.

**Expected Output:**
Total transaction volume.

---

### Q14. What is the total transaction value?

**Analytical Solution:**
Calculate the total monetary value using `SUM(transaction_amount)`.

**Expected Output:**
Total transaction value.

---

### Q15. Which transaction types are most common?

**Analytical Solution:**
Group transactions by transaction type and count the number of transactions.

**Expected Output:**
Transaction type ranking by volume.

---

### Q16. Which transaction types generate the highest transaction value?

**Analytical Solution:**
Group transactions by type and calculate total transaction value for each type.

**Expected Output:**
Transaction type ranking by monetary value.

---

### Q17. How does transaction activity change month over month?

**Analytical Solution:**
Aggregate transaction volume and value by month. Use SQL window functions such as `LAG()` to calculate month-over-month changes.

**Expected Output:**
Monthly transaction trend and MoM growth rate.

---

### Q18. What are the peak transaction periods?

**Analytical Solution:**
Analyze transaction volume and value by date, month, day of week, or available time attributes. Rank periods based on activity.

**Expected Output:**
Highest-activity transaction periods.

---

### Q19. Which customers generate the highest transaction value?

**Analytical Solution:**
Aggregate transaction value by customer and rank customers using `DENSE_RANK()` or `ROW_NUMBER()`.

**Expected Output:**
Top customers by transaction value.

---

### Q20. Are there unusual transaction patterns that require further investigation?

**Analytical Solution:**
Identify transactions or customer behavior that significantly deviates from normal patterns using business rules, transaction frequency, transaction amounts, and statistical thresholds.

**Expected Output:**
A list of potentially anomalous transactions or behavioral patterns requiring investigation.

**Note:** These findings will be treated as anomalies, not automatically classified as fraud.

---

# 5.4 Card Analytics

### Q21. How many cards are active?

**Analytical Solution:**
Filter cards using the defined active status and count the distinct active cards.

**Expected Output:**
Total active cards.

---

### Q22. Which card types are most widely used?

**Analytical Solution:**
Group cards or card transactions by card type and calculate usage volume.

**Expected Output:**
Card type ranking by usage.

---

### Q23. Which card types generate the highest spending?

**Analytical Solution:**
Calculate total card transaction value by card type.

**Expected Output:**
Card type ranking by spending value.

---

### Q24. What is the average card transaction value?

**Analytical Solution:**
Calculate the average transaction amount for card-based transactions using `AVG(transaction_amount)`.

**Expected Output:**
Average card transaction value.

---

### Q25. Which customers have the highest card spending?

**Analytical Solution:**
Aggregate card spending by customer and rank customers based on total card transaction value.

**Expected Output:**
Top customers by card spending.

---

### Q26. How does card usage change over time?

**Analytical Solution:**
Aggregate card transactions by month and analyze transaction count, spending value, and growth rates.

**Expected Output:**
Card usage trend over time.

---

# 5.5 Loan Analytics

### Q27. What is the total loan portfolio?

**Analytical Solution:**
Calculate the total outstanding loan balance across all active loans.

**Expected Output:**
Total outstanding loan portfolio.

---

### Q28. Which loan types have the highest outstanding balances?

**Analytical Solution:**
Group loans by loan type and calculate total outstanding balance.

**Expected Output:**
Loan type ranking by outstanding exposure.

---

### Q29. What is the average loan amount?

**Analytical Solution:**
Calculate the average original loan amount using `AVG(loan_amount)`.

**Expected Output:**
Average loan size.

---

### Q30. What percentage of loans are delinquent?

**Analytical Solution:**
Identify loans meeting the defined delinquency criteria and calculate:

`Delinquent Loans / Total Loans × 100`

**Expected Output:**
Loan delinquency rate.

---

### Q31. What percentage of loans are in default?

**Analytical Solution:**
Count loans classified as defaulted and divide by total loans.

`Defaulted Loans / Total Loans × 100`

**Expected Output:**
Loan default rate.

---

### Q32. Which customer segments have higher loan risk?

**Analytical Solution:**
Compare delinquency and default rates across customer segments.

**Expected Output:**
Customer segments ranked by loan risk indicators.

---

### Q33. Which branches have the highest loan exposure?

**Analytical Solution:**
Aggregate outstanding loan balances by branch and rank branches.

**Expected Output:**
Branches ranked by loan exposure.

---

### Q34. How does loan performance change over time?

**Analytical Solution:**
Analyze loan issuance, repayments, outstanding balances, delinquency, and defaults by month or quarter.

**Expected Output:**
Loan portfolio and risk trends over time.

---

# 5.6 Branch Analytics

### Q35. Which branches have the highest number of customers?

**Analytical Solution:**
Count distinct customers associated with each branch and rank branches.

**Expected Output:**
Branch ranking by customer base.

---

### Q36. Which branches handle the highest transaction volume?

**Analytical Solution:**
Count transactions associated with each branch.

**Expected Output:**
Branch ranking by transaction volume.

---

### Q37. Which branches handle the highest transaction value?

**Analytical Solution:**
Calculate total transaction value by branch.

**Expected Output:**
Branch ranking by transaction value.

---

### Q38. Which branches have the largest loan portfolios?

**Analytical Solution:**
Calculate total outstanding loan balances by branch.

**Expected Output:**
Branch ranking by loan portfolio size.

---

### Q39. Which branches have the highest deposit balances?

**Analytical Solution:**
Aggregate account balances by branch.

**Expected Output:**
Branch ranking by deposit balance.

---

### Q40. Which branches perform above or below the overall bank average?

**Analytical Solution:**
Calculate key branch-level KPIs and compare each branch against the overall bank average using SQL analytical functions.

**Expected Output:**
Branches performing above or below the bank benchmark.

---

# Summary of Analytical Approach

The 40 business questions will be answered through the following analytical workflow:

**Business Question → Required Data → SQL Analysis → KPI → Validation → Insight → Business Recommendation**

The analysis will progressively use:

* SQL aggregations
* JOINs
* Subqueries
* CTEs
* CASE statements
* Window functions
* Ranking
* Time-series analysis
* Statistical/business-rule-based anomaly detection
* KPI calculations
* Power BI measures and visualizations

The final analysis will use actual project data to produce measurable results. No numerical conclusions will be assumed before the dataset has been profiled and validated.



## KPI Dictionary
| KPI                           | Definition                                                                 |
| ----------------------------- | -------------------------------------------------------------------------- |
| **Total Customers**           | Distinct customers within the analysis scope                               |
| **Active Customers**          | Customers with ≥1 qualifying transaction in the previous 90 days           |
| **Customer Activity Rate**    | Active customers ÷ total customers × 100                                   |
| **Total Accounts**            | Distinct accounts within the analysis scope                                |
| **Active Accounts**           | Accounts meeting the defined active-status criteria                        |
| **Total Transaction Volume**  | Number of qualifying transactions                                          |
| **Total Transaction Value**   | Sum of qualifying transaction amounts                                      |
| **Average Transaction Value** | Total transaction value ÷ qualifying transaction count                     |
| **Total Deposit Balance**     | Sum of qualifying customer account balances                                |
| **Total Loan Portfolio**      | Sum of outstanding balances for loans in scope                             |
| **Loan Default Rate**         | Defaulted loans ÷ total loans × 100                                        |
| **Loan Delinquency Rate**     | Delinquent loans ÷ total loans × 100                                       |
| **Active Cards**              | Cards meeting the defined active-status criteria                           |
| **Total Card Spending**       | Sum of qualifying card transaction amounts                                 |
| **Customer Value Score**      | Composite measure of customer financial value and engagement               |
| **Branch Performance**        | Composite assessment of branch-level financial and operational performance |


## 7. Expected Business Outcomes

### 7.1 Customer Insights
Develop a clear understanding of customer activity, segmentation, financial behavior, product relationships, and customer value.

### 7.2 Financial Performance Visibility
Provide a consolidated view of key financial indicators including account balances, transaction activity, deposits, loans, and card spending.

### 7.3 Transaction Insights
Identify transaction trends, high-value transaction categories, peak activity periods, and unusual transaction patterns requiring further investigation.

### 7.4 Loan Risk Visibility
Provide visibility into loan portfolio performance, delinquency, defaults, higher-risk customer segments, and branch-level loan exposure.

### 7.5 Branch Performance
Enable comparison of branches using standardized financial and operational KPIs to identify high-performing branches and areas requiring further investigation.

### 7.6 Data-Driven Decision Making
Transform raw financial records into measurable KPIs, actionable insights, and evidence-based business recommendations.

### 7.7 Interactive Analytics
Deliver an interactive Power BI reporting solution that enables users to explore customer, account, transaction, card, loan, and branch performance through dynamic filters and visualizations.






































































