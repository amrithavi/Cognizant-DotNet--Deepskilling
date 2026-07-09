-- Exercise 3
-- Create View: Employee Annual Salary

CREATE VIEW vw_EmployeeAnnualSalary
AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary
FROM Employees;

SELECT *
FROM vw_EmployeeAnnualSalary;