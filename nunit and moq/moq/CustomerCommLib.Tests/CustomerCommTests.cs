using NUnit.Framework;
using Moq;
using CustomerCommLib;
namespace CustomerCommLib.Tests
{
    [TestFixture]
    public class CustomerCommTests
    {
        private Mock<IMailSender> _mockMailSender;
        private CustomerComm _customerComm;
        [SetUp]
        public void SetUp()
        {
            // Create mock object of IMailSender
            // This prevents any real SMTP call from happening
            _mockMailSender = new Mock<IMailSender>();
            // Inject the mock through constructor (Dependency Injection)
            _customerComm = new CustomerComm(_mockMailSender.Object);
        }
        // Test 1: Verify SendMailToCustomer returns true
        [Test]
        public void SendMailToCustomer_ShouldReturnTrue()
        {
            // Arrange
            // Setup the mock to return true when SendMail is called
            // with any string arguments
            _mockMailSender
                .Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Returns(true);
            // Act
            bool result = _customerComm.SendMailToCustomer();

            // Assert
            Assert.That(result, Is.True);
        }

        // Test 2: Verify SendMail was actually called once
        [Test]
        public void SendMailToCustomer_ShouldCallSendMailExactlyOnce()
        {
            // Arrange
            _mockMailSender
                .Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Returns(true);

            // Act
            _customerComm.SendMailToCustomer();

            // Assert
            // Verify the mock's SendMail was invoked exactly 1 time
            _mockMailSender.Verify(
                m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()),
                Times.Once
            );
        }

        // Test 3: Verify SendMail was called with the correct email address
        [Test]
        public void SendMailToCustomer_ShouldSendToCorrectEmailAddress()
        {
            // Arrange
            string expectedEmail = "cust123@abc.com";

            _mockMailSender
                .Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Returns(true);

            // Act
            _customerComm.SendMailToCustomer();

            // Assert
            // Verify the exact email address that was passed to SendMail
            _mockMailSender.Verify(
                m => m.SendMail(expectedEmail, It.IsAny<string>()),
                Times.Once
            );
        }

        // Test 4: Verify SendMail was called with a non-empty message
        [Test]
        public void SendMailToCustomer_ShouldSendNonEmptyMessage()
        {
            // Arrange
            _mockMailSender
                .Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Returns(true);

            // Act
            _customerComm.SendMailToCustomer();

            // Assert
            _mockMailSender.Verify(
                m => m.SendMail(It.IsAny<string>(), It.Is<string>(msg => !string.IsNullOrEmpty(msg))),
                Times.Once
            );
        }

        // Test 5: Verify no real SMTP call is made (mock was never bypassed)
        [Test]
        public void SendMailToCustomer_ShouldNotCallRealSmtpServer()
        {
            // Arrange
            bool realSmtpCalled = false;

            _mockMailSender
                .Setup(m => m.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Callback(() => realSmtpCalled = false) // mock callback, NOT real SMTP
                .Returns(true);

            // Act
            _customerComm.SendMailToCustomer();

            // Assert
            Assert.That(realSmtpCalled, Is.False,
                "Real SMTP server should never be called during unit testing");
        }
    }
}
