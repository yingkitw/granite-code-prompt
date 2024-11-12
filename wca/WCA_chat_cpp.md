# WCA Chat Command Cookbook - C++

this repo target to share potential use case and prompt on granite-code models.

## prerequisite

- get an API KEY for watsonx Code Assistant

## tips

### tips for WCA

- new a chat session, it help to get clear context and better outcome.
- simple instruction works fine, hence make it simple
- the output is quite consistent

## sample c++

[good example](../sample/cpp/sample.cpp)

[bad example](../sample/cpp/bad.cpp)

## use cases

### 1. Code Explanation

- chat in WCA

```text
/explain @filename
```

- sample output

```markdown
This code is a C++ program that sorts a vector of Person objects by their age. The Person struct has two members: name and age. The compareByAge function is a custom comparison function that is used by the std::sort algorithm to sort the vector. The main function creates a vector of Person objects, sorts them using the std::sort algorithm, and then prints the sorted list of names and ages.
```

### 2. Generate Documentation

- chat input in WCA

```text
/document @filename
```

- sample output

```cpp
# Assisted by watsonx Code Assistant 
//blob
#include <iostream>
#include <vector>
#include <algorithm>
/**
 * @brief Struct to represent a person
 */
struct Person {
    /**
     * @brief Name of the person
     */
    std::string name;
    /**
     * @brief Age of the person
     */
    int age;
};
/**
 * @brief Function to compare two persons by age
 * @param a First person to compare
 * @param b Second person to compare
 * @return True if a is younger than b, false otherwise
 */
bool compareByAge(const Person& a, const Person& b) {
    return a.age < b.age;
}
int main() {
    /**
     * @brief Vector of Person objects
     */
    std::vector<Person> people = {
        {"Alice", 30},
        {"Bob", 25},
        {"Charlie", 35},
        {"Diana", 28},
        {"Eve", 40}
    };
    /**
     * @brief Sort the vector of persons by age
     */
    std::sort(people.begin(), people.end(), compareByAge);
    /**
     * @brief Print the sorted vector of persons
     */
    for (const auto& person : people) {
        std::cout << person.name << ": " << person.age << std::endl;
    }
    return 0;
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
using System.Collections.Generic;

struct Person {
    public string Name;
    public int Age;
}

class Program {
    static void Main() {
        List<Person> people = new List<Person> {
            new Person { Name = "Alice", Age = 30 },
            new Person { Name = "Bob", Age = 25 },
            new Person { Name = "Charlie", Age = 35 },
            new Person { Name = "Diana", Age = 28 },
            new Person { Name = "Eve", Age = 40 }
        };
        people.Sort((a, b) => a.Age.CompareTo(b.Age));
        foreach (var person in people) {
            Console.WriteLine($"{person.Name}: {person.Age}");
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

```cpp
// Assisted by watsonx Code Assistant 
#include <gtest/gtest.h>
#include <vector>
#include <algorithm>
#include "Person.h"

struct Person {
    std::string name;
    int age;
};

bool compareByAge(const Person& a, const Person& b) {
    return a.age < b.age;
}

TEST(CompareByAge, Ascending) {
    Person p1{"Alice", 30};
    Person p2{"Bob", 25};
    EXPECT_TRUE(compareByAge(p1, p2));
}

TEST(CompareByAge, Descending) {
    Person p1{"Alice", 30};
    Person p2{"Bob", 25};
    EXPECT_FALSE(compareByAge(p2, p1));
}

TEST(SortByAge, Ascending) {
    std::vector<Person> people = {
        {"Alice", 30},
        {"Bob", 25},
        {"Charlie", 35},
        {"Diana", 28},
        {"Eve", 40}
    };
    std::sort(people.begin(), people.end(), compareByAge);
    EXPECT_EQ(people[0].name, "Bob");
    EXPECT_EQ(people[1].name, "Diana");
    EXPECT_EQ(people[2].name, "Alice");
    EXPECT_EQ(people[3].name, "Charlie");
    EXPECT_EQ(people[4].name, "Eve");
}

