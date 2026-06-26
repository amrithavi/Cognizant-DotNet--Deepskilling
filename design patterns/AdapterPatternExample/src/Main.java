interface PaymentProcessor {
    void processPayment(double amount);
}
class PayPalGateway {
    public void makePayment(double amount) {
        System.out.println("Payment of Rs." + amount + " processed using PayPal.");
    }
}
class StripeGateway {
    public void payAmount(double amount) {
        System.out.println("Payment of Rs." + amount + " processed using Stripe.");
    }
}
class RazorpayGateway {
    public void sendPayment(double amount) {
        System.out.println("Payment of Rs." + amount + " processed using Razorpay.");
    }
}
class PayPalAdapter implements PaymentProcessor {
    private PayPalGateway paypal;
    public PayPalAdapter(PayPalGateway paypal) {
        this.paypal = paypal;
    }
    @Override
    public void processPayment(double amount) {
        paypal.makePayment(amount);
    }
}
class StripeAdapter implements PaymentProcessor {
    private StripeGateway stripe;
    public StripeAdapter(StripeGateway stripe) {
        this.stripe = stripe;
    }
    @Override
    public void processPayment(double amount) {
        stripe.payAmount(amount);
    }
}
class RazorpayAdapter implements PaymentProcessor {
    private RazorpayGateway razorpay;
    public RazorpayAdapter(RazorpayGateway razorpay) {
        this.razorpay = razorpay;
    }
    @Override
    public void processPayment(double amount) {
        razorpay.sendPayment(amount);
    }
}
public class Main {
    public static void main(String[] args) {
        PaymentProcessor paypal=new PayPalAdapter(new PayPalGateway());
        PaymentProcessor stripe=new StripeAdapter(new StripeGateway());
        PaymentProcessor razorpay=new RazorpayAdapter(new RazorpayGateway());
        paypal.processPayment(2500);
        stripe.processPayment(1800);
        razorpay.processPayment(3200);
    }
}