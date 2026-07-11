DROP DATABASE IF EXISTS EmployeeTriggersExercise;
GO

CREATE DATABASE EmployeeTriggersExercise;
GO

USE EmployeeTriggersExercise;
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
(2,'Finance'),
(3,'IT'),
(4,'Marketing');

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1,'John','Doe',1,5000.00,'2022-01-15'),
(2,'Jane','Smith',2,6000.00,'2021-03-22'),
(3,'Michael','Johnson',3,7000.00,'2020-07-30'),
(4,'Emily','Davis',4,5500.00,'2019-11-05');

----------------------------------------------------
-- Verify Tables
----------------------------------------------------

SELECT * FROM Departments;
SELECT * FROM Employees;

----------------------------------------------------
-- Exercise 1
-- AFTER Trigger: Log Salary Changes
----------------------------------------------------

CREATE TABLE EmployeeChanges
(
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_LogSalaryChange
ON Employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        INSERT INTO EmployeeChanges (EmployeeID, OldSalary, NewSalary)
        SELECT
            i.EmployeeID,
            d.Salary,
            i.Salary
        FROM INSERTED i
        JOIN DELETED d
            ON i.EmployeeID = d.EmployeeID
        WHERE i.Salary <> d.Salary;
    END
END;
GO

-- Test: update a salary and check the log
UPDATE Employees
SET Salary = 5200.00
WHERE EmployeeID = 1;
GO

SELECT * FROM EmployeeChanges;
GO

----------------------------------------------------
-- Exercise 2
-- INSTEAD OF Trigger: Prevent Deletions
----------------------------------------------------

CREATE TRIGGER trg_PreventDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Deletion of employee records is not allowed.', 16, 1);
END;
GO

-- Test: attempt a delete (should fail)
DELETE FROM Employees
WHERE EmployeeID = 4;
GO

SELECT * FROM Employees;
GO

----------------------------------------------------
-- Exercise 3
-- LOGON Trigger: Restrict Access During Maintenance
----------------------------------------------------

CREATE TRIGGER trg_RestrictLogonHours
ON ALL SERVER
FOR LOGON
AS
BEGIN
    IF DATEPART(HOUR, GETDATE()) = 2
    BEGIN
        ROLLBACK;
        RAISERROR('Login denied. Database is under maintenance between 2 AM and 3 AM.', 16, 1);
    END
END;
GO

-- To view logon triggers:
SELECT *
FROM sys.server_triggers;
GO

-- To remove during testing, since a logon trigger can lock you out
-- if something goes wrong:
-- DROP TRIGGER trg_RestrictLogonHours ON ALL SERVER;

----------------------------------------------------
-- Exercise 4
-- Modify a Trigger (example: broaden Ex.1 to log inserts too)
----------------------------------------------------

ALTER TRIGGER trg_LogSalaryChange
ON Employees
AFTER UPDATE, INSERT
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        INSERT INTO EmployeeChanges (EmployeeID, OldSalary, NewSalary)
        SELECT
            i.EmployeeID,
            ISNULL(d.Salary, 0),
            i.Salary
        FROM INSERTED i
        LEFT JOIN DELETED d
            ON i.EmployeeID = d.EmployeeID
        WHERE d.EmployeeID IS NULL
           OR i.Salary <> d.Salary;
    END
END;
GO

----------------------------------------------------
-- Exercise 5
-- Delete a Trigger
----------------------------------------------------

DROP TRIGGER IF EXISTS trg_PreventDelete;
GO

-- Verify deletion
SELECT name
FROM sys.triggers
WHERE name = 'trg_PreventDelete';
GO

----------------------------------------------------
-- Exercise 6
-- Trigger to Maintain a Computed AnnualSalary Column
----------------------------------------------------

ALTER TABLE Employees
ADD AnnualSalary DECIMAL(10,2) NULL;
GO

-- Backfill existing rows
UPDATE Employees
SET AnnualSalary = Salary * 12;
GO

CREATE TRIGGER trg_UpdateAnnualSalary
ON Employees
AFTER UPDATE, INSERT
AS
BEGIN
    IF UPDATE(Salary)
    BEGIN
        UPDATE e
        SET e.AnnualSalary = i.Salary * 12
        FROM Employees e
        JOIN INSERTED i
            ON e.EmployeeID = i.EmployeeID;
    END
END;
GO

-- Test
UPDATE Employees
SET Salary = 6500.00
WHERE EmployeeID = 2;
GO

SELECT EmployeeID, Salary, AnnualSalary FROM Employees;
GO