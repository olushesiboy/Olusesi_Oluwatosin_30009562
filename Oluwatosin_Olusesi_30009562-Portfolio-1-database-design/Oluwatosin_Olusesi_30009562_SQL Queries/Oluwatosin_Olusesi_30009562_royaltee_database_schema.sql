-- =========================================================
-- MIT 8103: ADVANCED DATABASE SYSTEMS
-- PROJECT: ROYALTEE CHOW LOGISTICS
-- PORTFOLIO 1: DATABASE DESIGN AND IMPLEMENTATION
-- DBMS: MySQL 8.0+
-- =========================================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS RoyalTee_Chow_Logistics;

USE RoyalTee_Chow_Logistics;


-- =========================================================
-- 2. CUSTOMERS
-- =========================================================

CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Date_Registered DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- =========================================================
-- 3. CUSTOMER ADDRESSES
-- =========================================================

CREATE TABLE Customer_Addresses (
    Address_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Address_Line VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL,
    Landmark VARCHAR(150),
    Is_Default BOOLEAN DEFAULT FALSE,

    UNIQUE (Address_ID, Customer_ID),

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 4. FOOD CATEGORIES
-- =========================================================

CREATE TABLE Food_Categories (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    Date_Created DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- =========================================================
-- 5. MENU ITEMS
-- =========================================================

CREATE TABLE Menu_Items (
    Menu_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_ID INT NOT NULL,
    Item_Name VARCHAR(150) NOT NULL,
    Description TEXT,
    Price DECIMAL(12,2) NOT NULL,
    Availability_Status VARCHAR(30) DEFAULT 'Available',
    Date_Added DATETIME DEFAULT CURRENT_TIMESTAMP,

    CHECK (Price >= 0),
    CHECK (Availability_Status IN ('Available', 'Unavailable')),

    FOREIGN KEY (Category_ID)
        REFERENCES Food_Categories(Category_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 6. ORDERS
-- =========================================================

CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Address_ID INT NOT NULL,
    Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total_Amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    Order_Status VARCHAR(30) DEFAULT 'Pending',
    Special_Instructions TEXT,

    CHECK (Total_Amount >= 0),
    CHECK (Order_Status IN (
        'Pending',
        'Confirmed',
        'Preparing',
        'Ready',
        'Dispatched',
        'Delivered',
        'Cancelled'
    )),

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (Address_ID, Customer_ID)
        REFERENCES Customer_Addresses(Address_ID, Customer_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 7. ORDER ITEMS
-- =========================================================

CREATE TABLE Order_Items (
    Order_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Menu_Item_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(12,2) NOT NULL,

    CHECK (Quantity > 0),
    CHECK (Unit_Price >= 0),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Menu_Item_ID)
        REFERENCES Menu_Items(Menu_Item_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 8. PAYMENTS
-- =========================================================

CREATE TABLE Payments (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Payment_Reference VARCHAR(100) NOT NULL UNIQUE,
    Payment_Method VARCHAR(50) NOT NULL,
    Amount_Paid DECIMAL(12,2) NOT NULL,
    Payment_Status VARCHAR(30) DEFAULT 'Pending',
    Payment_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    CHECK (Amount_Paid >= 0),
    CHECK (Payment_Status IN (
        'Pending',
        'Successful',
        'Failed',
        'Refunded'
    )),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 9. DELIVERY RIDERS
-- =========================================================

CREATE TABLE Delivery_Riders (
    Rider_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL UNIQUE,
    Vehicle_Type VARCHAR(50),
    Registration_Number VARCHAR(50),
    Availability_Status VARCHAR(30) DEFAULT 'Available',

    CHECK (Availability_Status IN (
        'Available',
        'Unavailable',
        'On Delivery'
    ))
) ENGINE=InnoDB;


-- =========================================================
-- 10. STAFF
-- =========================================================

CREATE TABLE Staff (
    Staff_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Role VARCHAR(100) NOT NULL,
    Employment_Status VARCHAR(30) DEFAULT 'Active',
    Date_Employed DATE,

    CHECK (Employment_Status IN ('Active', 'Inactive'))
) ENGINE=InnoDB;


-- =========================================================
-- 11. DELIVERIES
-- =========================================================

CREATE TABLE Deliveries (
    Delivery_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Rider_ID INT NULL,
    Dispatch_Date DATETIME,
    Delivery_Date DATETIME,
    Delivery_Status VARCHAR(30) DEFAULT 'Pending',
    Delivery_Fee DECIMAL(12,2) DEFAULT 0.00,

    CHECK (Delivery_Fee >= 0),
    CHECK (Delivery_Status IN (
        'Pending',
        'Assigned',
        'In Transit',
        'Delivered',
        'Failed'
    )),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (Rider_ID)
        REFERENCES Delivery_Riders(Rider_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 12. ORDER STATUS HISTORY
-- =========================================================

CREATE TABLE Order_Status_History (
    Status_History_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Staff_ID INT NULL,
    Previous_Status VARCHAR(30),
    New_Status VARCHAR(30) NOT NULL,
    Changed_At DATETIME DEFAULT CURRENT_TIMESTAMP,
    Remarks TEXT,

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Staff_ID)
        REFERENCES Staff(Staff_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 13. DELIVERY ASSIGNMENT HISTORY
-- =========================================================

CREATE TABLE Delivery_Assignment_History (
    Assignment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Delivery_ID INT NOT NULL,
    Rider_ID INT NOT NULL,
    Staff_ID INT NULL,
    Assigned_At DATETIME DEFAULT CURRENT_TIMESTAMP,
    Unassigned_At DATETIME NULL,
    Assignment_Status VARCHAR(30) DEFAULT 'Active',
    Remarks TEXT,

    CHECK (Assignment_Status IN (
        'Active',
        'Completed',
        'Reassigned',
        'Cancelled'
    )),

    FOREIGN KEY (Delivery_ID)
        REFERENCES Deliveries(Delivery_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Rider_ID)
        REFERENCES Delivery_Riders(Rider_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (Staff_ID)
        REFERENCES Staff(Staff_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 14. INGREDIENTS
-- =========================================================

CREATE TABLE Ingredients (
    Ingredient_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ingredient_Name VARCHAR(150) NOT NULL UNIQUE,
    Unit_Of_Measure VARCHAR(30) NOT NULL,
    Quantity_On_Hand DECIMAL(12,3) DEFAULT 0.000,
    Reorder_Level DECIMAL(12,3) DEFAULT 0.000,
    Date_Added DATETIME DEFAULT CURRENT_TIMESTAMP,

    CHECK (Quantity_On_Hand >= 0),
    CHECK (Reorder_Level >= 0)
) ENGINE=InnoDB;


-- =========================================================
-- 15. MENU ITEM INGREDIENTS
-- =========================================================

CREATE TABLE Menu_Item_Ingredients (
    Menu_Item_ID INT NOT NULL,
    Ingredient_ID INT NOT NULL,
    Quantity_Required DECIMAL(12,3) NOT NULL,

    PRIMARY KEY (Menu_Item_ID, Ingredient_ID),

    CHECK (Quantity_Required > 0),

    FOREIGN KEY (Menu_Item_ID)
        REFERENCES Menu_Items(Menu_Item_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Ingredient_ID)
        REFERENCES Ingredients(Ingredient_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 16. INVENTORY TRANSACTIONS
-- =========================================================

CREATE TABLE Inventory_Transactions (
    Transaction_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ingredient_ID INT NOT NULL,
    Staff_ID INT NULL,
    Transaction_Type VARCHAR(30) NOT NULL,
    Quantity DECIMAL(12,3) NOT NULL,
    Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Reference VARCHAR(100),
    Remarks TEXT,

    CHECK (Quantity > 0),
    CHECK (Transaction_Type IN (
        'Stock In',
        'Usage',
        'Adjustment',
        'Wastage'
    )),

    FOREIGN KEY (Ingredient_ID)
        REFERENCES Ingredients(Ingredient_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (Staff_ID)
        REFERENCES Staff(Staff_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 17. VERIFY DATABASE AND TABLES
-- =========================================================

SELECT DATABASE() AS Selected_Database;

SHOW TABLES;