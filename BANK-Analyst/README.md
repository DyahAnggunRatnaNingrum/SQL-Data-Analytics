## Data Modeling Approach

Dimensional modeling is applied to transform raw bank marketing data into structured, analysis-ready tables.  
This approach improves data consistency, readability, and analytical flexibility.

---

## Dimension Tables

### 1. Customer Dimension (`dim_customer`)
Stores customer attributes used for segmentation and behavioral analysis.

**Columns:**
- customer_key (surrogate key)
- age_group
- job
- marital
- education
- balance_bucket

**Notes:**
- `GENERATE_UUID()` is used to generate a surrogate primary key
- `SELECT DISTINCT` ensures unique combinations of customer attributes

---

### 2. Channel Dimension (`dim_channel`)
Represents the communication channel used during marketing campaigns.

**Columns:**
- channel_key (surrogate key)
- contact_type

This table enables campaign performance analysis based on contact channels.

---

### 3. Time Dimension (`dim_time`)
Stores temporal attributes related to campaign execution.

**Columns:**
- time_key (surrogate key)
- month

This dimension supports trend and seasonality analysis.

---

## BI-Ready Analytical View

### `bi_campaign_view`
A flattened SQL view created to simplify analytical queries and downstream reporting.

**Included fields:**
- age_group
- job
- marital
- education
- balance_bucket
- contact
- month
- success_flag

**success_flag definition:**
- `1` → customer subscribed
- `0` → customer did not subscribe

Boolean values are converted into numeric format to support aggregation and KPI calculations.

---

## SQL Techniques Used
- `CREATE OR REPLACE TABLE`
- `CREATE OR REPLACE VIEW`
- `SELECT DISTINCT`
- `GENERATE_UUID()`
- Basic data transformation and normalization

