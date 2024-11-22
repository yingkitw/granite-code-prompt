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