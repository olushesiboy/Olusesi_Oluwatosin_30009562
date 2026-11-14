SELECT COUNT(*) AS Total_Customers
FROM customers;
SELECT
    First_Name,
    COUNT(*) AS Customer_Count
FROM customers
GROUP BY First_Name
ORDER BY First_Name ASC;