# WCA Chat Command Cookbook - Java

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

- you can leverage the [sample code provided](/samples/java/)

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent

## sample java

[good example](../sample/java/sample.java)

[bad example](../sample/java/bad.java)

## use cases

### 1. Code Explanation

- chat in WCA

```text
/explain @filename
```

- sample output

```markdown
Sure, I'd be happy to explain the code!

This code is a Java program that reads an integer n from the user and then reads n integers into an array a. It then calculates the sum of the elements in the array, prints the elements in the array, and sorts the array.

The Scanner class is used to read input from the user. The nextInt() method reads an integer from the user and returns it as a int value.

The calculate() method calculates the sum of the elements in the array and prints it to the console.

The print() method prints each element of the array on a new line.

The sort() method sorts the array in ascending order and calculates the median of the array.

The Arrays.sort() method sorts the array in place. If the array contains an even number of elements, the median is calculated as the average of the two middle elements. Otherwise, it is simply the middle element.

Overall, this code demonstrates how to read input from the user, perform basic array operations, and sort an array in Java.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @filename
```

- sample output

```java
// Assisted by watsonx Code Assistant 
/**
 * This is a sample class to illustrate how to write javadoc comments for methods and parameters.
 */
public class sample {
    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt();
            int[] a = new int[n];
            for(int a_i=0; a_i < n; a_i++){
                a[a_i] = in.nextInt();
            }
        }
    }
    /**
     * This method calculates the sum of all the elements in an array.
     * @param a an array of integers
     * @return the sum of all the elements in the array
     */
    public void calculate(int[] a) {
        int sum = 0;
        for (int i = 0; i < a.length; i++) {
            sum += a[i];
        }
        System.out.println(sum);
    }
    /**
     * This method prints all the elements of an array on a new line.
     * @param a an array of integers
     */
    public void print(int[] a) {
        for (int i = 0; i < a.length; i++) {
            System.out.println(a[i]);
        }
    }
    /**
     * This method sorts the elements of an array in ascending order.
     * @param a an array of integers
     */
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

### 3. Code Translate

- chat in WCA

```text
/translate to csharp @filename
```

- sample output

```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
using System;

namespace Sample
{
    public class Program
    {
        public static void Main(string[] args)
        {
            int n = int.Parse(Console.ReadLine());
            int[] a = new int[n];
            for (int i = 0; i < n; i++)
            {
                a[i] = int.Parse(Console.ReadLine());
            }
        }

        public void Calculate(int[] a)
        {
            int sum = 0;
            for (int i = 0; i < a.Length; i++)
            {
                sum += a[i];
            }
            Console.WriteLine(sum);
        }

        public void Print(int[] a)
        {
            for (int i = 0; i < a.Length; i++)
            {
                Console.WriteLine(a[i]);
            }
        }

        public void Sort(int[] a)
        {
            Array.Sort(a);
            double median;
            if (a.Length % 2 == 0)
            {
                median = (a[a.Length / 2 - 1] + a[a.Length / 2]) / 2.0;
            }
            else
            {
                median = a[a.Length / 2];
            }
        }
    }
}
```


### 4. Test Case Generation

- chat in WCA

```text
/unit-test @filename
```

- sample output

```java
// Assisted by watsonx Code Assistant 
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class SampleTest {
    @Test
    void calculateTest() {
        int[] a = {1, 2, 3, 4, 5};
        Sample sample = new Sample();
        int sum = sample.calculate(a);
        assertEquals(15, sum);
    }

    @Test
    void printTest() {
        int[] a = {1, 2, 3, 4, 5};
        Sample sample = new Sample();
        String result = "";
        try (java.io.ByteArrayOutputStream out = new java.io.ByteArrayOutputStream();
             java.io.PrintStream printStream = new java.io.PrintStream(out)) {
            System.setOut(printStream);
            sample.print(a);
            result = out.toString().trim();
        } catch (Exception e) {
            e.printStackTrace();
        }
        assertEquals("1\n2\n3\n4\n5", result);
    }

    @Test
    void sortTest() {
        int[] a = {5, 2, 4, 1, 3};
        Sample sample = new Sample();
        sample.sort(a);
        assertEquals(2, a[0]);
        assertEquals(3, a[1]);
        assertEquals(4, a[2]);
        assertEquals(5, a[3]);
        assertEquals(1, a[4]);
    }
}
```

### 2. Review Code

- chat input in WCA

```text
Review the code @filename
```

- sample output

```text
Sure, I've reviewed the code sample.java and found the following issues:

