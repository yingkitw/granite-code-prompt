# WCA Chat Command Cookbook - Python

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

- you can leverage the [sample code provided](../sample/python/)

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent

## sample python

[good example](../sample/python/sample.py)

[bad example](../sample/python/bad.py)

## use cases

### 1. Code Generation

- create a empty file of `filename`.py

- chat in WCA

```text
generate a python program of bubblesort
```

- copy and paste the outcome to the file you just create.

- try to chat to update the code you just generate until you found it good.

- run the code

```bash
python `filename`.py
```

- check if running well.

### 1. Code Completion

- edit some code, and experience the code completion and accept it with `tab` key.


### 3. Code Explanation

- chat in WCA

```text
/explain @filename
```

- sample output

```markdown
This code defines a class ComplexObject with two attributes name and value. It also defines two functions generate_complex_object and perform_complex_operation. The main function generates two ComplexObject instances, performs a complex operation on them, and prints the results.

The generate_complex_object function takes two arguments name and value and returns a new ComplexObject instance with the given values.

The perform_complex_operation function takes two ComplexObject instances as arguments and returns the object with the greater value.

The main function generates two ComplexObject instances, obj1 and obj2, with random values between 1 and 100. It then prints the values of obj1 and obj2. Finally, it calls the perform_complex_operation function with obj1 and obj2 as arguments and prints the result.
```

### 4. Generate Documentation

- chat input in WCA

```text
/document @filename
```

- sample output

```python
# Assisted by watsonx Code Assistant 
#blob
import random
class ComplexObject:
    """
    A class to represent a complex object with a name and value.

    Attributes:
        name (str): The name of the object.
        value (int): The value of the object.

    Methods:
        __init__(name, value): Initializes the object with a name and value.
        __str__(): Returns a string representation of the object.
    """
    def __init__(self, name, value):
        self.name = name
        self.value = value
    def __str__(self):
        return f"Object: {self.name}, Value: {self.value}"
def generate_complex_object(name, value):
    """
    Generates a complex object with a given name and value.

    Args:
        name (str): The name of the object.
        value (int): The value of the object.

    Returns:
        ComplexObject: The generated complex object.
    """
    return ComplexObject(name, value)
def perform_complex_operation(obj1, obj2):
    """
    Performs a complex operation on two complex objects.

    Args:
        obj1 (ComplexObject): The first object.
        obj2 (ComplexObject): The second object.

    Returns:
        ComplexObject: The object with the highest value.
    """
    if obj1.value > obj2.value:
        return obj1
    else:
        return obj2
def main():
    obj1 = generate_complex_object("Object1", random.randint(1, 100))
    obj2 = generate_complex_object("Object2", random.randint(1, 100))
    print(f"Object1: {obj1}")
    print(f"Object2: {obj2}")
    result = perform_complex_operation(obj1, obj2)
    print(f"Result: {result}")
if __name__ == "__main__":
    main()
```

### 5. Code Translate

- chat in WCA

```text
/translate to csharp @filename
```

- sample output

```csharp
// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
using System;

namespace ComplexObjectExample
{
    public class ComplexObject
    {
        public string Name { get; set; }
        public int Value { get; set; }

        public ComplexObject(string name, int value)
        {
            Name = name;
            Value = value;
        }

        public override string ToString()
        {
            return $"Object: {Name}, Value: {Value}";
        }
    }

    public class Program
    {
        public static ComplexObject GenerateComplexObject(string name, int value)
        {
            return new ComplexObject(name, value);
        }

        public static ComplexObject PerformComplexOperation(ComplexObject obj1, ComplexObject obj2)
        {
            if (obj1.Value > obj2.Value)
            {
                return obj1;
            }
            else
            {
                return obj2;
            }
        }

        public static void Main()
        {
            ComplexObject obj1 = GenerateComplexObject("Object1", new Random().Next(1, 100));
            ComplexObject obj2 = GenerateComplexObject("Object2", new Random().Next(1, 100));

            Console.WriteLine($"Object1: {obj1}");
            Console.WriteLine($"Object2: {obj2}");

            ComplexObject result = PerformComplexOperation(obj1, obj2);

            Console.WriteLine($"Result: {result}");
        }
    }
}
```

### 6. Test Case Generation

- chat in WCA

```text
/unit-test @filename
```

- sample output

```python
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
import unittest
import random
from blob import ComplexObject, generate_complex_object, perform_complex_operation
class TestComplexObject(unittest.TestCase):
    def test_init(self):
        obj = ComplexObject("Object1", 10)
        self.assertEqual(obj.name, "Object1")
        self.assertEqual(obj.value, 10)
    def test_str(self):
        obj = ComplexObject("Object1", 10)
        self.assertEqual(str(obj), "Object: Object1, Value: 10")
class TestGenerateComplexObject(unittest.TestCase):
    def test_generate(self):
        name = "Object1"
        value = random.randint(1, 100)
        obj = generate_complex_object(name, value)
        self.assertEqual(obj.name, name)
        self.assertEqual(obj.value, value)
class TestPerformComplexOperation(unittest.TestCase):
    def test_greater(self):
        obj1 = ComplexObject("Object1", 10)
        obj2 = ComplexObject("Object2", 5)
        result = perform_complex_operation(obj1, obj2)
        self.assertEqual(result, obj1)
    def test_less(self):
        obj1 = ComplexObject("Object1", 5)
        obj2 = ComplexObject("Object2", 10)
        result = perform_complex_operation(obj1, obj2)
        self.assertEqual(result, obj2)
if __name__ == "__main__":
    unittest.main()

```

### 7. Review Code

- chat input in WCA

```text
review @filename
```

- sample output

```text
Here is a review of the sample.py file:

The file imports the random module and defines a class called ComplexObject. The class has two attributes, name and value, and a string representation method.

The file also defines two functions: generate_complex_object and perform_complex_operation. The generate_complex_object function takes two arguments, name and value, and returns a new ComplexObject instance. The perform_complex_operation function takes two ComplexObject instances as arguments and returns the object with the greater value.

The file contains a main function that generates two random ComplexObject instances, prints their string representations, and calls the perform_complex_operation function to determine which object has the greater value.

Overall, the sample.py file demonstrates the use of the ComplexObject class and the generate_complex_object and perform_complex_operation functions to create and manipulate objects with a name and value attribute.
```

### 8. Fix Code

- chat in WCA

```text
/fix @filename
```

- sample output


```python
# Assisted by watsonx Code Assistant 
import random
class ComplexObject:
    def __init__(self, name, value):
        self.name = name
        self.value = value
    def __str__(self):
        return f"Object: {self.name}, Value: {self.value}"
def generate_complex_object(name, value):
    return ComplexObject(name, value)
def perform_complex_operation(obj1, obj2):
    if obj1.value > obj2.value:
        return obj1
    else:
        return obj2
def main():
    obj1 = generate_complex_object("Object1", random.randint(1, 100))
    obj2 = generate_complex_object("Object2", random.randint(1, 100))
    print(f"Object1: {obj1}")
    print(f"Object2: {obj2}")
    result = perform_complex_operation(obj1, obj2)
    print(f"Result: {result}")
if __name__ == "__main__":
    main()
```

### 9. Generate Diagram

- chat in WCA

```text
generate mermaid diagram for the python code provided. @filename
```

- sample output

```mermaid

```

### 10. Interface Generation

- chat in WCA

```text
generate python interface version base on the python code provided. @filename
```

```python
```

### 11. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for the python code provided. @filename
```

- sample output

```bash
```
