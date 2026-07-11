using System;
using NUnit.Framework;
using CalcLibrary;

namespace CalcLibrary.Tests
{
    [TestFixture]
    public class CalculatorTests
    {
        private SimpleCalculator calculator;

        [SetUp]
        public void Setup()
        {
            calculator = new SimpleCalculator();
        }

        [TearDown]
        public void Cleanup()
        {
            // Cleanup after each test
        }

        //--------------------------------------------------
        // Subtraction Tests
        //--------------------------------------------------

        [TestCase(10, 5, 5)]
        [TestCase(20, 15, 5)]
        [TestCase(-5, -5, 0)]
        [TestCase(5, 10, -5)]
        public void TestSubtraction(double a, double b, double expected)
        {
            double actual = calculator.Subtraction(a, b);

            Assert.That(actual, Is.EqualTo(expected));
        }

        //--------------------------------------------------
        // Multiplication Tests
        //--------------------------------------------------

        [TestCase(5, 4, 20)]
        [TestCase(-2, 3, -6)]
        [TestCase(0, 100, 0)]
        [TestCase(-5, -5, 25)]
        public void TestMultiplication(double a, double b, double expected)
        {
            double actual = calculator.Multiplication(a, b);

            Assert.That(actual, Is.EqualTo(expected));
        }

        //--------------------------------------------------
        // Division Tests
        //--------------------------------------------------

        [TestCase(20, 5, 4)]
        [TestCase(9, 3, 3)]
        [TestCase(10, 2, 5)]
        [TestCase(25, 5, 5)]
        public void TestDivision(double a, double b, double expected)
        {
            double actual = calculator.Division(a, b);

            Assert.That(actual, Is.EqualTo(expected));
        }

        //--------------------------------------------------
        // Division by Zero Test
        //--------------------------------------------------

        [Test]
        public void TestDivisionByZero()
        {
            try
            {
                calculator.Division(10, 0);

                Assert.Fail("Division by zero");
            }
            catch (ArgumentException ex)
            {
                Assert.That(ex.Message, Is.EqualTo("Second Parameter Can't be Zero"));
            }
        }

        //--------------------------------------------------
        // Test Void Method (AllClear)
        //--------------------------------------------------

        [Test]
        public void TestAddAndClear()
        {
            calculator.Addition(10, 20);

            Assert.That(calculator.GetResult, Is.EqualTo(30));

            calculator.AllClear();

            Assert.That(calculator.GetResult, Is.EqualTo(0));
        }
    }
}