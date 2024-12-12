import java.util.List;
import java.util.ArrayList;
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