TEST(SortByAge, Descending) {
    std::vector<Person> people = {
        {"Alice", 30},
        {"Bob", 25},
        {"Charlie", 35},
        {"Diana", 28},
        {"Eve", 40}
    };
    std::sort(people.begin(), people.end(), [&](const Person& a, const Person& b) {
        return a.age > b.age;
    });
    EXPECT_EQ(people[0].name, "Eve");
    EXPECT_EQ(people[1].name, "Charlie");
    EXPECT_EQ(people[2].name, "Alice");
    EXPECT_EQ(people[3].name, "Diana");
    EXPECT_EQ(people[4].name, "Bob");
}
```

### 5. Review Code

- chat input in WCA

```text
review @filename
```

- sample output

```text
The code is a C++ program that defines a struct Person with two members: name and age. It also includes a function compareByAge that compares two Person objects based on their age. The main function creates a vector of Person objects, sorts them using the compareByAge function, and then prints the sorted list of names and ages.

The code uses the standard library <iostream>, <vector>, and <algorithm> headers. It defines a Person struct with two members: name of type std::string and age of type int. The compareByAge function takes two Person objects as arguments and returns true if the first object's age is less than the second object's age, and false otherwise.

In the main function, a vector of Person objects is created and initialized with five people. The std::sort function is then used to sort the vector based on the compareByAge function. Finally, a loop is used to iterate over the sorted vector and print the name and age of each person.

Overall, the code is a simple example of how to use C++ to define a struct, create a vector of objects, sort the vector based on a custom comparison function, and print the sorted results.
```

### 6. Fix Code

- chat in WCA

```text
fix @filename
```

- sample output


```cpp
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//blob
#include <iostream>
#include <vector>
struct Person {
    std::string name;
    int age;
};
bool compareByAge(const Person& a, const Person& b) {
    return a.age < b.age;
}
int main() {
    std::vector<Person> people = {
        {"Alice", 30},
        {"Bob", 25},
        {"Charlie", 35},
        {"Diana", 28},
        {"Eve", 40}
    };
    std::sort(people.begin(), people.end(), compareByAge);
    for (const auto& person : people) {
        std::cout << person.name << ": " << person.age << std::endl;
    }
    return 0;
}
```

### 7. Generate Diagram

- chat in WCA

```text
generate mermaid diagram for the c++ code provided. @filename
```

- sample output

```mermaid
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
classDiagram
direction TB
class Person{
    +string name
    +int age
}
class main{
    +vector<Person> people
    +sort(people.begin(),people.end(),compareByAge)
    +for(const auto& person:people)
}
class compareByAge{
    +bool operator()(const Person& a,const Person& b)
}
```



### 8. Interface Generation

- chat in WCA

```text
generate c++ interface version base on the c++ code provided. @filename
```

```cpp
// Assisted by watsonx Code Assistant 
#include <iostream>
#include <vector>
#include <algorithm>
struct Person {
    std::string name;
    int age;
};
bool compareByAge(const Person& a, const Person& b) {
    return a.age < b.age;
}
extern "C" {
    void sortPeopleByAge(Person* people, int numPeople) {
        std::vector<Person> peopleVector(people, people + numPeople);
        std::sort(peopleVector.begin(), peopleVector.end(), compareByAge);
        for (const auto& person : peopleVector) {
            std::cout << person.name << ": " << person.age << std::endl;
        }
    }
}
int main() {
    Person people[] = {
        {"Alice", 30},
        {"Bob", 25},
        {"Charlie", 35},
        {"Diana", 28},
        {"Eve", 40}
    };
    int numPeople = sizeof(people) / sizeof(people[0]);
    sortPeopleByAge(people, numPeople);
    return 0;
}
```

### 9. Build and Deployment Scipt Generation

- chat in WCA

```text
generate build and deployment script for @filename
```

- sample output

```bash
# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
#!/bin/bash
# Build and deploy the sample C++ program
# Assuming the program is named sample.cpp

# Compile the program
g++ -o sample sample.cpp

# Create a directory to store the executable
mkdir -p bin

# Move the executable to the bin directory
mv sample bin/

# Create a deployment script to copy the executable to a remote server
cat << EOF > deploy.sh
#!/bin/bash
# Deploy the sample C++ program to a remote server
# Assuming the remote server is named remote_server

# Copy the executable to the remote server
scp bin/sample remote_server:/home/remote_user/

# Execute the program on the remote server
ssh remote_user@remote_server ./sample
EOF

# Make the deployment script executable
chmod +x deploy.sh

# Move the deployment script to the bin directory
mv deploy.sh bin/

# Print the deployment script
cat bin/deploy.sh
```
