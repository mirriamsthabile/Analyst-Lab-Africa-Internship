

FinTrust Business & Data Intelligence Project


This project turns FinTrust's customer and transaction data into business intelligence. It covers business understanding, data quality, SQL and Python analysis, a Power BI management dashboard, statistical validation and recommendations for management.

Data: 1500 customers and 12 000 transactions linked by Customer_ID covering 1 January to 31 March 2026.

<img width="1214" height="677" alt="Dashboard - Week 3" src="https://github.com/user-attachments/assets/9e22fe71-5512-4286-b0c5-3d027e056fa9" />


KPI	                        Value
Total Customers	            1 500
Total Transactions	        12 000
Total Transaction Value   	₦560 477 354.85
Average Transaction Value 	₦46 706.45
Transaction Success Rate	  90.47%
Risk Review Rate	          19.60%

Key findings
All findings below were tested statistically in Week 4.
1. Transaction type drives risk flagging. Transfers are flagged 28.49% of the time and Cash Withdrawals 25.31%, against 12.81% for Bill Payments. Customer segment has no effect.
2. International transactions are flagged about twice as often as domestic ones (36.88% vs 18.88%), while failing less often (2.50% vs 5.36%).
3. Segment totals follow segment size. Value per customer is statistically similar across segments.
4. Digital engagement does not predict activity correlation 0.04 with transaction count.
5. Mobile App carries 42.5% of transactions and 47% of failures which makes it the highest impact channel for reliability work though its failure rate is not that different from other channels.


Findings that did not survive validation
That SME customers are the most valuable per customer and that 317 repeat flagged customers form a risk group. Both were consistent with chance and were removed from the recommendations.


Documentation
Document	Contents
KPI documentation	Definitions, DAX, values and limitations for 10 KPIs
Data quality documentation	Issue register, cleaning log, corrections and remaining limitations
Final project documentation	Approach, findings, validation, recommendations and lessons learnt

Progress by week
Week	Focus	                                 Highlights
1	    Business understanding and profiling	 Business questions, data profile, KPI plan, dashboard wireframe
2	    Cleaning and first analysis	           Cleaned data, 8 SQL analyses, Python EDA, first dashboard
3	    Critical review and deeper analysis	   Advanced SQL (CTEs, window functions), validation, dashboard rebuild
4	    Testing and finalisation	             Statistical validation, corrected insights, final documentation, presentation


Recommendations
Set risk review by transaction type first and test changes against confirmed fraud outcomes.
Create a dedicated review track for international transactions.
Plan by segment size and collect balance fee and product data before judging segment profitability.
Keep risk review at transaction level.
Review ATM's high value flag threshold as a check.
Do not use Digital Engagement Score for targeting.
Prioritize Mobile App for failure analysis on impact grounds.
Clarify how Device_Type and Location are captured and supply a longer data window.

Limitations
Only three months of data, so no seasonality or long run trends.
Risk flags are review triggers not confirmed fraud.
Device_Type and Location are unreliable and not used in conclusions.
No balance fee or product data so profitability cannot be assessed.
How to reproduce
Load the cleaned CSVs into SQL Server as Customers and Transactions, then run the SQL scripts.
Open the Python notebook in Google Colab, upload the cleaned CSVs and run all cells.
Open the Power BI file. If you reload the data, convert Transaction_DateTime using the English (United States) locale, and clear all slicers before reading the KPI cards.

Tools
SQL Server (SSMS), Python (Pandas, NumPy, Matplotlib, SciPy), Google Colab, Excel, Power BI Desktop.

