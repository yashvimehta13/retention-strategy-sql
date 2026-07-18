-- ============================================================
-- DECODING CUSTOMER VALUE: A SQL-DRIVEN RETENTION STRATEGY
-- Customer Segmentation Queries
-- Database: customer_value | Table: customer_value_clean
-- ============================================================

USE customer_value;

-- ============================================================
-- QUERY 1: Loyal vs Discount-Dependent Customers
-- Key Question: Who are the genuinely loyal customers vs
-- those who only buy when there is a discount?
-- ============================================================

SELECT 
    CASE 
        WHEN Loyalty_Def1 = 1 THEN 'Genuinely Loyal'
        WHEN Promo_Dependency_Score = 1.0 THEN 'Discount Hunter'
        ELSE 'Neutral Buyer'
    END AS Customer_Segment,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend,
    ROUND(AVG(Previous_Purchases), 2) AS Avg_Purchase_History,
    ROUND(AVG(Review_Rating), 2) AS Avg_Rating,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_value_clean), 2) AS Pct_of_Total
FROM customer_value_clean
GROUP BY Customer_Segment
ORDER BY Avg_Spend DESC;

-- ============================================================
-- QUERY 2: Behavioral Patterns That Predict High Customer Value
-- Key Question: What behavioral patterns today predict
-- high customer value over time?
-- ============================================================

SELECT 
    Value_Tier,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Previous_Purchases), 2) AS Avg_Purchase_History,
    ROUND(AVG(Frequency_Score), 2) AS Avg_Frequency_Score,
    ROUND(AVG(Promo_Dependency_Score), 2) AS Avg_Promo_Dependency,
    ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend,
    ROUND(AVG(Review_Rating), 2) AS Avg_Rating,
    ROUND(SUM(Purchase_Amount_USD), 2) AS Total_Revenue,
    ROUND(SUM(Purchase_Amount_USD) * 100.0 / 
        (SELECT SUM(Purchase_Amount_USD) FROM customer_value_clean), 2) AS Revenue_Share_Pct
FROM customer_value_clean
GROUP BY Value_Tier
ORDER BY FIELD(Value_Tier, 'Premium', 'High', 'Medium', 'Low');

-- ============================================================
-- QUERY 3: Geographic Opportunity — Organic vs Discount Markets
-- Key Question: Which geographies and demographics are
-- commercially underlevered?
-- ============================================================

SELECT 
    Location,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend,
    ROUND(AVG(Promo_Dependency_Score), 2) AS Avg_Promo_Dependency,
    ROUND(AVG(Loyalty_Def1), 3) AS Loyalty_Rate,
    ROUND(SUM(Purchase_Amount_USD), 2) AS Total_Revenue,
    CASE 
        WHEN AVG(Purchase_Amount_USD) >= 60 
             AND AVG(Promo_Dependency_Score) <= 0.40 
        THEN 'Organic Opportunity'
        WHEN AVG(Promo_Dependency_Score) >= 0.45 
        THEN 'Discount Dependent'
        ELSE 'Neutral Market'
    END AS Market_Type
FROM customer_value_clean
GROUP BY Location
ORDER BY Avg_Promo_Dependency ASC, Avg_Spend DESC
LIMIT 20;

-- ============================================================
-- QUERY 4: Category & Season vs Customer Tenure
-- Key Question: Which seasons and categories are associated
-- with lower tenure customers vs high previous purchase counts?
-- ============================================================

SELECT 
    Category,
    Season,
    ROUND(AVG(Previous_Purchases), 2) AS Avg_Purchase_History,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend,
    ROUND(AVG(Promo_Dependency_Score), 2) AS Promo_Dependency,
    ROUND(AVG(Loyalty_Def1), 3) AS Loyalty_Rate
FROM customer_value_clean
GROUP BY Category, Season
ORDER BY Avg_Purchase_History DESC;

-- ============================================================
-- QUERY 5: Ideal Customer Profile
-- Key Question: What does the brand's ideal customer look like
-- in terms of age, purchase habits, payment preferences,
-- and satisfaction?
-- ============================================================

WITH loyal_customers AS (
    SELECT *
    FROM customer_value_clean
    WHERE Loyalty_Def1 = 1
),
ideal_profile AS (
    SELECT
        Age_Group,
        Gender,
        Category,
        Payment_Method,
        Season,
        COUNT(*) AS Count,
        ROUND(AVG(Age), 1) AS Avg_Age,
        ROUND(AVG(Purchase_Amount_USD), 2) AS Avg_Spend,
        ROUND(AVG(Previous_Purchases), 2) AS Avg_Purchase_History,
        ROUND(AVG(Review_Rating), 2) AS Avg_Rating
    FROM loyal_customers
    GROUP BY Age_Group, Gender, Category, Payment_Method, Season
)
SELECT *
FROM ideal_profile
ORDER BY Count DESC
LIMIT 15;
