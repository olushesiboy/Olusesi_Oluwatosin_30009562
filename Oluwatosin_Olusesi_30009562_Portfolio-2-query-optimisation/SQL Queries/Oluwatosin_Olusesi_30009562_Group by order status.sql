SELECT
    Order_Status,
    COUNT(*) AS Total_Orders,
    SUM(Total_Amount) AS Total_Value
FROM orders
GROUP BY Order_Status
ORDER BY Total_Orders DESC;