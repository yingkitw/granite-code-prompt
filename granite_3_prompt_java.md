# Prompting with IBM Granite 3 Model for Coding Use Cases

I utilising the latest IBM Granite 3 8B Instruct Model for these coding tasks. This model is lightweight and supports a wide range of programming languages, making it ideal for diverse coding needs.
Experiment Objectives
The experiment focuses on several key areas, grouped into Code Understanding and Code Generation:

Code Understanding

- Code Explanation: Break down complex code snippets to make them easier to understand.
- Code Documentation: Automatically generate detailed documentation to keep records up-to-date.
- Code Review: Analyze code for potential improvements and ensure adherence to best practices.

Code Generation

- Code Improvement: Suggest optimizations to enhance efficiency and performance.
- Code Conversion: Translate code between different programming languages.
- Code Fixing: Identify and resolve bugs or errors in existing code.
- API Generation: Automatically create APIs from given specifications.
- Test Case Generation: Develop test cases to ensure code reliability and performance.
- Diagram Generation: Visualize code structure and workflows through generated diagrams.

The experiment will be conducted using sample Java code to demonstrate these capabilities.

```java
import java.util.*;

public class Main {

    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt();
            int[] a = new int[n];
            for(int a_i=0; a_i < n; a_i++){
                a[a_i] = in.nextInt();
            }
        }
    }

    public void calculate(int[] a) {
        int sum = 0;
        for (int i = 0; i < a.length; i++) {
            sum += a[i];
        }
        System.out.println(sum);
    }

    public void print(int[] a) {
        for (int i = 0; i < a.length; i++) {
            System.out.println(a[i]);
        }
    }

    public void sort(int[] a) {
        Arrays.sort(a);
        double median;
        if (a.length % 2 == 0) {
            median = (a[a.length / 2 - 1] + a[a.length / 2]) / 2.0;
        } else {
            median = a[a.length / 2];
        }
    }
}
```

A few context variable

```python
model_id = GRANITE_3_8B_INSTRUCT
language = "java"
documentframework = "javadoc"
testframework = "junit"
```

Initialise with watsonx.ai, please prepare your API_KEY and PROJECT_ID

```bash
pip install -U ibm-watsonx-ai
```

```python
from ibm_watsonx_ai.foundation_models import ModelInference
from ibm_watsonx_ai.metanames import GenTextParamsMetaNames as GenParams
import os
from dotenv import load_dotenv

load_dotenv()
api_key = os.getenv("API_KEY", None)
project_id = os.getenv("PROJECT_ID", None)

creds = {
    "url"    : "https://us-south.ml.cloud.ibm.com",
    "apikey" : api_key
}

params = {
    GenParams.DECODING_METHOD:"greedy",
    GenParams.MAX_NEW_TOKENS:4000,
    GenParams.MIN_NEW_TOKENS:1,
    # "temperature":0.1,
    GenParams.TOP_K:50,
    GenParams.TOP_P:1,
    GenParams.STOP_SEQUENCES:["```","[/INST]","<|user|>","<|endoftext|>","<|assistant|>"],
}

model = ModelInference(model_id="ibm/granite-3-8b-instruct", credentials=creds, params=params, project_id=project_id)
```

## Code Explanation

Understanding complex code segments is made easier with Granite 3 Model's detailed code explanations. It breaks down intricate code logic into comprehensible language, helping developers to grasp the functionality and purpose of different code sections. This feature is particularly useful for onboarding new team members, debugging, and maintaining large codebases where understanding legacy code is essential.

prompt for Explanation

```python
prompt = f"""<|user|>
Please provide a detailed explanation for the following {language} code:
-ensure have new line after every full stop.

###
code: `{sample_code}`
<|assistant|>
explanation:
"""

