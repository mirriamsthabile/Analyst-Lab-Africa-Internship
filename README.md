# FinTrust Business & Data Intelligence Assessment — Week 1

**Author:** Mirriam Sithabile Maseko
**Program:** Data Analytics Internship, AnalystLab
**Week:** 1 — Business Understanding & Data Profiling

## Project overview

This project explores how FinTrust, a fictional fintech company, can turn its raw customer and transaction data into useful business intelligence. Week 1 focuses on the groundwork that has to happen before any dashboard gets built: understanding the business questions, profiling the data, defining analytical questions, and planning KPIs.

## Datasets

| Dataset | Records | Columns | Description |
|---|---|---|---|
| `FinTrust_Customer_Data.csv` | 1,500 | 12 | Customer demographics, segment, account type, engagement, and status |
| `FinTrust_Transaction_Data.csv` | 12,000 | 11 | Individual transaction records linked to customers |

The datasets are related one-to-many: one `Customer_ID` can have many transactions.

## What's in this repo


## Week 1 summary

**Part A — Business understanding**
Identified the core business questions FinTrust management needs answered — account activity status, transaction failure/reversal rates, and whether digitally engaged customers transact more — and mapped them to stakeholders (management, finance, customers) and the decisions they support (operational and digital customer support).

**Part B — Data understanding**
Profiled both datasets: field names, data types, categorical vs. numerical variables, the date/time field and the customertransaction relationship. Flagged data quality issues to address before analysis — missing values in `Device_Type` and `Location`, and an inconsistent date format in `Transaction_DateTime`.

**Part C — Analytical questions**
Developed questions spanning customer behaviour, transaction activity, transaction value, channels, status, and risk — for example: *Is there a relationship between Digital_Engagement_Score and transaction channel choice?* and *Is there a relationship between low engagement scores and risk flags?*

**Part D — KPI planning**

| KPI | Definition | Why It Matters | Required Data |
|---|---|---|---|
| Total Transaction Value | Sum of Amount_NGN over a period | Core measure of economic activity | Amount_NGN, Transaction_DateTime |
| Transaction Failure Rate | % of transactions with Status = Failed | Shows which channels need technical fixes | Transaction_Status, Channel |
| Average Transaction Value | Mean Amount_NGN, overall and by segment | Shows spending power and segment value | Amount_NGN, Customer_Segment |
| Active Customer Rate | % of customers with Account_Status = Active | Key indicator of base health | Account_Status |
| Channel Adoption | % of transaction volume by Channel | Shows where usage is shifting | Channel |

**Part E — Dashboard planning**
Drafted a wireframe for the analytics dashboard, built around the five KPIs above, with supporting visuals for transaction value trends, failure rate by channel, average value by segment, active customer rate over time, and channel adoption mix.

## Initial analysis plan

| Week | Focus |
|---|---|
| Week 1 | Review customer and transaction data; assess quality; define business questions and KPIs; plan dashboard |
| Week 2 | Clean and analyse data; develop SQL/Python analysis; identify patterns; begin dashboard; share meaningful findings |
| Week 3 | Complete dashboard; deepen analysis; validate findings; provide outputs for integration |
| Week 4 | Test dashboard; refine visuals and insights; finalise recommendations and portfolio documentation |

## Tools

- **Excel / SQL** — initial exploration and aggregation
- **Python (Pandas)** — data profiling and cleaning
- **Power BI** — final dashboard build (Weeks 2–4)

## Status

🟢 Week 1 complete — business understanding, data profiling, analytical questions, and KPI planning done.
🔲 Week 2 — dashboard build in progress.
