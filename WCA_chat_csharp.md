# Granite Code Prompt Cookbook - WCA Chat

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent


## use cases

### 1. Code Explanation

- chat in WCA

```text
/explain @filename
```

- sample output

```markdown
This code is a C# program that calculates the total salary of all employees, finds the employee with the highest salary, and finds the average salary of employees who earn more than $60,000.

The code defines a class called Employee with properties for Id, Name, and Salary. It also defines a class called Program with a Main method that creates a list of Employee objects and performs the calculations.

The Main method initializes a list of Employee objects with sample data. It then calculates the total salary of all employees using the Sum method and the lambda expression e => e.Salary. The result is printed to the console using Console.WriteLine.

Next, the code finds the employee with the highest salary using the OrderByDescending method and the lambda expression e => e.Salary. The First method is used to retrieve the first employee in the sorted list. The result is printed to the console using Console.WriteLine.

Finally, the code finds the average salary of employees who earn more than $60,000 using the Where method and the lambda expression e => e.Salary > 60000. The ToList method is used to convert the filtered list to a new list. The Average method is then used to calculate the average salary of the high earners, and the result is printed to the console using Console.WriteLine.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @filename
```

- sample output

```csharp
# Assisted by watsonx Code Assistant 
//blob
using System;
using System.Collections.Generic;
using System.Linq;

namespace EmployeeManagement
{
    public class Employee
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Salary { get; set; }
    }

    public class Program
    {
        public static void Main(string[] args)
        {
            List<Employee> employees = new List<Employee>
            {
                new Employee { Id = 1, Name = "John Doe", Salary = 50000 },
                new Employee { Id = 2, Name = "Jane Smith", Salary = 60000 },
                new Employee { Id = 3, Name = "Mike Johnson", Salary = 70000 },
                new Employee { Id = 4, Name = "Emily Davis", Salary = 80000 },
                new Employee { Id = 5, Name = "Robert Brown", Salary = 90000 }
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
}
```

### 3. Code Translate

- chat in WCA

```text
/translate to python @filename
```

- sample output

```python
# Assisted by watsonx Code Assistant 
class Employee:
    def __init__(self, id, name, salary):
        self.id = id
        self.name = name
        self.salary = salary

employees = [
    Employee(1, "John Doe", 50000),
    Employee(2, "Jane Smith", 60000),
    Employee(3, "Mike Johnson", 70000),
    Employee(4, "Emily Davis", 80000),
    Employee(5, "Robert Brown", 90000)
]

# Calculate the total salary of all employees
total_salary = sum(employee.salary for employee in employees)
print(f"Total salary: {total_salary}")

# Find the employee with the highest salary
highest_paid_employee = max(employees, key=lambda e: e.salary)
print(f"Highest paid employee: {highest_paid_employee.name} ({highest_paid_employee.salary})")

# Find the average salary of employees who earn more than $60,000
high_earners = [employee for employee in employees if employee.salary > 60000]
average_high_earner_salary = sum(employee.salary for employee in high_earners) / len(high_earners)
print(f"Average salary of high earners: {average_high_earner_salary}")
```


### 4. Test Case Generation

- chat in WCA

```text
/unit-test @filename
```

- sample output

```csharp
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace EmployeeTests
{
    public class EmployeeTests
    {
        [Fact]
        public void CalculateTotalSalary_ReturnsCorrectTotal()
        {
            List<Employee> employees = new List<Employee>
            {
                new Employee { Id = 1, Name = "John Doe", Salary = 50000 },
                new Employee { Id = 2, Name = "Jane Smith", Salary = 60000 },
                new Employee { Id = 3, Name = "Mike Johnson", Salary = 70000 },
                new Employee { Id = 4, Name = "Emily Davis", Salary = 80000 },
                new Employee { Id = 5, Name = "Robert Brown", Salary = 90000 }
            };
            decimal totalSalary = employees.Sum(e => e.Salary);
            Assert.Equal(450000, totalSalary);
        }

        [Fact]
        public void FindHighestPaidEmployee_ReturnsCorrectEmployee()
        {
            List<Employee> employees = new List<Employee>
            {
                new Employee { Id = 1, Name = "John Doe", Salary = 50000 },
                new Employee { Id = 2, Name = "Jane Smith", Salary = 60000 },
                new Employee { Id = 3, Name = "Mike Johnson", Salary = 70000 },
                new Employee { Id = 4, Name = "Emily Davis", Salary = 80000 },
                new Employee { Id = 5, Name = "Robert Brown", Salary = 90000 }
            };
            Employee highestPaidEmployee = employees.OrderByDescending(e => e.Salary).First();
            Assert.Equal("Robert Brown", highestPaidEmployee.Name);
            Assert.Equal(90000, highestPaidEmployee.Salary);
        }

        [Fact]
        public void FindAverageHighEarnerSalary_ReturnsCorrectAverage()
        {
            List<Employee> employees = new List<Employee>
            {
                new Employee { Id = 1, Name = "John Doe", Salary = 50000 },
                new Employee { Id = 2, Name = "Jane Smith", Salary = 60000 },
                new Employee { Id = 3, Name = "Mike Johnson", Salary = 70000 },
                new Employee { Id = 4, Name = "Emily Davis", Salary = 80000 },
                new Employee { Id = 5, Name = "Robert Brown", Salary = 90000 }
            };
            List<Employee> highEarners = employees.Where(e => e.Salary > 60000).ToList();
            decimal averageHighEarnerSalary = highEarners.Average(e => e.Salary);
            Assert.Equal(75000, averageHighEarnerSalary);
        }
    }
}
```

### 5. Review Code

- chat input in WCA

```text
review @filename
```

- sample output

```text
Here is a review of the sample.cs code:

The code defines two classes, Employee and Program. The Employee class has three properties: Id, Name, and Salary. The Program class contains a Main method that demonstrates how to use LINQ to query and manipulate a list of Employee objects.

The Main method creates a list of Employee objects and calculates the total salary of all employees using the Sum method. It then finds the employee with the highest salary using the OrderByDescending and First methods. Finally, it finds the average salary of employees who earn more than $60,000 using the Where, ToList, and Average methods.

The code uses the System namespace for the Console class, as well as the System.Collections.Generic and System.Linq namespaces for the List, OrderByDescending, First, Where, ToList, and Average methods.

Overall, the code is a simple example of how to use LINQ to query and manipulate data in C#.
```

### 6. Fix Code

- chat in WCA

```text
fix @filename
```

- sample output


```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
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
            new Employee { Id = 2, Name = "Jane Smith", Salary = 60000 }
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

```

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid diagram for the c# code provided. @filename
```

- sample output

```mermaid
```



### 8. Interface Generation

- chat in WCA

```text
generate c# interface version base on the c# code provided. @filename
```

```csharp
```

### 9. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for the c++ code provided. @filename
```

- sample output

```bash
```

## sample c#

[good example](sample/csharp/sample.cs)

[bad example](sample/csharp/bad.cs)