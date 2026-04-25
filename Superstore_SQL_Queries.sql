/* =========================================
   PROJECT: Superstore Sales & Profit Analysis
   TOOLS: SQL Server
========================================= */

------------------------------------------------
-- 1. Create Database
------------------------------------------------

CREATE DATABASE SuperstoreDB;
GO

USE SuperstoreDB;
GO


------------------------------------------------
-- 2. Create Superstore Table
------------------------------------------------

CREATE TABLE Superstore (
    Ship_Mode VARCHAR(50),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
);
GO


------------------------------------------------
-- 3. Import CSV Data
------------------------------------------------

BULK INSERT Superstore
FROM 'C:\Users\Murali Mohan Darla\Desktop\Temp\SampleSuperstore.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);
GO


------------------------------------------------
-- 4. Verify Data Loaded
------------------------------------------------

SELECT COUNT(*) AS TotalRows
FROM Superstore;

SELECT TOP 10 *
FROM Superstore;



/* =========================================
   ANALYSIS QUERIES
========================================= */

------------------------------------------------
-- 5. Overall Business KPIs
------------------------------------------------

SELECT
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(*) AS Total_Orders
FROM Superstore;



------------------------------------------------
-- 6. Sales by Category
------------------------------------------------

SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;



------------------------------------------------
-- 7. Profit by Region
------------------------------------------------

SELECT
    Region,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM Superstore
GROUP BY Region
ORDER BY Total_Profit DESC;



------------------------------------------------
-- 8. Sales by Sub-Category
------------------------------------------------

SELECT
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM Superstore
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;



------------------------------------------------
-- 9. Top 10 Sub-Categories by Sales
------------------------------------------------

SELECT TOP 10
    Sub_Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM Superstore
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;



------------------------------------------------
-- 10. Quantity by Region
------------------------------------------------

SELECT
    Region,
    SUM(Quantity) AS Total_Quantity
FROM Superstore
GROUP BY Region
ORDER BY Total_Quantity DESC;



------------------------------------------------
-- 11. Most Profitable Categories
------------------------------------------------

SELECT
    Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM Superstore
GROUP BY Category
ORDER BY Total_Profit DESC;



------------------------------------------------
-- 12. Loss-Making Sub-Categories
------------------------------------------------

SELECT
    Sub_Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM Superstore
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;



------------------------------------------------
-- 13. Average Profit Margin by Category
------------------------------------------------

SELECT
    Category,
    ROUND(AVG(Profit),2) AS Avg_Profit
FROM Superstore
GROUP BY Category
ORDER BY Avg_Profit DESC;



------------------------------------------------
-- 14. Sales by Segment
------------------------------------------------

SELECT
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM Superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;



------------------------------------------------
-- 15. State-Level Sales Performance
------------------------------------------------

SELECT TOP 10
    State,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM Superstore
GROUP BY State
ORDER BY Total_Sales DESC;



------------------------------------------------
-- 16. Highest Profit Regions
------------------------------------------------

SELECT TOP 4
    Region,
    SUM(Profit) AS Profit
FROM Superstore
GROUP BY Region
ORDER BY Profit DESC;



/* =========================================
   END OF PROJECT QUERIES
========================================= */