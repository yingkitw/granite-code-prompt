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