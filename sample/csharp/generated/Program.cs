// Assisted by watsonx Code Assistant 
// watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
//Program.cs
namespace CompoundInterestCalculator
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the principal amount: ");
            double principal = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter the annual interest rate: ");
            double interestRate = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("Enter the number of years: ");
            int years = Convert.ToInt32(Console.ReadLine());

            double amount = principal * Math.Pow(1 + interestRate / 100, years);
            Console.WriteLine("The compound interest amount is: " + amount);

            Console.WriteLine("The sum of 1 and 2 is: " + Sum(1, 2));
        }

        static int Sum(int a, int b)
        {
            return a + b;
        }
    }
}
