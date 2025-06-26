-- Create Database
CREATE DATABASE IF NOT EXISTS EcommerceDB;
USE EcommerceDB;

-- Table: Categories
CREATE TABLE Categories (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(100) NOT NULL
);

-- Table: Products
CREATE TABLE Products (
  ProductID INT AUTO_INCREMENT PRIMARY KEY,
  ProductName VARCHAR(100),
  Price DECIMAL(10, 2),
  Stock INT,
  CategoryID INT,
  FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Table: Customers
CREATE TABLE Customers (
  CustomerID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(20),
  Address VARCHAR(255)
);

-- Table: Orders
CREATE TABLE Orders (
  OrderID INT AUTO_INCREMENT PRIMARY KEY,
  CustomerID INT,
  OrderDate DATE,
  Status VARCHAR(50),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table: OrderItems
CREATE TABLE OrderItems (
  OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
  OrderID INT,
  ProductID INT,
  Quantity INT,
  Price DECIMAL(10,2),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table: Payments
CREATE TABLE Payments (
  PaymentID INT AUTO_INCREMENT PRIMARY KEY,
  OrderID INT,
  PaymentDate DATE,
  Amount DECIMAL(10,2),
  PaymentMethod VARCHAR(50),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--  INSERT Categories
INSERT INTO Categories (CategoryName) VALUES
('Home Appliances'),
('Books'),
('Beauty Products'),
('Electronics');

--  INSERT Products
INSERT INTO Products (ProductName, Price, Stock, CategoryID) VALUES
('Air Conditioner', 32999.00, 30, 1),
('Microwave Oven', 8999.00, 20, 1),
('Fiction Book', 299.00, 100, 2),
('Face Cream', NULL, 250, 3),         -- Price unknown
('Wireless Mouse', 1199.00, NULL, 4); -- Stock unknown

--  INSERT Customers
INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('Pratik Joshi', 'pratik@example.com', '9876541230', 'Nagpur'),
('Kajal Mehta', NULL, '9001245678', 'Ahmedabad'),        -- Email unknown
('Vikram Singh', 'vikram@sample.com', NULL, 'Lucknow');  -- Phone unknown

--  INSERT Orders
INSERT INTO Orders (CustomerID, OrderDate, Status) VALUES
(1, '2025-05-12', 'Delivered'),
(2, '2025-05-15', 'Processing'),
(3, '2025-05-20', 'Pending');

--  INSERT OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 32999.00),
(1, 4, 2, NULL),
(2, 2, 1, 8999.00),
(3, 3, 5, 299.00);

--  INSERT Payments
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2025-05-12', 32999.00, 'Credit Card'),
(2, '2025-05-16', 8999.00, 'Debit Card'),
(3, '2025-05-21', 1495.00, 'Cash');

-- Select all columns from the Customers table
SELECT * FROM Customers;

-- Select specific columns from Products
SELECT ProductName, Price, Stock FROM Products;

-- Use WHERE to filter products in the 'Electronics' category
SELECT ProductName, Price
FROM Products
WHERE CategoryID = 1;

-- Use WHERE with AND condition (price > 1000 and stock > 20)
SELECT ProductName, Price, Stock
FROM Products
WHERE Price > 1000 AND Stock > 20;

-- Use WHERE with OR condition (price is NULL OR stock is NULL)
SELECT ProductName, Price, Stock
FROM Products
WHERE Price IS NULL OR Stock IS NULL;

-- Use LIKE to find customers with name starting with 'S'
SELECT * FROM Customers
WHERE Name LIKE 'S%';

-- Use BETWEEN to find products with price between 1000 and 30000
SELECT ProductName, Price
FROM Products
WHERE Price BETWEEN 1000 AND 30000;

-- Sort customers by name (ascending)
SELECT * FROM Customers
ORDER BY Name ASC;

-- Sort products by price (descending)
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC;

--  Limit the number of results (first 2 customers)
SELECT * FROM Customers
LIMIT 2;

-- Select orders placed by CustomerID = 1
SELECT * FROM Orders
WHERE CustomerID = 1;

-- Get order items for OrderID = 1
SELECT * FROM OrderItems
WHERE OrderID = 1;

-- Find all payments made using UPI
SELECT * FROM Payments
WHERE PaymentMethod = 'UPI';

-- Find all orders with status 'Pending' or 'Shipped'
SELECT * FROM Orders
WHERE Status = 'Pending' OR Status = 'Shipped';

-- Show product name and stock where stock is less than 100
SELECT ProductName, Stock
FROM Products
WHERE Stock < 100;
