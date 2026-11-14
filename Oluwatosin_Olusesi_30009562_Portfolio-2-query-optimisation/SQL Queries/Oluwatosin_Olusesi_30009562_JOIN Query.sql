SELECT
    o.Order_ID,
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
    o.Order_Date,
    o.Total_Amount,
    o.Order_Status
FROM orders o
INNER JOIN customers c
    ON o.Customer_ID = c.Customer_ID
ORDER BY o.Order_Date DESC;