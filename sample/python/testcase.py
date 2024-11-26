# Assisted by watsonx Code Assistant 
import unittest
from sample import ComplexObject, generate_complex_object, perform_complex_operation

class TestComplexObject(unittest.TestCase):
    def test_init(self):
        obj = ComplexObject("Object1", 10)
        self.assertEqual(obj.name, "Object1")
        self.assertEqual(obj.value, 10)

    def test_str(self):
        obj = ComplexObject("Object1", 10)
        self.assertEqual(str(obj), "Object: Object1, Value: 10")

class TestGenerateComplexObject(unittest.TestCase):
    def test_generate_complex_object(self):
        obj = generate_complex_object("Object1", 10)
        self.assertEqual(obj.name, "Object1")
        self.assertEqual(obj.value, 10)

class TestPerformComplexOperation(unittest.TestCase):
    def test_perform_complex_operation(self):
        obj1 = generate_complex_object("Object1", 10)
        obj2 = generate_complex_object("Object2", 5)
        result = perform_complex_operation(obj1, obj2)
        self.assertEqual(result.name, "Object1")
        self.assertEqual(result.value, 10)

if __name__ == "__main__":
    unittest.main()