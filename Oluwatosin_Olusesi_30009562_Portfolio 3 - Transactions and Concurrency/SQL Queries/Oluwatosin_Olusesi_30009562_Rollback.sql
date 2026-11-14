SELECT Order_ID, Order_Status
FROM orders
WHERE Order_ID = 11;
ROLLBACK;SELECT Order_ID, Order_Status
FROM orders
WHERE Order_ID = 11;YES