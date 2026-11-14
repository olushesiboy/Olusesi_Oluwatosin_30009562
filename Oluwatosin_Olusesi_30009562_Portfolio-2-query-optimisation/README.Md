The query optimisation exercise was performed using MySQL's EXPLAIN statement to examine how queries were executed.

Initially, a query filtering orders by Order_Status used a full table scan, examining all 10 records. After identifying that no suitable index was available in the initial execution plan, an index named idx_orders_status was applied to the Order_Status column.

The subsequent execution plan showed that MySQL used an index lookup instead of a full table scan. The estimated execution cost decreased from 1.25 to 0.9, while the estimated matching rows were four.

This exercise demonstrates how indexing can improve data retrieval by helping MySQL locate matching records more efficiently. However, since the database contains a relatively small number of records, actual performance improvements may be more significant as the database grows.
