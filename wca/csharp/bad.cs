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
            new Employee { Id = 2, Na
        };

        // Calculate the total salary of all employees
        decimal totalSalary = employees.Sum(e => e.Salary);
        Console.WriteLine($"Total salary: {totalSalary}");

        // Find the employee with the highest salary
        Employee highestPaidEmployee = employees.OrderByDescending(e => e.Salary).First();
        Console.WriteLine($"Highest paid employee: {highestPaidEmployee.Name} ({high
        // Find the average salary of employees who earn more than $60,000
        List<Employee> highEarners = employees.Where(e =>
        Console.WriteLine($"Average salary of high earners: {averageHighEarnerSalary}");
    }
}