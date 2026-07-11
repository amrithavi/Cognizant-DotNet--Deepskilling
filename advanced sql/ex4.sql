DROP DATABASE IF EXISTS EmployeeManagementSystem;
GO

CREATE DATABASE EmployeeManagementSystem;
GO

USE EmployeeManagementSystem;
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

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Marketing');

INSERT INTO Employees
(EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate)
VALUES
(1,'John','Doe',1,5000.00,'2020-01-15'),
(2,'Jane','Smith',2,6000.00,'2019-03-22'),
(3,'Michael','Johnson',3,7000.00,'2018-07-30'),
(4,'Emily','Davis',4,5500.00,'2021-11-05');

----------------------------------------------------
-- Verify Data
----------------------------------------------------

SELECT * FROM Departments;
SELECT * FROM Employees;
GO

----------------------------------------------------
-- Exercise 1
-- Create Stored Procedure
----------------------------------------------------

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        JoinDate
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

----------------------------------------------------
-- Insert Procedure (as per exercise)
----------------------------------------------------

CREATE PROCEDURE sp_InsertEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE
AS
BEGIN
    INSERT INTO Employees
    (
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        Salary,
        JoinDate
    )
    VALUES
    (
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate
    );
END;
GO

----------------------------------------------------
-- Exercise 2
-- Modify Stored Procedure
----------------------------------------------------

ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        Salary,
        JoinDate
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

----------------------------------------------------
-- Exercise 3
-- Delete Stored Procedure
----------------------------------------------------

DROP PROCEDURE IF EXISTS sp_InsertEmployee;
GO

----------------------------------------------------
-- Exercise 4
-- Execute Stored Procedure
----------------------------------------------------

EXEC sp_GetEmployeesByDepartment @DepartmentID = 1;
GO

----------------------------------------------------
-- Exercise 5
-- Employee Count by Department
----------------------------------------------------

CREATE PROCEDURE sp_GetEmployeeCount
    @DepartmentID INT
AS
BEGIN
    SELECT COUNT(*) AS EmployeeCount
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GetEmployeeCount 3;
GO

----------------------------------------------------
-- Exercise 6
-- Output Parameter
----------------------------------------------------

CREATE PROCEDURE sp_GetTotalSalary
    @DepartmentID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

DECLARE @Total DECIMAL(10,2);

EXEC sp_GetTotalSalary
    @DepartmentID = 3,
    @TotalSalary = @Total OUTPUT;

SELECT @Total AS TotalSalary;
GO

----------------------------------------------------
-- Exercise 7
-- Update Employee Salary
----------------------------------------------------

CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
GO

EXEC sp_UpdateEmployeeSalary 1, 5500.00;
GO

----------------------------------------------------
-- Exercise 8
-- Give Bonus
----------------------------------------------------

CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount DECIMAL(10,2)
AS
BEGIN
    IF EXISTS
    (
        SELECT *
        FROM Employees
        WHERE DepartmentID = @DepartmentID
    )
    BEGIN
        UPDATE Employees
        SET Salary = Salary + @BonusAmount
        WHERE DepartmentID = @DepartmentID;
    END
END;
GO

EXEC sp_GiveBonus 1, 500.00;
GO

----------------------------------------------------
-- Exercise 9
-- Transaction
----------------------------------------------------

CREATE PROCEDURE sp_UpdateSalaryWithTransaction
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY

        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;
        THROW;

    END CATCH
END;
GO

EXEC sp_UpdateSalaryWithTransaction 2,6200.00;
GO

----------------------------------------------------
-- Exercise 10
-- Dynamic SQL
----------------------------------------------------

CREATE PROCEDURE sp_GetEmployeesByFilter
    @FilterColumn VARCHAR(50),
    @FilterValue VARCHAR(50)
AS
BEGIN

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL =
    N'SELECT * FROM Employees WHERE '
    + QUOTENAME(@FilterColumn)
    + N' = @Value';

    EXEC sp_executesql
        @SQL,
        N'@Value VARCHAR(50)',
        @Value = @FilterValue;

END;
GO

EXEC sp_GetEmployeesByFilter
    @FilterColumn = 'DepartmentID',
    @FilterValue = '3';
GO

----------------------------------------------------
-- Exercise 11
-- Error Handling
----------------------------------------------------

CREATE PROCEDURE sp_UpdateSalarySafe
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN

    BEGIN TRY

        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        IF @@ROWCOUNT = 0
            THROW 51000, 'No employee found with the given EmployeeID.', 1;

    END TRY

    BEGIN CATCH

        SELECT
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;

    END CATCH

END;
GO

EXEC sp_UpdateSalarySafe 99,7000.00;
GO