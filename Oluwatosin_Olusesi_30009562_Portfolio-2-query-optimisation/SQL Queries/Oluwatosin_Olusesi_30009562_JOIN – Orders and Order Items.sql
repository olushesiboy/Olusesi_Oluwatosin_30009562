SELECT
    o.Order_ID,
    o.Order_Date,
    oi.Order_Item_ID,
    oi.Menu_Item_ID,
    oi.Quantity,
    oi.Unit_Price,
    (oi.Quantity * oi.Unit_Price) AS Item_Subtotal
FROM orders o
INNER JOIN order_items oi
    ON o.Order_ID = oi.Order_ID
ORDER BY o.Order_ID ASC;
