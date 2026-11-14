USE royaltee_chow_logistics;
DESCRIBE `orders`;
SELECT
    SUM(Total_Amount) AS Total_Order_Value
FROM orders;
SELECT
    AVG(Total_Amount) AS Average_Order_Value
FROM orders;
SELECT
    MAX(Total_Amount) AS Highest_Order,
    MIN(Total_Amount) AS Lowest_Order
FROM orders;T