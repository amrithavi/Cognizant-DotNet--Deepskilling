using Microsoft.AspNetCore.Mvc;
using FirstWebApi.Models;
using FirstWebApi.Filters;

namespace FirstWebApi.Controllers;

[ApiController]
[Route("[controller]")]
[CustomAuthFilter]
public class EmployeeController : ControllerBase
{
    private List<Employee> employees;

    public EmployeeController()
    {
        employees = GetStandardEmployeeList();
    }

    private List<Employee> GetStandardEmployeeList()
    {
        return new List<Employee>
        {
            new Employee
            {
                Id = 1,
                Name = "John",
                Salary = 50000,
                Permanent = true,
                DateOfBirth = new DateTime(1995,5,10),

                Department = new Department
                {
                    Id = 1,
                    Name = "IT"
                },

                Skills = new List<Skill>
                {
                    new Skill{ Id=1, Name="C#"},
                    new Skill{ Id=2, Name="SQL"}
                }
            },

            new Employee
            {
                Id = 2,
                Name = "Alice",
                Salary = 60000,
                Permanent = false,
                DateOfBirth = new DateTime(1998,3,15),

                Department = new Department
                {
                    Id = 2,
                    Name = "HR"
                },

                Skills = new List<Skill>
                {
                    new Skill{ Id=3, Name="Communication"}
                }
            }
        };
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]

    public ActionResult<List<Employee>> GetStandard()
    {
      throw new Exception("Testing Exception Filter");
    }

    [HttpPost]
    public IActionResult Post([FromBody] Employee employee)
    {
        employees.Add(employee);

        return Ok(employee);
    }

    [HttpPut]
    public IActionResult Put([FromBody] Employee employee)
    {
        Employee? emp = employees.FirstOrDefault(e => e.Id == employee.Id);

        if (emp == null)
            return NotFound();

        emp.Name = employee.Name;
        emp.Salary = employee.Salary;
        emp.Permanent = employee.Permanent;
        emp.Department = employee.Department;
        emp.Skills = employee.Skills;
        emp.DateOfBirth = employee.DateOfBirth;

        return Ok(emp);
    }
}