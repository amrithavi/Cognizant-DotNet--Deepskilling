DROP DATABASE IF EXISTS OnlineRetailStore;
GO

CREATE DATABASE OnlineRetailStore;
GO

USE OnlineRetailStore;
GO

---------------------------------------------------
-- Customers
---------------------------------------------------

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(50)
);

---------------------------------------------------
-- Products
---------------------------------------------------

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

---------------------------------------------------
-- Orders
---------------------------------------------------

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);

---------------------------------------------------
-- Order Details
---------------------------------------------------

CREATE TABLE OrderDetails
(
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
);

---------------------------------------------------
-- Insert Data
---------------------------------------------------

INSERT INTO Customers VALUES
(1,'Ravi','South'),
(2,'Kiran','North'),
(3,'Anil','East'),
(4,'Suresh','West');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',60000),
(102,'Mobile','Electronics',25000),
(103,'Printer','Electronics',10000),
(104,'Table','Furniture',5000),
(105,'Chair','Furniture',3000);

INSERT INTO Orders VALUES
(1,1,'2025-01-05'),
(2,2,'2025-01-10'),
(3,1,'2025-02-15'),
(4,3,'2025-03-20'),
(5,1,'2025-04-01'),
(6,1,'2025-04-15');

INSERT INTO OrderDetails VALUES
(1,1,101,2),
(2,1,104,1),
(3,2,102,3),
(4,3,103,2),
(5,4,105,5),
(6,5,101,1),
(7,6,102,2);

---------------------------------------------------
-- Verify Tables
---------------------------------------------------

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

---------------------------------------------------
-- Exercise 1
-- ROW_NUMBER, RANK, DENSE_RANK
---------------------------------------------------

SELECT
    ProductID,
    ProductName,
    Category,
    Price,

    ROW_NUMBER() OVER
    (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS RowNo,

    RANK() OVER
    (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS RankNo,

    DENSE_RANK() OVER
    (
        PARTITION BY Category
        ORDER BY Price DESC
    ) AS DenseRankNo

FROM Products;

---------------------------------------------------
-- Top 3 Most Expensive Products
---------------------------------------------------

WITH RankedProducts AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
                PARTITION BY Category
                ORDER BY Price DESC
           ) AS RN
    FROM Products
)

SELECT *
FROM RankedProducts
WHERE RN <= 3;

---------------------------------------------------
-- Exercise 2
-- GROUPING SETS
---------------------------------------------------

SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN Customers c
ON o.CustomerID=c.CustomerID
JOIN OrderDetails od
ON o.OrderID=od.OrderID
JOIN Products p
ON od.ProductID=p.ProductID
GROUP BY GROUPING SETS
(
    (c.Region,p.Category),
    (c.Region),
    (p.Category),
    ()
);

---------------------------------------------------
-- ROLLUP
---------------------------------------------------

SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN Customers c
ON o.CustomerID=c.CustomerID
JOIN OrderDetails od
ON o.OrderID=od.OrderID
JOIN Products p
ON od.ProductID=p.ProductID
GROUP BY ROLLUP(c.Region,p.Category);

---------------------------------------------------
-- CUBE
---------------------------------------------------

SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN Customers c
ON o.CustomerID=c.CustomerID
JOIN OrderDetails od
ON o.OrderID=od.OrderID
JOIN Products p
ON od.ProductID=p.ProductID
GROUP BY CUBE(c.Region,p.Category);

---------------------------------------------------
-- Exercise 3(a)
-- Recursive CTE
---------------------------------------------------

WITH Calendar AS
(
    SELECT CAST('2025-01-01' AS DATE) AS DateValue

    UNION ALL

    SELECT DATEADD(DAY,1,DateValue)
    FROM Calendar
    WHERE DateValue<'2025-01-31'
)

SELECT *
FROM Calendar
OPTION(MAXRECURSION 100);

---------------------------------------------------
-- Staging Table
---------------------------------------------------

CREATE TABLE StagingProducts
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO StagingProducts VALUES
(101,'Laptop','Electronics',65000),
(102,'Mobile','Electronics',28000),
(106,'Sofa','Furniture',15000);

---------------------------------------------------
-- Exercise 3(b)
-- MERGE
---------------------------------------------------

MERGE Products AS Target
USING StagingProducts AS Source

ON Target.ProductID=Source.ProductID

WHEN MATCHED THEN
UPDATE SET
    Target.ProductName=Source.ProductName,
    Target.Category=Source.Category,
    Target.Price=Source.Price

WHEN NOT MATCHED THEN
INSERT(ProductID,ProductName,Category,Price)
VALUES
(
    Source.ProductID,
    Source.ProductName,
    Source.Category,
    Source.Price
);

SELECT * FROM Products;

---------------------------------------------------
-- Exercise 4(1)
---------------------------------------------------

SELECT
    p.ProductName,
    MONTH(o.OrderDate) AS MonthNo,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN OrderDetails od
ON o.OrderID=od.OrderID
JOIN Products p
ON od.ProductID=p.ProductID
GROUP BY
    p.ProductName,
    MONTH(o.OrderDate);

---------------------------------------------------
-- Exercise 4(2)
-- PIVOT
---------------------------------------------------

SELECT *
FROM
(
    SELECT
        p.ProductName,
        MONTH(o.OrderDate) AS MonthNo,
        od.Quantity
    FROM Orders o
    JOIN OrderDetails od
        ON o.OrderID=od.OrderID
    JOIN Products p
        ON od.ProductID=p.ProductID
) AS SourceTable

PIVOT
(
    SUM(Quantity)
    FOR MonthNo IN
    ([1],[2],[3],[4])
) AS PivotSales;

---------------------------------------------------
-- Exercise 4(3)
-- UNPIVOT
---------------------------------------------------

WITH PivotData AS
(
    SELECT *
    FROM
    (
        SELECT
            p.ProductName,
            MONTH(o.OrderDate) AS MonthNo,
            od.Quantity
        FROM Orders o
        JOIN OrderDetails od
            ON o.OrderID=od.OrderID
        JOIN Products p
            ON od.ProductID=p.ProductID
    ) s

    PIVOT
    (
        SUM(Quantity)
        FOR MonthNo IN
        ([1],[2],[3],[4])
    ) p
)

SELECT
    ProductName,
    MonthNo,
    Quantity
FROM PivotData

UNPIVOT
(
    Quantity FOR MonthNo IN
    ([1],[2],[3],[4])
) u;

---------------------------------------------------
-- Exercise 5
---------------------------------------------------

WITH CustomerOrderCounts AS
(
  SELECT
      CustomerID,
      COUNT(OrderID) AS OrderCount
      FROM Orders
  GROUP BY CustomerID
)

SELECT
    c.CustomerID,
    c.Name,
    coc.OrderCount
FROM CustomerOrderCounts coc
JOIN Customers c
ON coc.CustomerID=c.CustomerID
WHERE coc.OrderCount>3;