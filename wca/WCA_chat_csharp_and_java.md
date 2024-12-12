# WCA Chat Command Cookbook - C#

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

### 1. install IBM watsonx Code Assistant extension in your vscode

![alt text](../images/wca_extension.png)

get an API KEY for watsonx Code Assistant

### 2. Install .NET

on Mac:

[download and install dotnet runtime](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-9.0.0-macos-arm64-installer?cid=getdotnetcore)

install dotnet command

```bash
brew install dotnet
```

## assumption

- Code Generation may include variation, which means every generation may not exactly same.
- Chat take the conversation as context. so the good side is you can give followup question. but it may also affect the output of your prompt. so in case the output is not desireable, please New a chat session. with following button:

![alt text](/images/new_chat_button.png)


## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- delete unused chat sessions also help.
- simple instruction works fine, hence make it simple

## sample c#

[good example](../sample/csharp/sample.cs)

[bad example](../sample/csharp/bad.cs)

[python source](../sample/csharp/source.py) for conversion.

## use cases

### 1. Code Generation

- create a empty file of generated.cs

#### 1.1 Simple Generation

create project

```bash
dotnet new console -n generated
```

```text
generate a csharp program that do calculate compound interest
```

```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
using System;

namespace CompoundInterestCalculator
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the principal amount: ");
            double principal = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter the annual interest rate: ");
            double interestRate = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter the number of years: ");
            int years = Convert.ToInt32(Console.ReadLine());

            double amount = principal * Math.Pow(1 + interestRate / 100, years);
            Console.WriteLine("The compound interest amount is: " + amount);
        }
    }
}

```

copy and paste and save it to Program.cs in the project created.

goto to the folder

```bash
cd sample/csharp/generated
```

build

```bash
dotnet build
```

```text
Restore complete (0.2s)
  generated succeeded (0.1s) → bin/Debug/net9.0/generated.dll

Build succeeded in 0.7s
```

run

```bash
bin/Debug/net9.0/generated
```

sample output

```text
Enter the principal amount: 
12
Enter the annual interest rate: 
112
Enter the number of years: 
3
The compound interest amount is: 114.337536
```

#### 1.2 Add Function

```text
add a api about calculation sum to @Program.cs
```

```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//Program.cs
namespace CompoundInterestCalculator
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the principal amount: ");
            double principal = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter the annual interest rate: ");
            double interestRate = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter the number of years: ");
            int years = Convert.ToInt32(Console.ReadLine());

            double amount = principal * Math.Pow(1 + interestRate / 100, years);
            Console.WriteLine("The compound interest amount is: " + amount);

            Console.WriteLine("The sum of 1 and 2 is: " + Sum(1, 2));
        }

        static int Sum(int a, int b)
        {
            return a + b;
        }
    }
}
```

copy and paste back to Program.cs

and do the test again

```bash
dotnet build
```

```text
Restore complete (0.2s)
  generated succeeded (0.3s) → bin/Debug/net9.0/generated.dll

Build succeeded in 0.9s
```

run

```bash
bin/Debug/net9.0/generated
```

sample output

```text
Enter the principal amount: 
3
Enter the annual interest rate: 
3
Enter the number of years: 
2
The compound interest amount is: 3.1826999999999996
The sum of 1 and 2 is: 3
```

### 2. Code Completion

#### 2.1 Inline Code Completion

- edit some code, and experience the code completion and accept it with `tab` key.

#### 2.2 Multiple Line Code Completion

- type `Option + .` key to generate the completion base on context, and accept it with `tab` key.

### 3. Code Explanation

#### 3.1 Explain the whole program

```text
/explain @sample.cs
```

- sample output

```markdown
This code is a C# program that calculates the total salary of all employees, finds the employee with the highest salary, and finds the average salary of employees who earn more than $60,000.

The code defines a class called Employee with properties for Id, Name, and Salary. It also defines a class called Program with a Main method that creates a list of Employee objects and performs the calculations.

The Main method initializes a list of Employee objects with sample data. It then calculates the total salary of all employees using the Sum method and the lambda expression e => e.Salary. The result is printed to the console using Console.WriteLine.

Next, the code finds the employee with the highest salary using the OrderByDescending method and the lambda expression e => e.Salary. The First method is used to retrieve the first employee in the sorted list. The result is printed to the console using Console.WriteLine.

Finally, the code finds the average salary of employees who earn more than $60,000 using the Where method and the lambda expression e => e.Salary > 60000. The ToList method is used to convert the filtered list to a new list. The Average method is then used to calculate the average salary of the high earners, and the result is printed to the console using Console.WriteLine.
```

### 3.2 Explain particular detail

```text
explain how to do the calculation in @sample.cs
```

- sample output

```markdown
The code in sample.cs calculates the total salary of all employees, finds the employee with the highest salary, and calculates the average salary of employees who earn more than $60,000.

Here's how the code works:

The code defines two classes: Employee and Program. The Employee class has properties for Id, Name, and Salary, while the Program class contains the main logic for the calculations.

Inside the Main method of the Program class, a list of Employee objects is created and populated with sample data.

The Sum method is used to calculate the total salary of all employees. The OrderByDescending and First methods are used to find the employee with the highest salary.

A new list called highEarners is created by filtering the employees list to include only employees who earn more than $60,000. The Average method is then used to calculate the average salary of these high earners.

Finally, the results are printed to the console using Console.WriteLine.

Overall, the code is a simple and effective way to perform these calculations in C#.
```

### 4. Generate Documentation

#### 4.1 Simple Documentation

