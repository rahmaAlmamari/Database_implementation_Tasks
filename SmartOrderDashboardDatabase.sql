--SQL Script – Create & Populate Tables for Smart Order Dashboard
CREATE DATABASE SmartOrderDashboardDatabase;
USE SmartOrderDashboardDatabase;
-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Phone VARCHAR(20),
    ReferralID INT NULL,
    FOREIGN KEY (ReferralID) REFERENCES Customers(CustomerID)
);

-- Restaurants Table
CREATE TABLE Restaurants (
    RestaurantID INT PRIMARY KEY,
    Name NVARCHAR(100),
    City NVARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ItemName NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(6,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Menu Table
CREATE TABLE Menu (
    MenuID INT PRIMARY KEY,
    RestaurantID INT,
    ItemName NVARCHAR(100),
    Price DECIMAL(6,2),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- Insert Sample Data

-- Customers
INSERT INTO Customers VALUES 
(1, 'Ahmed AlHarthy', '91234567', NULL),
(2, 'Fatma AlBalushi', '92345678', 1),
(3, 'Salim AlZadjali', '93456789', NULL),
(4, 'Aisha AlHinai', '94567890', 2);

-- Restaurants
INSERT INTO Restaurants VALUES 
(1, 'Shawarma King', 'Muscat'),
(2, 'Pizza World', 'Sohar'),
(3, 'Burger Spot', 'Nizwa');

-- Menu
INSERT INTO Menu VALUES
(1, 1, 'Shawarma Chicken', 1.500),
(2, 1, 'Shawarma Beef', 1.800),
(3, 2, 'Pepperoni Pizza', 3.000),
(4, 2, 'Cheese Pizza', 2.500),
(5, 3, 'Classic Burger', 2.000),
(6, 3, 'Zinger Burger', 2.200);

-- Orders
INSERT INTO Orders VALUES
(101, 1, 1, '2024-05-01', 'Delivered'),
(102, 2, 2, '2024-05-02', 'Preparing'),
(103, 3, 1, '2024-05-03', 'Cancelled'),
(104, 4, 3, '2024-05-04', 'Delivered');

-- OrderItems
INSERT INTO OrderItems VALUES
(1, 101, 'Shawarma Chicken', 2, 1.500),
(2, 101, 'Shawarma Beef', 1, 1.800),
(3, 102, 'Pepperoni Pizza', 1, 3.000),
(4, 104, 'Classic Burger', 2, 2.000),
(5, 104, 'Zinger Burger', 1, 2.200);

-----------------------------------------------------------------TASK----------------------------------------------
--1. Show all active orders (Status = 'Preparing') with customer name, restaurant name, and order date. 
SELECT * FROM Orders;
SELECT * FROM Customers;
SELECT * FROM Restaurants;

SELECT C.FullName as 'Customer Name', R.Name as 'Restaurant Name', O.OrderDate as 'Order Date'
FROM Customers C INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Restaurants R ON R.RestaurantID = O.RestaurantID
WHERE O.Status = 'Preparing';

--2. List all menu items offered by each restaurant and whether they have ever been 
--ordered. Include items that have never been ordered. 
SELECT * FROM Restaurants;
SELECT * FROM Menu;
SELECT * FROM Orders;
SELECT * FROM OrderItems;

SELECT M.ItemName as 'Item Name', R.Name as 'Restaurant Name', OI.OrderItemID
FROM Restaurants R FULL OUTER JOIN Menu M ON R.RestaurantID = M.RestaurantID
FULL OUTER JOIN Orders O ON R.RestaurantID = O.RestaurantID
FULL OUTER JOIN OrderItems OI ON O.OrderID = OI.OrderID

--3. Display all customers, including those who have never placed any orders. 
SELECT * FROM Customers;
SELECT * FROM Orders;

SELECT C.*, O.OrderID
FROM Customers C FULL OUTER JOIN Orders O ON C.CustomerID = O.CustomerID

--4. Display a full list of customer and order combinations, including customers who never 
--   ordered and orders that belong to non-existent customers. 
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT C.*, O.*
FROM Customers C FULL OUTER JOIN Orders O ON C.CustomerID = O.CustomerID

--5. List each customer along with the full name of the person who referred them, if any. 
SELECT * FROM Customers;

SELECT C.FullName as 'Customer Name', R.FullName as 'Referred Name'
FROM Customers C INNER JOIN Customers R ON R.CustomerID = C.ReferralID;

--6. For each restaurant, show item name, number of times it was ordered, and total 
--   quantity sold. Include items even if they were never ordered. 
SELECT * FROM Restaurants;
SELECT * FROM Orders;
SELECT * FROM OrderItems;

SELECT OI.ItemName, count(OI.OrderItemID) as 'number of times it was ordered', SUM(OI.Quantity) as 'total quantity sold'
FROM Restaurants R INNER JOIN Orders O ON R.RestaurantID = O.RestaurantID
RIGHT OUTER JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY R.Name, OI.ItemName;

--7. Display customers who never placed an order and menu items that were never ordered. 
--   Return a unified list with a type column ('Unused Customer' or 'Unused Item'). 
SELECT * FROM Restaurants;
SELECT * FROM Orders;
SELECT * FROM OrderItems;

SELECT C.FullName as 'Customer Name', 'Unused Customer' as CustomerType
FROM Customers C LEFT OUTER JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

--8. Show all orders where the ordered item does not exist in the current menu of the 
--   restaurant. 
SELECT * FROM Orders;
SELECT * FROM OrderItems;

--9. List customers who have placed more than one order, showing customer name, total 
--   number of orders, first and last order dates. 
SELECT * FROM Orders;
SELECT * FROM Customers;

SELECT C.FullName as 'Customer Name', count(O.OrderID) as 'total number of orders'
FROM Customers C INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FullName, O.OrderID 
HAVING O.OrderID > 1;

--10. For each referral chain, show the customer, the person who referred them, and the 
--    total amount spent by the referred customer. 
SELECT * FROM Customers;
SELECT * FROM OrderItems;
SELECT * FROM Orders;

SELECT C.FullName as 'Customer Name', R.CustomerID as 'Referred Name', SUM(OI.Price) as 'Total Amount Spent'
FROM Customers C INNER JOIN Customers R ON R.CustomerID = C.ReferralID
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY C.FullName, R.CustomerID;

--11. The business team wants to automatically increase prices for high-demand items. 
--    Update the price of any menu item that has been ordered more than 3 times by 10%. 
SELECT * FROM OrderItems;
SELECT * FROM Orders;
SELECT * FROM Menu;


UPDATE M
SET M.Price = M.Price * 1.10
FROM Menu M
JOIN (
    SELECT OI.ItemName, O.RestaurantID, SUM(OI.Quantity) AS TotalOrdered
    FROM OrderItems OI
    JOIN Orders O ON OI.OrderID = O.OrderID
    GROUP BY OI.ItemName, O.RestaurantID
    HAVING SUM(OI.Quantity) > 3
) Agg ON M.ItemName = Agg.ItemName AND M.RestaurantID = Agg.RestaurantID;

--12. To comply with data privacy regulations, the system must remove customers who: 
--    • Have never placed an order, 
--    • And were not referred by another customer. 
--    Use DELETE with a LEFT JOIN to Orders and check ReferralID IS NULL. 

DELETE C
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL
  AND C.ReferralID IS NULL;

--13. The pricing team wants to reduce menu prices by 15% for all items belonging to restaurants that never received any orders. 
--    This is a quick way to encourage more orders from underperforming partners. Your Task: 
--    Update prices in the Menu table using a JOIN with Restaurants and Orders. 
--    Only update menu items for restaurants that do not appear at all in the Orders table. 
--    Hint: Use a LEFT JOIN and check for Orders.OrderID IS NULL in the WHERE clause. 
--    Only UPDATE records in the Menu table — do not use subqueries or functions. 

SELECT * FROM Menu;
SELECT * FROM Orders;
SELECT * FROM Restaurants;

UPDATE M
SET M.Price = M.Price * 0.85
FROM Menu M
JOIN Restaurants R ON M.RestaurantID = R.RestaurantID
LEFT JOIN Orders O ON R.RestaurantID = O.RestaurantID
WHERE O.OrderID IS NULL;

--14. Scenario: 
--    The marketing team asks you to manually insert VIP customers into a new table 
--    VIPCustomers(CustomerID, FullName). 
--    They provide you a shortlist of Customer IDs of people who made several purchases. 
--    Your job is to: 
--    Your Task: 
--    Manually use INSERT statements to add at least two customers to the VIPCustomers table, 
--    but before inserting them, write a SELECT statement using JOINs between Customers, Orders, and 
--    OrderItems 
--    to confirm that those customers appear in both the Orders and OrderItems tables. 
--    Hint: First, use a JOIN to verify which customers placed orders and have items. 
--    Then, manually insert a few of them using INSERT INTO VIPCustomers VALUES (..., ...) 
CREATE TABLE VIPCustomers (
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100)
);

SELECT DISTINCT C.CustomerID, C.FullName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID;

INSERT INTO VIPCustomers VALUES (1, 'Ahmed AlHarthy');
INSERT INTO VIPCustomers VALUES (2, 'Fatma AlBalushi');

--15 . Scenario: 
--     Restaurant owners want to see a live summary of current orders including: 
--     • Customer name 
--     • Restaurant name 
--     • Ordered item names 
--     • Order status 
--     Your Task: 
--     Write a SELECT query that uses multiple JOINs between at least 4 tables: 
--     Customers, Orders, Restaurants, and OrderItems. 
--     Ensure the output shows one row per item in the order, with all related names and the order 
--     status. 
SELECT 
    C.FullName AS CustomerName,
    R.Name AS RestaurantName,
    OI.ItemName AS OrderedItem,
    O.Status AS OrderStatus
FROM OrderItems OI
JOIN Orders O ON OI.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Restaurants R ON O.RestaurantID = R.RestaurantID;