answer = watsonx_code_gen(prompt,model_id)
print(answer)
```

output for explanation

```markdown
This Java code is a simple program that reads an array of integers from the user, calculates the sum of its elements, prints each element on a new line, sorts the array, and then finds and prints the median value. Here's a step-by-step explanation:
1. The `main` method initializes a `Scanner` object to read input from the user. It then reads an integer `n`, which represents the size of the array, and creates an integer array `a` of size `n`.
2. The `calculate` method takes the array as input and calculates the sum of its elements by iterating through the array and adding each element to a running total. It then prints the sum.
3. The `print` method takes the array as input and prints each element on a new line using a `for` loop.
4. The `sort` method takes the array as input and sorts it in ascending order using the `Arrays.sort()` method. It then calculates the median value based on whether the array has an even or odd number of elements. If the array has an even number of elements, the median is the average of the two middle elements. If the array has an odd number of elements, the median is the middle element.
5. Finally, the `sort` method prints the median value.
```

## Automatic Documentation Generation

IBM Granite 3 Model automates the creation of comprehensive documentation for your codebase, eliminating the need for manual documentation efforts. By analyzing the code structure and functionality, it generates clear and detailed documentation that is essential for maintaining and scaling projects. This feature ensures that all aspects of the code are well-documented, making it easier for new developers to understand and contribute to the project.

prompt for document generation

```python
prompt = f"""<|user|>
generate {documentframework} document for the {language} provided.
-generate the {language} code only.
{language}: `{sample_code}`
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

output for document generation

```java
/**
 * This class represents the main application that reads an array of integers from the user,
 * calculates the sum of its elements, prints each element, sorts the array, and finds the median.
 */
public class Main {

    /**
     * The main method that reads an array of integers from the user, calculates the sum of its elements,
     * prints each element, sorts the array, and finds the median.
     * @param args command line arguments
     */
    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt(); // read the number of elements in the array
            int[] a = new int[n]; // create an array to store the elements
            for(int a_i=0; a_i < n; a_i++){ // read the elements of the array
                a[a_i] = in.nextInt();
            }
        }
    }

    /**
     * Calculates the sum of the elements in the given array.
     * @param a the array of integers
     */
    public void calculate(int[] a) {
        int sum = 0; // initialize the sum variable
        for (int i = 0; i < a.length; i++) { // iterate over the array
            sum += a[i]; // add the current element to the sum
        }
        System.out.println(sum); // print the sum
    }

    /**
     * Prints each element of the given array.
     * @param a the array of integers
     */
    public void print(int[] a) {
        for (int i = 0; i < a.length; i++) { // iterate over the array
            System.out.println(a[i]); // print the current element
        }
    }

    /**
     * Sorts the given array in ascending order and finds the median.
     * @param a the array of integers
     */
    public void sort(int[] a) {
        Arrays.sort(a); // sort the array in ascending order
        double median; // declare the median variable
        if (a.length % 2 == 0) { // check if the length of the array is even
            median = (a[a.length / 2 - 1] + a[a.length / 2]) / 2.0; // calculate the median as the average of the two middle elements
        } else {
            median = a[a.length / 2]; // calculate the median as the middle element
        }
    }
}
```

## Code Review and Scoring

Granite 3 Model offers automated code reviews that assess the quality of your code against industry standards. It provides scoring mechanisms that highlight areas of strength and identify potential issues, allowing developers to maintain high-quality codebases. This automated review process accelerates the feedback loop, enabling developers to make timely improvements and adhere to best practices without the need for extensive manual code inspections.

prompt for review and score

```python
prompt = f"""<|user|>
you are {language} expert. you need to review the following {language} code. 
-please understand the {language} code provided in detail.
-please review the code in completeness, logic, performance and quality.
-make it more object oriented.
-give a score out of 10 for the quality of code.
-please provide constructive suggestion in detail.
-generate the review and suggestion only.
{language} code: `{sample_code}`
-DONT generate the improve code directly.
<|assistant|>
score and review:"""

suggestion = model.generate_text(prompt)
print(suggestion)
```

outcome for review and score

```
The provided Java code is a simple program that reads an array of integers from the user, calculates the sum of its elements, prints each element on a new line, sorts the array, and then calculates and prints the median value. The code is functional and follows basic Java syntax and conventions. However, there are several areas where the code could be improved in terms of object orientation, readability, and maintainability.

Here's a breakdown of the code:

1. The `Main` class contains the `main` method, which is the entry point of the program. It reads an integer `n` from the user, creates an array of integers `a` of size `n`, and then calls the `calculate`, `print`, and `sort` methods on this array.
2. The `calculate` method calculates the sum of all elements in the array and prints it.
3. The `print` method prints each element of the array on a new line.
4. The `sort` method sorts the array using the `Arrays.sort()` method and then calculates and prints the median value. If the array has an even number of elements, the median is the average of the two middle elements. Otherwise, it's the middle element.

Improvements:

1. Object Orientation: The code could be made more object-oriented by creating a separate class for the array operations. This class could have methods for calculating the sum, printing the elements, sorting the array, and calculating the median. This would make the code more modular and easier to maintain.
2. Readability: The code could be made more readable by adding comments to explain what each method does and by using more descriptive variable names. For example, instead of `a`, the array could be named `numbers`.
3. Performance: The `sort` method currently sorts the entire array, even though it only needs to find the median. A more efficient approach would be to use a selection algorithm to find the median without sorting the entire array.
4. Error Handling: The code currently doesn't handle any errors that might occur when reading the input or when the array is empty. Adding error handling code would make the program more robust.

Overall, I would give this code a score of 6 out of 10 for quality. While it's functional and follows basic Java syntax and conventions, there are several areas where it could be improved in terms of object orientation, readability, performance, and error handling.
```

## Enhancement Based on Reviews

Leveraging the feedback from automated code reviews, the Granite 3 Model facilitates continuous improvement of your codebase. It suggests specific enhancements to optimize performance, improve maintainability, and increase readability. By acting on these insights, developers can refine their code systematically, ensuring that the software remains robust and efficient as it evolves.

Prompt for improvement

```python
prompt = f"""<|user|>
improve the {language} provided base on the review provided.
-understand the review suggestion in detail.
-adopt the review suggestion if applicable.
###
original {language} code: `{sample_code}`
review suggestion: `{suggestion}`
<|assistant|>
improved {language}
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for improvement

