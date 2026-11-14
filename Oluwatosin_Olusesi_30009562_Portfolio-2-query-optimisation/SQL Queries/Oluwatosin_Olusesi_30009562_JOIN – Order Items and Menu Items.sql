SELECT
    oi.Order_ID,
    m.Item_Name,
    oi.Quantity,
    oi.Unit_Price,
    (oi.Quantity * oi.Unit_Price) AS Item_Subtotal
FROM order_items oi
INNER JOIN menu_items m
    ON oi.Menu_Item_ID = m.Menu_Item_ID
ORDER BY oi.Order_ID ASC;