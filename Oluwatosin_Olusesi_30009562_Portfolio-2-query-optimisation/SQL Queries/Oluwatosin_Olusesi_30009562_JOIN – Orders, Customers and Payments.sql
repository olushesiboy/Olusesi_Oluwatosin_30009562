SELECT
    o.Order_ID,
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
    o.Total_Amount,
    p.payment_method,
    p.amount_paid,
    p.payment_status
FROM orders o
INNER JOIN customers c
    ON o.Customer_ID = c.Customer_ID
INNER JOIN payments p
    ON o.Order_ID = p.order_ID
ORDER BY o.Order_ID ASC;