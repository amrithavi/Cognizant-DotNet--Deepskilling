DROP DATABASE IF EXISTS EmployeeExceptionHandling;
GO

CREATE DATABASE EmployeeExceptionHandling;
GO

USE EmployeeExceptionHandling;
GO

----------------------------------------------------
-- Departments Table
----------------------------------------------------

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

----------------------------------------------------
-- Employees Table
----------------------------------------------------

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

----------------------------------------------------
-- AuditLog Table
----------------------------------------------------

CREATE TABLE AuditLog
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Action VARCHAR(100),
    ErrorMessage VARCHAR(4000),
    ActionDate DATETIME DEFAULT GETDATE()
);

----------------------------------------------------
-- Sample Data
----------------------------------------------------

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID) VALUES
(1,'John','Doe','john.doe@company.com',5000.00,1),
(2,'Jane','Smith','jane.smith@company.com',6000.00,2);

----------------------------------------------------
-- Verify Tables
----------------------------------------------------

SELECT * FROM Departments;
SELECT * FROM Employees;
SELECT * FROM AuditLog;

----------------------------------------------------
-- Question 1
-- Basic TRY...CATCH for Error Logging
----------------------------------------------------

CREATE PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID);
    END TRY
    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());
    END CATCH
END;
GO

-- Test: duplicate email should fail and get logged
EXEC AddEmployee 3, 'Dup', 'Email', 'john.doe@company.com', 5200.00, 1;
GO

SELECT * FROM AuditLog;
GO

----------------------------------------------------
-- Question 2
-- Using THROW to Re-raise Errors
----------------------------------------------------

ALTER PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID);
    END TRY
    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

-- Test: this now fails AND surfaces the error to the caller
BEGIN TRY
    EXEC AddEmployee 4, 'Dup2', 'Email2', 'jane.smith@company.com', 5300.00, 2;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

----------------------------------------------------
-- Question 3
-- Custom Error with RAISERROR (Salary Validation)
----------------------------------------------------

ALTER PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        IF @Salary <= 0
        BEGIN
            RAISERROR('Salary must be greater than zero.', 16, 1);
        END

        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID);
    END TRY
    BEGIN CATCH
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

-- Test: invalid salary
BEGIN TRY
    EXEC AddEmployee 5, 'Zero', 'Salary', 'zero.salary@company.com', 0.00, 1;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

----------------------------------------------------
-- Question 4
-- Nested TRY...CATCH: TransferEmployee
----------------------------------------------------

CREATE PROCEDURE TransferEmployee
    @EmployeeID INT,
    @NewDepartmentID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRY
            IF NOT EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @NewDepartmentID)
            BEGIN
                RAISERROR('Target department does not exist.', 16, 1);
            END

            UPDATE Employees
            SET DepartmentID = @NewDepartmentID
            WHERE EmployeeID = @EmployeeID;
        END TRY
        BEGIN CATCH
            -- Inner catch: log, then re-raise to the outer block
            INSERT INTO AuditLog (Action, ErrorMessage)
            VALUES ('TransferEmployee (inner)', ERROR_MESSAGE());

            THROW;
        END CATCH
    END TRY
    BEGIN CATCH
        -- Outer catch: final handling point for the caller
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('TransferEmployee (outer)', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

-- Test: nonexistent department
BEGIN TRY
    EXEC TransferEmployee 1, 99;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

SELECT * FROM AuditLog;
GO

----------------------------------------------------
-- Question 5
-- Transactional Batch Insert
----------------------------------------------------

CREATE TYPE EmployeeTableType AS TABLE
(
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Salary DECIMAL(10,2),
    DepartmentID INT
);
GO

CREATE PROCEDURE BatchInsertEmployees
    @NewEmployees EmployeeTableType READONLY
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        SELECT EmployeeID, FirstName, LastName, Email, Salary, DepartmentID
        FROM @NewEmployees;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('BatchInsertEmployees', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

-- Test: batch with one bad row (duplicate email) rolls the whole batch back
DECLARE @Batch EmployeeTableType;

INSERT INTO @Batch VALUES
(10,'Alice','Brown','alice.brown@company.com',5100.00,1),
(11,'Carl','White','john.doe@company.com',5200.00,2); -- duplicate email

BEGIN TRY
    EXEC BatchInsertEmployees @Batch;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

-- Verify neither row 10 nor 11 made it in
SELECT * FROM Employees WHERE EmployeeID IN (10, 11);
GO

----------------------------------------------------
-- Question 6
-- Dynamic RAISERROR with Severity and State
----------------------------------------------------

ALTER PROCEDURE AddEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    BEGIN TRY
        IF @Salary < 0
        BEGIN
            RAISERROR('Salary cannot be negative.', 16, 1);
        END
        ELSE IF @Salary < 1000
        BEGIN
            RAISERROR('Warning: salary is unusually low.', 10, 1);
        END

        INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID);
    END TRY
    BEGIN CATCH
        -- Severity 10 is informational and does NOT jump to CATCH,
        -- so only true errors (severity >= 11, e.g. our 16) land here.
        INSERT INTO AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

-- Test: negative salary -> real error, caught and logged
BEGIN TRY
    EXEC AddEmployee 20, 'Neg', 'Salary', 'neg.salary@company.com', -500.00, 1;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

-- Test: low salary -> severity 10 warning, insert still proceeds
EXEC AddEmployee 21, 'Low', 'Salary', 'low.salary@company.com', 800.00, 1;
GO

SELECT * FROM Employees WHERE EmployeeID = 21;
GO