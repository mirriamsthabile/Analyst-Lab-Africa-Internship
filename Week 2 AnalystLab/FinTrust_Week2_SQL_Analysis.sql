-- 1.How many customers are in each segment
SELECT  Customer_Segment,
COUNT(*) AS Customer_Count
FROM dbo.FinTrust_Customer_Data
GROUP BY Customer_Segment
ORDER BY Customer_Count;

-- 2. How does volume trend by month?
SELECT MONTH(Transaction_DateTime) AS Txn_Month, COUNT(*) AS Txn_Count
FROM dbo.FinTrust_Transaction_Data
GROUP BY MONTH(Transaction_DateTime)
ORDER BY Txn_Month;

-- 3.What's the average value by transaction type?
SELECT Transaction_Type, AVG(Amount_NGN) AS Avg_Value
FROM dbo.FinTrust_Transaction_Data
GROUP BY Transaction_Type
ORDER BY Avg_Value DESC;

-- 4.Which channels are used most?
SELECT Channel, COUNT(*) AS Txn_Count
FROM dbo.FinTrust_Transaction_Data
GROUP BY Channel
ORDER BY Txn_Count DESC;

-- 5.What's the overall status split?
SELECT Transaction_Status, COUNT(*) AS Txn_Count
FROM dbo.FinTrust_Transaction_Data
GROUP BY Transaction_Status
ORDER BY Txn_Count DESC;

-- 6.Which channel has the most failures?
SELECT Channel, COUNT(*) AS Failed_Count
FROM dbo.FinTrust_Transaction_Data
WHERE Transaction_Status = 'Failed'
GROUP BY Channel
ORDER BY Failed_Count DESC;

-- 7.How many transactions were flagged for review?
SELECT Risk_Review_Flag, COUNT(*) AS Txn_Count
FROM dbo.FinTrust_Transaction_Data
GROUP BY Risk_Review_Flag
ORDER BY Txn_Count DESC;

-- 8.Which segment has the highest average engagement score?
SELECT Customer_Segment, AVG(Digital_Engagement_Score) AS Avg_Engagement_Score
FROM dbo.FinTrust_Customer_Data
GROUP BY Customer_Segment
ORDER BY Avg_Engagement_Score DESC;