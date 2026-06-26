interface Notifier {
    void send(String message);
}
class EmailNotifier implements Notifier {
    @Override
    public void send(String message) {
        System.out.println("Sending Email: " + message);
    }
}
abstract class NotifierDecorator implements Notifier {
    protected Notifier notifier;
    public NotifierDecorator(Notifier notifier) {
        this.notifier = notifier;
    }
    @Override
    public void send(String message) {
        notifier.send(message);
    }
}
class SMSNotifierDecorator extends NotifierDecorator {
    public SMSNotifierDecorator(Notifier notifier) {
        super(notifier);
    }
    @Override
    public void send(String message) {
        super.send(message);
        System.out.println("Sending SMS: " + message);
    }
}
class SlackNotifierDecorator extends NotifierDecorator {

    public SlackNotifierDecorator(Notifier notifier) {
        super(notifier);
    }
    @Override
    public void send(String message) {
        super.send(message);
        System.out.println("Sending Slack Notification: " + message);
    }
}
public class Main {
    public static void main(String[] args) {
        Notifier email = new EmailNotifier();
        email.send("Meeting at 10 AM");
        Notifier emailSMS =
                new SMSNotifierDecorator(new EmailNotifier());
        emailSMS.send("Project deadline tomorrow");
        Notifier allNotifications =
                new SlackNotifierDecorator(
                        new SMSNotifierDecorator(
                                new EmailNotifier()));
        allNotifications.send("Server maintenance tonight");
    }
}