```text
/document @sample.cs
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

#### 4.2 Generate Function Spec

```text
generate function spec to markdown for @sample.cs
```

- sample output

```markdown
Function Spec Doc for sample.cs
Function: CalculateTotalSalary
Description:
Calculates the total salary of all employees in the given list.

Parameters:
employees: A list of Employee objects.
Returns:
The total salary of all employees in the list.

Function: FindHighestPaidEmployee
Description:
Finds the employee with the highest salary in the given list.

Parameters:
employees: A list of Employee objects.
Returns:
The employee with the highest salary in the list.

Function: CalculateAverageHighEarnerSalary
Description:
Calculates the average salary of employees who earn more than $60,000 in the given list.

Parameters:
employees: A list of Employee objects.
Returns:
The average salary of employees who earn more than $60,000 in the list.
```

### 5. Code Translate

#### 5.1 convert C# to Java

```text
/translate to java @sample.cs
```

- sample output

```java
// Assisted by watsonx Code Assistant 
import java.util.List;
import java.util.ArrayList;

public class Employee {
    private int id;
    private String name;
    private double salary;

    public Employee(int id, String name, double salary) {
        this.id = id;
        this.name = name;
        this.salary = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }
}

public class Main {
    public static void main(String[] args) {
        List<Employee> employees = new ArrayList<>();
        employees.add(new Employee(1, "John Doe", 50000.0));
        employees.add(new Employee(2, "Jane Smith", 60000.0));
        employees.add(new Employee(3, "Bob Johnson", 70000.0));

        // Calculate the total salary of all employees
        double totalSalary = employees.stream().mapToDouble(Employee::getSalary).sum();
        System.out.println("Total salary: " + totalSalary);

        // Find the employee with the highest salary
        Employee highestPaidEmployee = employees.stream().max((e1, e2) -> Double.compare(e1.getSalary(), e2.getSalary())).orElse(null);
        System.out.println("Highest paid employee: " + (highestPaidEmployee != null ? highestPaidEmployee.getName() : "No employees found"));

        // Find the average salary of employees who earn more than $60,000
        double averageHighEarnerSalary = employees.stream().filter(e -> e.getSalary() > 60000.0).mapToDouble(Employee::getSalary).average().orElse(0.0);
        System.out.println("Average salary of high earners: " + averageHighEarnerSalary);
    }
}
```

### 6. Test Case Generation

#### 6.1 Unit Test

```text
/unit-test @Employee.java
```

- sample output

```java
// Assisted by watsonx Code Assistant 
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class EmployeeTest {
    @Test
    public void testGetSalary() {
        Employee employee = new Employee(1, "John", 50000);
        double salary = employee.getSalary();
        assertEquals(50000, salary);
    }
}
```

```java
// Assisted by watsonx Code Assistant 
import org.junit.jupiter.api.Test;

public class EmployeeTest {
    @Test
    public void testSetName() {
        Employee employee = new Employee(1, "John", 50000);
        employee.setName("Jane");
        assertEquals("Jane", employee.getName());
    }
}
```

### 7. Review Code

#### 7.1 Specific Review

```text
review @Employee.java in exception handling
```

- sample output

```java
 // Assisted by watsonx Code Assistant 
 
//Employee.java
 
public class Employee {
    private int id;
    private String name;
    private double salary;

    public Employee(int id, String name, double salary) {
        this.id = id;
        this.name = name;
        this.salary = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        if (salary < 0) {
            throw new IllegalArgumentException("Salary cannot be negative");
        }
        this.salary = salary;
    }
}
```

### 8. Fix Code

- chat in WCA

```text
fix @bad.cs
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

### 9. Generate Diagram

install mermaid preview extension in your vscode

![alt text](../images/mermaid_preview.png)

copy and paste the mermaid result to the [diagram file](../sample/csharp/diagram.md) file as follow:

```text
```mermaid
your diagram
    diagram detail 1
    diagram detail 2
```

#### 9.1 sequence diagram

```text
generate UML sequence diagram in mermaid for the logic how user interact with system in @sample.cs
```

sample output

```mermaid
sequenceDiagram
    participant User
    participant System
    User->>System: Open sample.cs
    System-->>User: Display code
    User->>System: Run code
    System-->>User: Display output
```

#### 9.2 class diagram

```text
generate UML class diagram in mermaid for the logic how user interact with system in @sample.cs
```

sample output

```mermaid
classDiagram
    Employee "1" -- "*" Program
    Employee : int Id
    Employee : string Name
    Employee : decimal Salary
    Program : void Main(string[] args)
    Program : List<Employee> employees
    Program : List<Employee> highEarners
    Program : Employee highestPaidEmployee
    Program : decimal totalSalary
    Program : decimal averageHighEarnerSalary
```

### 10. Interface Generation

- chat in WCA

```text
generate interface @sample.cs
```

```csharp
  // Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
  
 
using System;

namespace SampleNamespace
{
    public interface ISampleInterface
    {
        void DoSomething();
    }

    public class SampleClass : ISampleInterface
    {
        public void DoSomething()
        {
            Console.WriteLine("Doing something...");
        }
    }

    public class Program
    {
        public static void Main(string[] args)
        {
            ISampleInterface sample = new SampleClass();
            sample.DoSomething();
        }
    }
}

```

### 11. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script @sample.cs
```

- sample output

```bash
 // Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
 
#!/bin/bash

# Build the sample.cs program
dotnet build sample.cs

# Run the sample.cs program
dotnet run sample.cs

# Clean up the build artifacts
rm -rf bin obj
```
