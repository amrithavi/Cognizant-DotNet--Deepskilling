namespace CustomerCommLib
{
    public class CustomerComm
    {
        private readonly IMailSender _mailSender;

        // Dependency Injection via constructor
        // This allows us to inject a mock during testing
        // instead of hitting the real SMTP server
        public CustomerComm(IMailSender mailSender)
        {
            _mailSender = mailSender;
        }

        public bool SendMailToCustomer()
        {
            // Actual logic goes here
            // define message and mail address
            _mailSender.SendMail("cust123@abc.com", "Some Message");
            return true;
        }
    }
}
