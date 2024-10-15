# Granite Code Prompt Cookbook

this repo target to share potential use case and prompt on granite-code models.

## use cases

- get the  [WCA Chat](./WCA_chat.md) sample chat.
- get the  [watsonx.ai](./watsonxai_prompt.md) sample prompt.


|#|use case|WCA Chat|watsonx.ai prompt|
|-|-|-|-|
|1|Generate Documentation|+|+|
|2|Review and Scoring|+|+|
|3|Improve base on review||+|
|4|Fix code|+|+|
|5|Generate Diagram|+|+|
|6|Code Conversion|+|+|
|7|Style Improvement||+|
|8|API Generation|+|+|
|9|Test Case Generation|+|+|
|10|Interface Generation|+|+|
|11|Build and Deployment Scipt Generation|+|+|
|12|Code Completion||+|
|13|Code Explanation|+|+|
|14|Code Optimization||+|

## sample java

```java
import java.util.*;
import com.ibm.j9ddr.vm29.pointer.generated.processor_cpu_load_infoPointer;
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

## Sample Bad Java

```java
import java.util.*;
import com.ibm.j9ddr.vm29.pointer.generated.processor_cpu_load_infoPointer;
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