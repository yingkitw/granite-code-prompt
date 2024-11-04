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