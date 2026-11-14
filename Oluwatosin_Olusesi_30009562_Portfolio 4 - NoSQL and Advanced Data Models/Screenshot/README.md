Portfolio 4 – NoSQL and Advanced Data Models

Project

RoyalTee Chow Logistics

Database Technology

MongoDB Atlas

MongoDB Database: royaltee_chow_nosql

Cluster: RoyalTeeCluster

1. Introduction

This portfolio explores NoSQL database concepts using MongoDB Atlas. The practical exercise demonstrates document-based data storage and illustrates alternative NoSQL data organisation models using a food ordering and delivery management case study.

2. Database Collections

Four collections were created in the royaltee_chow_nosql database:

Collection

Description

orders

Stores customer orders, items, payment and delivery information.

customer_sessions

Demonstrates a key-value-oriented data representation.

order_activity

Demonstrates a column-family-inspired data representation.

order_relationships

Demonstrates a graph-oriented data representation using nodes and relationships.

3. NoSQL Models Explored

Document Database

The orders collection stores order information as MongoDB documents, including embedded customer details, ordered items, payment information and delivery details.

Key-Value Representation

The customer_sessions collection demonstrates session information organised around a unique session identifier.

Column-Family-Inspired Representation

The order_activity collection organises order activity information into related fields, including order status, payment status and delivery status.

Graph-Oriented Representation

The order_relationships collection represents entities as nodes and their connections as relationships, including customers placing orders and orders containing menu items.

Implementation note: The document model was implemented using MongoDB. The key-value, column-family and graph-oriented models are illustrative representations stored in MongoDB; separate native database systems were not deployed for these models.

4. Supporting Evidence

Screenshots are provided in the Screenshots folder to demonstrate:

MongoDB Atlas cluster deployment.

Cluster monitoring.

Database and collection creation.

Order document inspection.

Cloud deployment details.

5. Conclusion

This practical exercise demonstrates the use of MongoDB Atlas for document-based data storage and explores alternative NoSQL data organisation approaches within the RoyalTee Chow Logistics project.
