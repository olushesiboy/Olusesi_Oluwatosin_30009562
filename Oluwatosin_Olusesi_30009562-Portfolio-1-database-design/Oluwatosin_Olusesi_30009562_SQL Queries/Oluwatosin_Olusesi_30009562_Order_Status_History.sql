INSERT INTO order_status_history
(Status_History_ID, Order_ID, Staff_ID, Previous_Status, New_Status, Changed_At, Remarks)
VALUES
(1, 11, 1, NULL, 'Pending', '2026-11-01 08:00:00', 'Customer order received'),
(2, 11, 1, 'Pending', 'Confirmed', '2026-11-01 08:10:00', 'Payment confirmed'),
(3, 12, 2, NULL, 'Pending', '2026-11-01 09:00:00', 'New customer order received'),
(4, 12, 2, 'Pending', 'Preparing', '2026-11-01 09:20:00', 'Kitchen started meal preparation'),
(5, 13, 1, NULL, 'Pending', '2026-11-02 10:00:00', 'Order received successfully'),
(6, 13, 1, 'Pending', 'Delivered', '2026-11-02 13:15:00', 'Order successfully delivered'),
(7, 14, 3, NULL, 'Pending', '2026-11-02 12:00:00', 'Customer order received'),
(8, 14, 3, 'Pending', 'Preparing', '2026-11-02 12:30:00', 'Food preparation commenced'),
(9, 15, 2, NULL, 'Pending', '2026-11-03 08:00:00', 'New order received'),
(10, 15, 2, 'Pending', 'Confirmed', '2026-11-03 08:15:00', 'Order confirmed by staff');