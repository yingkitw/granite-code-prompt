# Assisted by watsonx Code Assistant 
def calculate_compound_interest(principal, rate, time):
    # formula to calculate compound interest
    compound_interest = principal * (pow((1 + rate / 100), time)) - principal

    return compound_interest

def calculate_sum(a, b):
    # formula to calculate sum
    sum = a + b
    return sum

# input values
principal = 1000
rate = 5
time = 2

# calculate compound interest
compound_interest = calculate_compound_interest(principal, rate, time)

# calculate sum
sum = calculate_sum(10, 20)

# print the result
print("Compound interest is", compound_interest)
print("Sum is", sum)