```java
import java.util.*;

public class ArrayOperations {

    private int[] numbers;

    public ArrayOperations(int[] numbers) {
        this.numbers = numbers;
    }

    public double calculateSum() {
        int sum = 0;
        for (int number : numbers) {
            sum += number;
        }
        return sum;
    }

    public void printNumbers() {
        for (int number : numbers) {
            System.out.println(number);
        }
    }

    public void sortNumbers() {
        Arrays.sort(numbers);
    }

    public double calculateMedian() {
        int size = numbers.length;
        if (size % 2 == 0) {
            return (numbers[size / 2 - 1] + numbers[size / 2]) / 2.0;
        } else {
            return numbers[size / 2];
        }
    }
}

public class Main {

    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt();
            if (n <= 0) {
                System.out.println("Error: Number of elements must be positive.");
                return;
            }
            int[] numbers = new int[n];
            for(int i = 0; i < n; i++){
                numbers[i] = in.nextInt();
            }
            ArrayOperations arrayOperations = new ArrayOperations(numbers);
            System.out.println("Sum: " + arrayOperations.calculateSum());
            arrayOperations.printNumbers();
            arrayOperations.sortNumbers();
            System.out.println("Median: " + arrayOperations.calculateMedian());
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}
```

## Error Identification and Fixing

The Granite 3 Model excels at identifying and rectifying errors in your code. It efficiently locates potential syntax errors andlogical flaws. By analyzing the code, it proposes fixes and improvements, offering developers an initial draft to consider. This feature streamlines the debugging process, enabling developers to focus on verification and testing, ensuring robust code.

Problem Code

