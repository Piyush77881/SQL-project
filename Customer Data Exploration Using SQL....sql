Use customer_churn_analysis;
-- Total number of customers
select count(*) CustomerID 
from customer_churn;
-- Average customer age
SELECT 
    ROUND(AVG(Age), 2) AS Average_Age
FROM Customer_churn;
-- Average customer spending
SELECT 
    ROUND(AVG(Total_Spend), 2) AS Average_Spending
FROM Customer_churn;
-- Maximum and minimum customer spending
SELECT
    MAX(Total_Spend) AS Maximum_Spending,
    MIN(Total_Spend) AS Minimum_Spending
FROM Customer_churn;
-- Number of customers per subscription type
SELECT
    Subscription_Type,
    COUNT(DISTINCT CustomerID) AS Number_of_Customers
FROM Customer_churn
GROUP BY Subscription_Type
ORDER BY Number_of_Customers DESC;
-- Average spending per subscription type
SELECT
    Subscription_Type,
    ROUND(AVG(Total_Spend), 2) AS Average_Spending
FROM Customer_churn
GROUP BY Subscription_Type
ORDER BY Average_Spending DESC;
-- Number of churned customers per subscription type
SELECT
    Subscription_Type,
    COUNT(DISTINCT CustomerID) AS Churned_Customers
FROM Customer_churn
WHERE Churn = 1
GROUP BY Subscription_Type
ORDER BY Churned_Customers DESC;
-- Customers with the highest support calls
SELECT
    CustomerID,
     Support_Calls 
FROM Customer_churn
ORDER BY Support_Calls DESC
LIMIT 10;
-- Customers with payment delays
SELECT
    CustomerID,
    Payment_Delay
FROM Customer_churn
ORDER BY Payment_Delay DESC
LIMIT 10;
-- Customers with high total spending
SELECT
    CustomerID,
    Total_Spend
FROM Customer_churn
WHERE Total_Spend > (
    SELECT AVG(Total_Spend)
    FROM Customer_churn
)
ORDER BY Total_Spend DESC;

SELECT
    Subscription_Type,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(Total_Spend), 2) AS Average_Spending
FROM Customer_churn
GROUP BY Subscription_Type;
-- joins
CREATE TABLE Subscription_Info (
    Subscription_Type VARCHAR(50),
    Subscription_Benefit VARCHAR(100)
);
INSERT INTO Subscription_Info
(Subscription_Type, Subscription_Benefit)
VALUES
('Basic', 'Basic Features'),
('Standard', 'Standard Features'),
('Premium', 'Premium Features'),
('Monthly', 'Flexible Monthly Plan'),
('Quarterly', 'Quarterly Plan'),
('Annual', 'Annual Plan');
SELECT *
FROM Subscription_Info;
-- inner join
SELECT
    Customer_churn.CustomerID,
    Customer_churn.Subscription_Type,
    Customer_churn.Total_Spend,
    Subscription_Info.Subscription_Benefit
FROM Customer_churn
INNER JOIN Subscription_Info
    ON Customer_churn.Subscription_Type =
       Subscription_Info.Subscription_Type;
-- Join
CREATE VIEW subscriptionsummary AS
SELECT
    Subscription_Type,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(Total_Spend), 2) AS Average_Spending
FROM Customer_churn
GROUP BY Subscription_Type;
SELECT
    c.CustomerID,
    c.Subscription_Type,
    c.Total_Spend,
    s.Total_Customers,
    s.Average_Spending
FROM Customer_churn c
JOIN subscriptionsummary s
    ON c.Subscription_Type = s.Subscription_Type;
    /* Use CASE statements to categorize customers into segments such as:
High Spending Customers
Medium Spending Customers
Low Spending Customers*/
SELECT
    CustomerID,
    Total_Spend,
    CASE
        WHEN Total_Spend > 600
            THEN 'High Spending Customer'

        WHEN Total_Spend >= 300
            THEN 'Medium Spending Customer'

        ELSE 'Low Spending Customer'
    END AS Spending_Segment
FROM Customer_churn;
-- Subqueries to identify customers above average spending
SELECT
    CustomerID,
    Total_Spend,
    (SELECT AVG(Total_Spend)
     FROM Customer_churn) AS Average_Spending
FROM Customer_churn
WHERE Total_Spend > (
    SELECT AVG(Total_Spend)
    FROM Customer_churn
)
ORDER BY Total_Spend DESC;
-- Window functions to rank customers based on spending
SELECT
    CustomerID,
    Total_Spend,
    RANK() OVER (
        ORDER BY Total_Spend DESC
    ) AS Spending_Rank
FROM Customer_churn;





