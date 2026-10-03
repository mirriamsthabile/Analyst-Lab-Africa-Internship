--1. Who are FinTrust's most active customers?
SELECT 
    c.Customer_ID,
    c.Customer_Segment,
    COUNT(*) AS Txn_Count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS Activity_Rank
FROM dbo.FinTrust_Transaction_Data t
JOIN dbo.FinTrust_Customer_Data c
    ON t.Customer_ID = c.Customer_ID
GROUP BY 
    c.Customer_ID,
    c.Customer_Segment
ORDER BY 
    Txn_Count DESC;

--2. Where does risk concentrate when you look at Channel and Transaction_Type together? 
SELECT 
    Channel,
    Transaction_Type,
    SUM(CASE WHEN Risk_Review_Flag = 1 THEN 1 ELSE 0 END) AS Flagged,
    COUNT(*) AS Total,
    ROUND(
        100.0 * SUM(CASE WHEN Risk_Review_Flag = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS Risk_Rate_Pct
FROM dbo.FinTrust_Transaction_Data
GROUP BY 
    Channel,
    Transaction_Type
ORDER BY 
    Risk_Rate_Pct DESC;



-- 3. What do high value transactions look like and are they riskier? 
WITH HighValueThreshold AS (
    SELECT DISTINCT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Amount_NGN) OVER () AS P90
    FROM dbo.FinTrust_Transaction_Data
),
HighValue AS (
    SELECT t.*
    FROM dbo.FinTrust_Transaction_Data t, HighValueThreshold h
    WHERE t.Amount_NGN > h.P90
)
SELECT Channel,
       COUNT(*) AS HighValue_Count,
       ROUND(100.0 * SUM(CASE WHEN Risk_Review_Flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Risk_Rate_Pct,
       ROUND(100.0 * SUM(CASE WHEN Transaction_Status = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Failure_Rate_Pct
FROM HighValue
GROUP BY Channel
ORDER BY HighValue_Count DESC;

-- 4. How is transaction value trending month over month, and what's the cumulative total? 
WITH Monthly AS (
    SELECT 
        DATEFROMPARTS(
            YEAR(Transaction_DateTime),
            MONTH(Transaction_DateTime),
            1
        ) AS Txn_Month,
        SUM(Amount_NGN) AS Monthly_Value
    FROM dbo.FinTrust_Transaction_Data
    GROUP BY 
        YEAR(Transaction_DateTime),
        MONTH(Transaction_DateTime)
)
SELECT 
    FORMAT(Txn_Month, 'yyyy-MM') AS Txn_Month,
    Monthly_Value,

    SUM(Monthly_Value) OVER (
        ORDER BY Txn_Month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Cumulative_Value,

    LAG(Monthly_Value) OVER (
        ORDER BY Txn_Month
    ) AS Prev_Month_Value,

    ROUND(
        100.0 * (
            Monthly_Value - LAG(Monthly_Value) OVER (ORDER BY Txn_Month)
        )
        / NULLIF(
            LAG(Monthly_Value) OVER (ORDER BY Txn_Month),
            0
        ),
        2
    ) AS MoM_Pct_Change

FROM Monthly
ORDER BY Txn_Month;



-- 5. Which transaction types fail most often, broken out by every status?
SELECT Transaction_Type,
       SUM(CASE WHEN Transaction_Status = 'Successful' THEN 1 ELSE 0 END) AS Successful,
       SUM(CASE WHEN Transaction_Status = 'Failed' THEN 1 ELSE 0 END) AS Failed,
       SUM(CASE WHEN Transaction_Status = 'Reversed' THEN 1 ELSE 0 END) AS Reversed,
       SUM(CASE WHEN Transaction_Status = 'Pending' THEN 1 ELSE 0 END) AS Pending,
       COUNT(*) AS Total,
       ROUND(100.0 * SUM(CASE WHEN Transaction_Status = 'Failed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Failure_Rate_Pct
FROM dbo.FinTrust_Transaction_Data
GROUP BY Transaction_Type
ORDER BY Failure_Rate_Pct DESC;


-- 6. International vs. domestic — does the real difference show up in value or somewhere else? 
SELECT International_Transaction,
       COUNT(*) AS Txn_Count,
       ROUND(AVG(Amount_NGN), 2) AS Avg_Value,
       ROUND(100.0 * SUM(CASE WHEN Risk_Review_Flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Risk_Rate_Pct,
       ROUND(100.0 * SUM(CASE WHEN Transaction_Status = 'Failed' THEN 1 ELSE 0 END) / COUNT(*), 2) AS Failure_Rate_Pct
FROM dbo.FinTrust_Transaction_Data
GROUP BY International_Transaction;

-- 7. Which segment is really the most valuable  in total or per customer 
WITH SegTotals AS (
    SELECT c.Customer_Segment,
           COUNT(DISTINCT c.Customer_ID) AS Customer_Count,
           SUM(t.Amount_NGN) AS Total_Value,
           COUNT(t.Transaction_ID) AS Txn_Count
    FROM dbo.FinTrust_Customer_Data c
    JOIN dbo.FinTrust_Transaction_Data t ON c.Customer_ID = t.Customer_ID
    GROUP BY c.Customer_Segment
)
SELECT Customer_Segment, Customer_Count, Total_Value,
       ROUND(Total_Value / Customer_Count, 2) AS Value_Per_Customer,
       RANK() OVER (ORDER BY Total_Value DESC) AS Rank_By_Total,
       RANK() OVER (ORDER BY Total_Value / Customer_Count DESC) AS Rank_By_Per_Customer
FROM SegTotals
ORDER BY Total_Value DESC;


-- 8.  Which customers are repeatedly flagged for risk review? 
SELECT c.Customer_ID, c.Customer_Segment, COUNT(*) AS Flagged_Txn_Count,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS Risk_Rank
FROM dbo.FinTrust_Transaction_Data t
JOIN dbo.FinTrust_Customer_Data c ON t.Customer_ID = c.Customer_ID
WHERE t.Risk_Review_Flag = 1
GROUP BY c.Customer_ID, c.Customer_Segment
HAVING COUNT(*) >= 3
ORDER BY Flagged_Txn_Count DESC;