```java
import java.util.*;

public class Main {

    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt();
    }

    public void calculate(int[] a) {
        int sum = 0;
        for (int i = 0; 
        }
        System.out.println(sum);
    }

    public void print(int[] a) {
        for (int i = 0; System.out.println(a[i]);
        }
    }

    public void sort(int[] a) {
        Arrays.sort(a);
        double me
        if (a.length % 2 == 0) {
           th / 2 - 1] + a[a.length / 2]) / 2.0;
        } else {
            median = a[a.len
        }
    }
}
```

Prompt for Fixing

```python
prompt = f"""<|user|>
fix the {language} provided.
-understand the review suggestion in detail.
-identify if any problem.
-fix the problem if any.
-add explanation as inline comment.

###
{language}: `{bad_code}`
<|assistant|>
fixed version with inline comment at the point it fix.
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Fixing

```java
import java.util.*;

public class Main {

    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt();
            int[] a = new int[n];
            for (int i = 0; i < n; i++) {
                a[i] = in.nextInt();
            }
            sort(a);
            calculate(a);
            print(a);
        }
    }

    public void calculate(int[] a) {
        int sum = 0;
        for (int i = 0; i < a.length; i++) { // fixed: loop condition
            sum += a[i];
        }
        System.out.println(sum);
    }

    public void print(int[] a) {
        for (int i = 0; i < a.length; i++) { // fixed: loop condition
            System.out.println(a[i]);
        }
    }

    public void sort(int[] a) {
        Arrays.sort(a);
        double median;
        if (a.length % 2 == 0) { // fixed: corrected condition
            median = (a[a.length / 2 - 1] + a[a.length / 2]) / 2.0;
        } else {
            median = a[a.length / 2]; // fixed: corrected index
        }
    }
}
```

## Diagram Generation

Understanding complex code structures is made easier with Granite 3 Model's diagram generation capabilities. It automatically creates visual representations of your code architecture, including class diagrams and flowcharts. These diagrams enhance comprehension and improve communication on projects with intricate dependencies.

Prompt for Generate Diagram

```python
prompt = f"""<|user|>
generate diagram for the {language} code provided.
-understand the review suggestion in detail.
-use simple name for node.
-generate in mermaid.
-dont repeating.
{language}: `{sample_code}`
<|assistant|>
```mermaid"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Generate Diagram

```mermaid
graph TD
    A[Main] --> B[main]
    B --> C[try-with-resources]
    C --> D[Scanner in]
    D --> E[nextInt]
    E --> F[n]
    F --> G[new int[n]]
    G --> H[calculate]
    H --> I[sum]
    I --> J[for loop]
    J --> K[a[i]]
    K --> L[sum += a[i]]
    M[print] --> N[for loop]
    N --> O[a[i]]
    P[sort] --> Q[Arrays.sort]
    Q --> R[if-else]
    R --> S[a.length % 2 == 0]
    S --> T[median = (a[a.length / 2 - 1] + a[a.length / 2]) / 2.0]
    U[else] --> V[median = a[a.length / 2]]
```

## Code Conversion

Granite 3 Model seamlessly converts code between different programming languages or formats, enhancing compatibility and facilitating cross-platform development. Whether migrating legacy systems to modern languages or adapting code for different environments, this feature ensures that the transition is smooth and error-free. It can supports a wide range of languages, making it a versatile tool for diverse development needs.

Prompt for conversion

```python
target_language = "python"

prompt = f"""<|user|>
rewrite the {language} code provided to {target_language}.
-understand the code provided in detail.
-understand how to map technology and syntax to the target {target_language} langauge.
{language}: `{sample_code}`
<|assistant|>
```{target_language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for conversion

```python
import array as arr

def main():
    n = int(input())
    a = arr.array('i', [0] * n)
    for i in range(n):
        a[i] = int(input())
    calculate(a)
    sort(a)
    print(median(a))

def calculate(a):
    sum = 0
    for i in range(len(a)):
        sum += a[i]
    print(sum)

