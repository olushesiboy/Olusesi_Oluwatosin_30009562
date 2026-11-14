START TRANSACTION;

UPDATE orders
SET Order_Status = 'Preparing'
WHERE Order_ID = 11;

SELECT Order_ID, Order_Status
FROM orders
WHERE Order_ID = 11;

COMMIT;
