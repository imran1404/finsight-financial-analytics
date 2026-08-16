# FinSight — Dataset Inventory

## 1. Dataset Overview

FinSight uses a banking dataset containing customer, account, transaction, card, loan, merchant, and branch data.

The supplied dataset package contains CSV files, a SQLite database, and SQL scripts containing database schema and data insertion statements.

The dataset will be treated as the source data for the FinSight analytics project. No structural or business assumptions will be made until the data has been profiled and validated.

---

## 2. Dataset Package Structure

```text
banking_dataset_kaggle/
└── data/
    ├── csv/
    │   ├── accounts.csv
    │   ├── branches.csv
    │   ├── cards.csv
    │   ├── customers.csv
    │   ├── loans.csv
    │   └── merchants.csv
    │
    ├── database/
    │   └── bank_sqlite.db
    │
    └── sql/
        ├── schema.sql
        ├── bank.sql
        ├── accounts_inserts.sql
        ├── branches_inserts.sql
        ├── cards_inserts.sql
        ├── customers_inserts.sql
        ├── loans_inserts.sql
        ├── merchants_inserts.sql
        └── transactions_inserts.sql
```

---

## 3. Table Inventory

| Table        | Primary Source       | Approximate Row Count | Column Count |
| ------------ | -------------------- | --------------------: | -----------: |
| Customers    | CSV / SQLite         |                50,000 |            7 |
| Accounts     | CSV / SQLite         |                75,000 |            5 |
| Transactions | SQLite / SQL Inserts |             1,000,000 |            5 |
| Cards        | CSV / SQLite         |               100,000 |            4 |
| Loans        | CSV / SQLite         |                30,000 |            5 |
| Merchants    | CSV / SQLite         |                 5,000 |            3 |
| Branches     | CSV / SQLite         |                   500 |            5 |

---

## 4. Customers

### Columns

```text
customer_id
first_name
last_name
email
city
credit_score
created_at
```

### Row Count

50,000

### Initial Analytical Use

The customer table can support customer profiling, customer segmentation, geographic analysis, credit-score analysis, and customer acquisition analysis.

---

## 5. Accounts

### Columns

```text
account_id
customer_id
account_type
balance_usd
open_date
```

### Row Count

75,000

### Initial Analytical Use

The account table can support account distribution, account-type analysis, balance analysis, and customer-to-account relationship analysis.

---

## 6. Transactions

### Columns

```text
transaction_id
account_id
merchant_id
amount_usd
transaction_date
```

### Row Count

1,000,000

### Source

Transactions are available through the SQLite database and SQL insertion scripts rather than as a separate CSV file.

### Initial Analytical Use

The transaction table will serve as a primary analytical dataset for transaction volume, transaction value, customer activity, merchant performance, time-series analysis, rankings, and advanced SQL analysis.

---

## 7. Cards

### Columns

```text
card_id
account_id
card_type
expiration_date
```

### Row Count

100,000

### Initial Analytical Use

The card table can support card-type analysis, card distribution, account-to-card relationships, and card expiration analysis.

Further investigation is required to determine how card-level activity can be connected to transactions.

---

## 8. Loans

### Columns

```text
loan_id
customer_id
loan_amount
interest_rate
start_date
```

### Row Count

30,000

### Initial Analytical Use

The loan table can support loan volume, loan amount, interest-rate analysis, customer loan exposure, and loan trends.

The dataset does not currently provide explicit default or delinquency status fields. Therefore, default-rate and delinquency-rate analysis cannot be assumed to be directly supported.

---

## 9. Merchants

### Columns

```text
merchant_id
merchant_name
city
```

### Row Count

5,000

### Initial Analytical Use

The merchant table can support merchant transaction analysis, merchant transaction value, customer reach, and geographic merchant analysis.

---

## 10. Branches

### Columns in SQLite

```text
branch_id
branch_name
manager_name
city
country
```

### Row Count

500

### Initial Analytical Use

The branch table can provide branch-level descriptive information.

However, the current dataset does not yet establish a clear relationship between branches and accounts, transactions, or loans. This relationship will require further investigation during data profiling.

---

## 11. Initial Data Observations

The initial dataset inspection identified the following observations:

1. Transactions contain approximately one million records and represent the largest analytical table.
2. Transactions are available in the SQLite database and SQL insertion scripts but not as a separate CSV file.
3. The branches CSV contains three columns, while the SQLite branches table contains five columns.
4. The loan dataset does not contain explicit default or delinquency status fields.
5. The card dataset does not contain a dedicated card-transaction table.
6. A direct branch relationship to accounts, transactions, or loans has not yet been established.
7. The dataset contains multiple related entities that can support relational and analytical SQL analysis.
8. Further data profiling is required before finalizing the analytical scope and KPI definitions.

---

## 12. Status

This inventory documents the dataset as received.

No data cleaning, transformation, deletion, or structural modification has been performed at this stage.

The next phase will profile the individual tables, columns, data types, missing values, duplicates, key integrity, date ranges, and relationships.

