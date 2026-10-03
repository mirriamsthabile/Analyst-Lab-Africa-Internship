<img width="1209" height="675" alt="FinTrust Dashboard" src="https://github.com/user-attachments/assets/3925a0aa-c088-44cd-9bdb-25dddf2259b6" />
FinTrust Digital Bank Experience Lab Project — Week 3



Project overview

Week 3 moved from building out the analysis to stress testing it. Rather than adding new surface level work this week revisited Week 2's findings and deepened the SQL and Python analysis with more advanced techniques, validated the dashboard's numbers and business conclusions against independent recalculation and translated validated findings into management recommendations.


Week 3 summary
Part A — Critical review of Week 2

Reviewed Week 2's data quality findings, SQL analysis, Python analysis, KPIs, dashboard and business findings against the actual built dashboard. Identified several real gap. Week 2's risk review analysis stopped at customer segment without testing channel or transaction type and that the dashboard's trend chart was showing a misleading full year axis despite only three months of data existing.

Part B — Advanced SQL analysis

Extended Week 2's SQL work with 8 additional queries using JOINs, CTEs, CASE statements, subqueries, and window functions RANK, DENSE_RANK, LAG, running SUM() OVER. Key new findings:

Risk flag rate by Channel + Transaction_Type (not segment) revealed Transfer transactions sit at 27–31% risk-flagged across every channel — nearly double the rate for Deposits and Airtime/Data
Everyday leads total transaction value due to segment size, but SME customers generate the highest value per customer ₦387 923 vs. Everyday's ₦367 734
317 customers (21% of the base) have 3+ risk-flagged transactions each suggesting risk should be monitored at the customer level not just the transaction level

Part C — Advanced Python analysis

Built 14 additional analyses in Python covering digital engagement correlation, risk vs amount comparison, channel/type risk and failure patterns, monthly trends, segment-level behaviour and direct validation of two Week 2 findings. The headline results were:

Metric	Result
Digital Engagement Score vs. Transaction Count correlation	0.038 (negligible)
Digital Engagement Score vs. Total Transaction Value correlation	0.024 (negligible)
Mean amount: risk-flagged transactions	₦68,785.56 (vs. ₦41,323.98 for non-flagged)
Risk review rate by Channel (alone)	Web 21.35%, ATM 21.18%, Mobile App 19.40%, POS 18.35%, USSD 17.32% — flat
Risk review rate by Transaction_Type (alone)	Transfer 28.49%, Cash Withdrawal 25.31%, Deposit 16.19%, Airtime/Data 15.19%, Card Purchase 13.02%, Bill Payment 12.81% — not flat
Monthly transaction value	Jan ₦188.49M, Feb ₦175.79M, Mar ₦196.20M

Important finding: channel alone shows almost no risk variation 17–21% but transaction type alone shows a 15 point spread (12.81%–28.49%) which confirmed that transaction type not channel is the stronger driver of risk and that combining both sharpens the pattern further. Digital engagement was also confirmed to have essentially no relationship with transaction activity or value, directly contradicting an assumption that seemed plausible in Week 1–2.

Part D — Output validation

Independently recalculated key dashboard KPIs directly from the cleaned data rather than trusting the first set of numbers. This caught one real error the previously reported Total Transaction Value ₦560M was off by ₦15 199.34 due to a manual transcription error when summing segment subtotals corrected to ₦560 477 354.85. All other KPIs referential integrity, date parsing and the outlier flag logic passed validation without changes needed.

Part E — Validation of business findings

Re examined 5 major Week 2 findings against deeper evidence. 4 of 5 required revision  not because the original numbers were wrong, but because the first variable tested segment, total value, raw failure count wasn't the most complete lens available. For example Everyday is the most valuable segment" is true by total value but false by value per customer SME wins there risk doesn't vary by segment is true but incomplete without checking channel and type where it varies.

Part F — Management recommendations

Translated validated findings into 6 recommendations using Finding → Evidence → Business Implication → Recommended Action, covering risk monitoring calibration for Transfers, reclassifying international transaction risk as a compliance issue rather than a value issue, shifting segment strategy toward per customer value SME, building customer level not just transaction level risk monitoring, recalibrating ATM's high value risk threshold and prioritizing Mobile App for reliability investment given its scale.

Dashboard rebuild

Diagnosed and fixed a date-parsing/locale issue that was causing Power BI to display 12 months of data despite the dataset only covering January–March 2026 (root cause: default locale misread M/D/YYYY as D/M/YYYY). Rebuilt the trend chart with correct month grouping and a zero-based Y-axis, replaced the uninformative "Risk Review Rate by Customer Segment" chart with a Channel × Transaction_Type risk heatmap (matrix with conditional formatting), added a Value-Per-Customer-by-Segment chart to surface the SME finding, applied a consistent color palette across repeated categories, and added Month→Day drill-down on the trend chart.

Tools used
SQL Server / SSMS — advanced query techniques (CTEs, window functions)
Python (Pandas, Matplotlib) — correlation analysis, validation, advanced visualizations
Power BI Desktop — dashboard rebuild and fixes