def sort(a):
    a.sort()
    if len(a) % 2 == 0:
        median = (a[len(a) // 2 - 1] + a[len(a) // 2]) / 2.0
    else:
        median = a[len(a) // 2]
    print(median)

def median(a):
    return sort(a)[len(a) // 2]

if __name__ == "__main__":
    main()
```

## API Generation

Automating the creation of APIs, Granite 3 Model accelerates the integration of your codebase with external systems. It generates well-structured and documented APIs based on your existing code, facilitating seamless communication and data exchange between different software components. This feature is particularly beneficial for developing scalable and interoperable applications that require robust API interfaces.

Prompt for API Generation

```python
prompt = f"""<|user|>
generate a API definition in swagger for the {language} code provided.
{language}: `{sample_code}`
<|assistant|>
```yaml
"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for API Generation

```yaml
openapi: 3.0.0
info:
  title: Java Code API
  version: 1.0.0
servers:
  - url: http://api.example.com/java-code
paths:
  /calculate:
    post:
      summary: Calculate the sum of an array
      requestBody:
        content:
          application/json:
            schema:
              type: array
              items:
                type: integer
        required: true
      responses:
        '200':
          description: The sum of the array
          content:
            application/json:
              schema:
                type: number
  /print:
    post:
      summary: Print the elements of an array
      requestBody:
        content:
          application/json:
            schema:
              type: array
              items:
                type: integer
        required: true
      responses:
        '200':
          description: The elements of the array printed to the console
  /sort:
    post:
      summary: Sort an array and return the median
      requestBody:
        content:
          application/json:
            schema:
              type: array
              items:
                type: integer
        required: true
      responses:
        '200':
          description: The median of the sorted array
          content:
            application/json:
              schema:
                type: number
```

## Test Case Generation

Ensuring thorough testing is essential for reliable software development. Granite 3 Model automatically generates relevant test cases for your code, covering various scenarios and edge cases. This acceleration of the testing phase helps in identifying potential issues early, ensuring that the code performs as expected and meets the required quality standards before deployment.

Prompt for Test Case

```python
prompt = f"""<|user|>
generate Test Cases in {testframework} for the {language} code provided.
-focus on boundary cases.
-focus on exception handling
{language}: `{sample_code}`
<|assistant|>
```{language}"""

answer = model.generate_text(prompt).replace("```","")
print(answer)
```

Output for Test Case

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.Arrays;

class MainTest {

    @Test
    void testCalculate() {
        Main main = new Main();
        int[] a = {1, 2, 3, 4, 5};
        assertEquals(15, main.calculate(a));

        a = new int[]{Integer.MAX_VALUE, Integer.MIN_VALUE};
        assertEquals(-2147483647, main.calculate(a));

        a = new int[]{0};
        assertEquals(0, main.calculate(a));

        a = new int[]{};
        assertEquals(0, main.calculate(a));
    }

    @Test
    void testPrint() {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        PrintStream originalOut = System.out;
        System.setOut(new PrintStream(out));

        Main main = new Main();
        int[] a = {1, 2, 3, 4, 5};
        main.print(a);

        String output = out.toString();
        assertEquals("1\n2\n3\n4\n5", output);

        System.out.flush();
        System.setOut(originalOut);
    }

    @Test
    void testSort() {
        Main main = new Main();
        int[] a = {5, 3, 1, 4, 2};
        main.sort(a);
        assertArrayEquals(new int[]{1, 2, 3, 4, 5}, a);

        a = new int[]{Integer.MAX_VALUE, Integer.MIN_VALUE};
        main.sort(a);
        assertArrayEquals(new int[]{Integer.MIN_VALUE, Integer.MAX_VALUE}, a);

        a = new int[]{0};
        main.sort(a);
        assertArrayEquals(new int[]{0}, a);

        a = new int[]{};
        main.sort(a);
        assertArrayEquals(new int[], a);
    }
}
```
