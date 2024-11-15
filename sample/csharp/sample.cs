// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//good.cs
using System;
using System.Collections.Generic;
using System.Linq;

public class Employee
{
    public int Id { get; set; }
    public string Name { get; set; }
    public decimal Salary { get; set; }
}

public class Program
{
    static void Main(string[] args)
    {
        List<Employee> employees = new List<Employee>
        {
            new Employee { Id = 1, Name = "John Doe", Salary = 50000 },
            new Employee { Id = 2, Name = "Jane Smith", Salary = 60000 },
            new Employee { Id = 3, Name = "Bob Johnson", Salary = 70000 }
        };

        // Calculate the total salary of all employees
        decimal totalSalary = employees.Sum(e => e.Salary);
        Console.WriteLine($"Total salary: {totalSalary}");

        // Find the employee with the highest salary
        Employee highestPaidEmployee = employees.OrderByDescending(e => e.Salary).First();
        Console.WriteLine($"Highest paid employee: {highestPaidEmployee.Name} ({highestPaidEmployee.Salary})");

        // Find the average salary of employees who earn more than $60,000
        List<Employee> highEarners = employees.Where(e => e.Salary > 60000).ToList();
        decimal averageHighEarnerSalary = highEarners.Average(e => e.Salary);
        Console.WriteLine($"Average salary of high earners: {averageHighEarnerSalary}");
    }
}
