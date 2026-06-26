interface PaymentStrategy {
    void pay(double amount);
}
class CreditCardPayment implements PaymentStrategy {
    public void pay(double amount) {
        System.out.println("Paid Rs." + amount + " using Credit Card.");
    }
}
class PayPalPayment implements PaymentStrategy {
    public void pay(double amount) {
        System.out.println("Paid Rs." + amount + " using PayPal.");
    }
}
class PaymentContext {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }
    public void executePayment(double amount) {
        paymentStrategy.pay(amount);
    }
}
public class Main {
    public static void main(String[] args) {
        PaymentContext payment = new PaymentContext();
        payment.setPaymentStrategy(new CreditCardPayment());
        payment.executePayment(2500);
        payment.setPaymentStrategy(new PayPalPayment());
        payment.executePayment(1800);
    }
}