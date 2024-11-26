import random

class ComplexObject:
    def __init__(self, name, value):
        self.Name = name
        self.Value = value

    def __str__(self):
        return f"Object: {self.Name}, Value: {self.Value}"

def GenerateComplexObject(name, value):
    return ComplexObject(name, value)

def PerformComplexOperation(obj1, obj2):
    if obj1.Value > obj2.Value:
        return obj1
    else:
        return obj2

obj1 = GenerateComplexObject("Object1", random.randint(1, 100))
obj2 = GenerateComplexObject("Object2", random.randint(1, 100))

print(f"Object1: {obj1}")
print(f"Object2: {obj2}")

result = PerformComplexOperation(obj1, obj2)

print(f"Result: {result}")