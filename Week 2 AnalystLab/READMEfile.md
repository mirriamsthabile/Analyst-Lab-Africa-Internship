<img width="1704" height="677" alt="Week 2 Dashboard" src="https://github.com/user-attachments/assets/7c3c0564-038f-4788-ad17-6e4627eb2e69" />

FinTrust Business & Data Intelligence Assessment — Week 2

Author: Mirriam Sithabile Maseko Program: Data Analytics Internship, AnalystLab Week: 2 — Data Cleaning, SQL Analysis, Python EDA and Initial Power BI Dashboard

Project overview

Building on Week 1's business understanding and data profiling Week 2 moves into hands on analysis that is cleaning the data in Excel, answering business questions in SQL Server, exploring the data visually in Python and building the first version of the management dashboard in Power BI.
Week 2 summary

Data cleaning (Excel) Standardized the inconsistent Transaction_DateTime format using Text to Columns (MDY), filled missing Device_Type and Location values with "Unknown" rather than dropping rows and flagged  but did not remove  potential outliers in Amount_NGN using a per-transaction-type Top 10% conditional formatting check.

SQL analysis Answered 8 business questions in SQL Server spanning customer behaviour, transaction activity, transaction value, channels, status, customer segments and risk review patterns. Each query is documented with its business question, the SQL itself, the result and a written interpretation — see FinTrust_Week2_SQL_Analysis.sql.

Key findings:

Everyday is the dominant customer segment (47% of the base)
Mobile App handles 42.5% of all transactions — the busiest channel by far
90.5% transaction success rate of approximately 9.5% fail, reverse or remain pending
Risk review flag rate of approximately 19.6% is nearly identical across all customer segments — risk doesn't appear to be segment driven.

Python EDA 
I built 8 visualizations covering customer segments, transaction types, transaction amounts, channels, status, international transactions, customer behaviour and risk review patterns. I confirmed the SQL findings visually and added two additional insights that is the right skewed shape of the transaction amount distribution and that domestic transactions average higher than international ones.

Power BI dashboard 
I built the first management dashboard with 6 KPIs Total Customers, Total Transactions, Total Transaction Value, Average Transaction Value, Transaction Success Rate, Risk Review Rate, visuals for customer segments, transaction types, channels, trends, status, and risk patterns and slicers for date range, customer segment, channel, transaction type and account status.

Tools used
Excel — data cleaning 
SQL Server  — business question analysis
Python (Pandas, Matplotlib) — exploratory data analysis and visualization
Power BI Desktop — management dashboard


Below is my summary for week 2 
Week 2 complete — data cleaning, SQL analysis, Python EDA, initial dashboard  
