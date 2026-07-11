DROP DATABASE IF EXISTS EmployeeFunctionsExercise;
GO

CREATE DATABASE EmployeeFunctionsExercise;
GO

USE EmployeeFunctionsExercise;
GO

----------------------------------------------------
-- Departments Table
----------------------------------------------------

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

----------------------------------------------------
-- Employees Table
----------------------------------------------------

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

----------------------------------------------------
-- Sample Data
----------------------------------------------------

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1,'John','Doe',1,5000.00,'2020-01-15'),
(2,'Jane','Smith',2,6000.00,'2019-03-22'),
(3,'Bob','Johnson',3,5500.00,'2021-07-01');

----------------------------------------------------
-- Verify Tables
----------------------------------------------------

SELECT * FROM Departments;
SELECT * FROM Employees;

----------------------------------------------------
-- Exercise 1
-- Scalar Function: Annual Salary
----------------------------------------------------

CREATE FUNCTION fn_CalculateAnnualSalary
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 12;
END;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

----------------------------------------------------
-- Exercise 2
-- Table-Valued Function: Employees by Department
----------------------------------------------------

CREATE FUNCTION fn_GetEmployeesByDepartment
(
    @DepartmentID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        Salary,
        JoinDate
    FROM Employees
    WHERE DepartmentID = @DepartmentID
);
GO

SELECT *
FROM dbo.fn_GetEmployeesByDepartment(2);
GO

----------------------------------------------------
-- Exercise 3
-- User-Defined Function: Bonus (10%)
----------------------------------------------------

CREATE FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateBonus(Salary) AS Bonus
FROM Employees;
GO

----------------------------------------------------
-- Exercise 4
-- Modify fn_CalculateBonus (15%)
----------------------------------------------------

ALTER FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateBonus(Salary) AS Bonus
FROM Employees;
GO

----------------------------------------------------
-- Exercise 9
-- Nested Function: Total Compensation
-- (created here, ahead of Exercise 5's drop, since
--  Exercise 9/10 depend on fn_CalculateBonus existing)
----------------------------------------------------

CREATE FUNCTION fn_CalculateTotalCompensation
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN dbo.fn_CalculateAnnualSalary(@Salary) + dbo.fn_CalculateBonus(@Salary);
END;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO

----------------------------------------------------
-- Exercise 5
-- Delete fn_CalculateBonus
-- NOTE: dropping this breaks fn_CalculateTotalCompensation
-- (it references fn_CalculateBonus). Run this exercise
-- standalone if you want to actually verify the drop;
-- otherwise skip it to keep Exercise 9/10 working.
----------------------------------------------------

DROP FUNCTION IF EXISTS fn_CalculateBonus;
GO

-- Verify deletion
SELECT name
FROM sys.objects
WHERE type = 'FN' AND name = 'fn_CalculateBonus';
GO

-- Recreate so later exercises still work
CREATE FUNCTION fn_CalculateBonus
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

----------------------------------------------------
-- Exercise 6
-- Execute fn_CalculateAnnualSalary for all employees
----------------------------------------------------

SELECT
    EmployeeID,
    FirstName,
    LastName,
    dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;
GO

----------------------------------------------------
-- Exercise 7
-- Annual Salary for EmployeeID = 1
----------------------------------------------------

SELECT
    EmployeeID,
    FirstName,
    LastName,
    dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees
WHERE EmployeeID = 1;
GO

----------------------------------------------------
-- Exercise 8
-- Employees from Finance (DepartmentID = 3)
----------------------------------------------------

SELECT *
FROM dbo.fn_GetEmployeesByDepartment(3);
GO

----------------------------------------------------
-- Exercise 10
-- Modify fn_CalculateTotalCompensation
-- to use the updated (15%) fn_CalculateBonus
----------------------------------------------------

ALTER FUNCTION fn_CalculateTotalCompensation
(
    @Salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN dbo.fn_CalculateAnnualSalary(@Salary) + dbo.fn_CalculateBonus(@Salary);
END;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM Employees;
GO