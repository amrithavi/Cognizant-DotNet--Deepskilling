using System;

class Employee
{
    public int EmployeeId;
    public string Name;
    public string Position;
    public double Salary;

    public Employee(int employeeId, string name, string position, double salary)
    {
        EmployeeId = employeeId;
        Name = name;
        Position = position;
        Salary = salary;
    }
}

class EmployeeManagementSystem
{
    private Employee[] employees;
    private int count;

    public EmployeeManagementSystem(int size)
    {
        employees = new Employee[size];
        count = 0;
    }

    // Add Employee
    public void AddEmployee(Employee employee)
    {
        if (count < employees.Length)
        {
            employees[count] = employee;
            count++;
            Console.WriteLine("Employee added successfully.");
        }
        else
        {
            Console.WriteLine("Employee array is full.");
        }
    }

    // Search Employee
    public Employee SearchEmployee(int employeeId)
    {
        for (int i = 0; i < count; i++)
        {
            if (employees[i].EmployeeId == employeeId)
            {
                return employees[i];
            }
        }
        return null;
    }

    // Traverse Employees
    public void DisplayEmployees()
    {
        if (count == 0)
        {
            Console.WriteLine("No employees found.");
            return;
        }

        for (int i = 0; i < count; i++)
        {
            Console.WriteLine(
                $"ID: {employees[i].EmployeeId}, " +
                $"Name: {employees[i].Name}, " +
                $"Position: {employees[i].Position}, " +
                $"Salary: {employees[i].Salary}"
            );
        }
    }

    // Delete Employee
    public void DeleteEmployee(int employeeId)
    {
        int index = -1;

        for (int i = 0; i < count; i++)
        {
            if (employees[i].EmployeeId == employeeId)
            {
                index = i;
                break;
            }
        }

        if (index == -1)
        {
            Console.WriteLine("Employee not found.");
            return;
        }

        for (int i = index; i < count - 1; i++)
        {
            employees[i] = employees[i + 1];
        }

        employees[count - 1] = null;
        count--;

        Console.WriteLine("Employee deleted successfully.");
    }
}

class Program
{
    static void Main()
    {
        EmployeeManagementSystem system = new EmployeeManagementSystem(5);

        system.AddEmployee(new Employee(101, "Alice", "Manager", 60000));
        system.AddEmployee(new Employee(102, "Bob", "Developer", 50000));
        system.AddEmployee(new Employee(103, "Charlie", "Tester", 40000));

        Console.WriteLine("\nEmployee Records:");
        system.DisplayEmployees();

        Console.WriteLine("\nSearching Employee ID 102:");
        Employee emp = system.SearchEmployee(102);

        if (emp != null)
        {
            Console.WriteLine($"Found: {emp.Name}, {emp.Position}");
        }
        else
        {
            Console.WriteLine("Employee not found.");
        }

        Console.WriteLine("\nDeleting Employee ID 102");
        system.DeleteEmployee(102);

        Console.WriteLine("\nUpdated Employee Records:");
        system.DisplayEmployees();
    }
}