The code does not declare the Scanner object as final, which may cause issues if the Scanner object is modified later in the code.
The code may throw a NoSuchElementException if the user enters an invalid input. You can add code to handle this exception to ensure that the program does not crash.
The code does not close the Scanner object, which may cause issues if the program terminates abnormally. You can add code to close the Scanner object in a finally block to ensure that it is closed properly.
The code may not handle the case where the user enters a negative value for n. You can add code to handle this case by checking if n is less than or equal to zero, and if so, printing an error message and exiting the program.
The code does not initialize the elements of the array a to zero. You can add code to initialize the elements of the array to zero to avoid possible issues with uninitialized values.
```

### 6. Fix Code

- chat in WCA

```text
/fix @filename
```

- sample output


```java
// Assisted by watsonx Code Assistant 
import java.util.*;

public class sample {
    public static void main(String[] args) {
        try (Scanner in = new Scanner(System.in)) {
            int n = in.nextInt();
            int[] a = new int[n];
            for (int a_i = 0; a_i < n; a_i++) {
                a[a_i] = in.nextInt();
            }
            sample s = new sample();
            s.calculate(a);
            s.print(a);
            s.sort(a);
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
        System.out.println(median);
    }
}
```

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid diagram for the java code provided. @filename
```

- sample output

```mermaid
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
classDiagram
class sample{
    -int[] a
    +sample()
    +calculate(int[]) void
    +print(int[]) void
    +sort(int[]) void
}
```

### 8. Interface Generation

- chat in WCA

```text
generate java interface version base on the java code provided. @filename
```

```java
// Assisted by watsonx Code Assistant 
//interface
public interface Sample {
    public void calculate(int[] a);
    public void print(int[] a);
    public void sort(int[] a);
}
```

### 9. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment (openshift and liberty) script for the java code provided. @filename
```

- sample output

```bash
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//blob
#!/bin/bash

# Build the Java code
mvn package

# Create a new OpenShift project
oc new-project my-project

# Create a new Liberty application
oc new-app openliberty/open-liberty:latest -e LICENSE=accept -e JBP_CONFIG_LIBERTY_VERSION=21.0.0.3-kernel-java8-openj9-1.0.0

# Copy the Java code into the Liberty application
oc cp sample.java my-project-1234567890abcde/src/main/java/

# Trigger a new build of the Liberty application
oc start-build my-project-1234567890abcde --from-dir=.

# Wait for the build to complete
while [[ "$(oc get builds -o jsonpath='{ .items[*].status.phase }' | grep -c Running)" -gt 0 ]]; do
    echo "Build is running..."
    sleep 10
done

# Deploy the Liberty application
oc deploy my-project-1234567890abcde --latest

# Wait for the deployment to complete
while [[ "$(oc get deploymentconfigs -o jsonpath='{ .items[*].status.availableReplicas }' | grep -c 0)" -gt 0 ]]; do
    echo "Deployment is in progress..."
    sleep 10
done

# Expose the Liberty application
oc expose svc/my-project-1234567890abcde

# Get the URL of the Liberty application
URL=$(oc get route my-project-1234567890abcde -o jsonpath='{ .spec.host }')

# Test the Liberty application
curl $URL/sample/calculate
curl $URL/sample/print
curl $URL/sample/sort
```
