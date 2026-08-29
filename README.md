# MySQL Employee Audit & Change Tracking System

A MySQL-based employee audit system that uses database triggers to automatically track `INSERT`, `UPDATE`, and `DELETE` operations. The audit log stores previous and new values, the database user, and the timestamp of each change to support troubleshooting and change investigation.

## 🛠️ Technologies

- MySQL 8.0
- MySQL Workbench
- SQL Triggers
- SQL

## 📂 Project Structure

```text
mysql-employee-audit-system/
│
├── 01_schema.sql
│   # Creates the database and required tables
│
├── 02_triggers.sql
│   # Creates AFTER INSERT, UPDATE, and DELETE audit triggers
│
├── 03_analysis_queries.sql
│   # Queries for investigating and analyzing audit log data
│
├── 04_sample_testing.sql
│   # Test INSERT, UPDATE, and DELETE operations to validate triggers
│
├── Project Documentation.pdf
│   # Detailed project documentation with database design,
│   # trigger implementation, testing, screenshots, and SRE relevance
│
└── README.md
|   # Project overview and file structure
|
|__ employee_records.csv
|   # Raw Daatset imported from Kaggle.
|   # Dataset link - https://www.kaggle.com/datasets/smayanj/employee-records-dataset?
