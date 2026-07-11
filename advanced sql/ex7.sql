DROP DATABASE IF EXISTS EmployeeCursorsExercise;
GO

CREATE DATABASE EmployeeCursorsExercise;
GO

USE EmployeeCursorsExercise;
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
(3,'Bob','Johnson',3,5500.00,'2021-07-30');

----------------------------------------------------
-- Verify Tables
----------------------------------------------------

SELECT * FROM Departments;
SELECT * FROM Employees;

----------------------------------------------------
-- Exercise 1
-- Basic Cursor: Iterate and Print Employee Details
----------------------------------------------------

DECLARE @EmployeeID INT;
DECLARE @FirstName VARCHAR(50);
DECLARE @LastName VARCHAR(50);
DECLARE @DepartmentID INT;
DECLARE @Salary DECIMAL(10,2);
DECLARE @JoinDate DATE;

DECLARE emp_cursor CURSOR FOR
    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
    FROM Employees;

OPEN emp_cursor;

FETCH NEXT FROM emp_cursor
INTO @EmployeeID, @FirstName, @LastName, @DepartmentID, @Salary, @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'EmployeeID: ' + CAST(@EmployeeID AS VARCHAR)
        + ' | Name: ' + @FirstName + ' ' + @LastName
        + ' | DepartmentID: ' + CAST(@DepartmentID AS VARCHAR)
        + ' | Salary: ' + CAST(@Salary AS VARCHAR)
        + ' | JoinDate: ' + CAST(@JoinDate AS VARCHAR);

    FETCH NEXT FROM emp_cursor
    INTO @EmployeeID, @FirstName, @LastName, @DepartmentID, @Salary, @JoinDate;
END

CLOSE emp_cursor;
DEALLOCATE emp_cursor;
GO

----------------------------------------------------
-- Exercise 2
-- Types of Cursors: STATIC, DYNAMIC, FORWARD_ONLY, KEYSET
----------------------------------------------------

-- (a) STATIC Cursor
-- Snapshot taken at OPEN time; later changes to the underlying
-- data are NOT visible to the cursor.

DECLARE static_cursor CURSOR STATIC FOR
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees;

OPEN static_cursor;

FETCH NEXT FROM static_cursor;
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM static_cursor;
END

CLOSE static_cursor;
DEALLOCATE static_cursor;
GO

-- (b) DYNAMIC Cursor
-- Reflects all data changes (inserts/updates/deletes) made while
-- the cursor is open, including changes made by other sessions.

DECLARE dynamic_cursor CURSOR DYNAMIC FOR
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees;

OPEN dynamic_cursor;

FETCH NEXT FROM dynamic_cursor;
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM dynamic_cursor;
END

CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;
GO

-- (c) FORWARD_ONLY Cursor
-- Can only move forward with FETCH NEXT, row by row, no scrolling
-- backward. Fastest and lowest overhead of the four.

DECLARE forward_cursor CURSOR FORWARD_ONLY FOR
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees;

OPEN forward_cursor;

FETCH NEXT FROM forward_cursor;
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM forward_cursor;
END

CLOSE forward_cursor;
DEALLOCATE forward_cursor;
GO

-- (d) KEYSET Cursor
-- Membership and row order are fixed at OPEN time (like STATIC),
-- but updates to non-key columns made by other sessions ARE
-- visible when you re-fetch a row. New rows inserted elsewhere
-- are NOT visible; deleted rows show as @@FETCH_STATUS = -2.

DECLARE keyset_cursor CURSOR KEYSET FOR
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees;

OPEN keyset_cursor;

FETCH NEXT FROM keyset_cursor;
WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM keyset_cursor;
END

CLOSE keyset_cursor;
DEALLOCATE keyset_cursor;
GO