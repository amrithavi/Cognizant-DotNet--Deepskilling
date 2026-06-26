interface Doctypes {
    void getType();
}
class Worddoc implements Doctypes {
    public void getType() {
        System.out.println("Word Document");
    }
}
class Pdfdoc implements Doctypes {
    public void getType() {
        System.out.println("PDF Document");
    }
}
class Exceldoc implements Doctypes {
    public void getType() {
        System.out.println("Excel Document");
    }
}
class DocumentFactory {
    public static Doctypes createDocument(String type) {

        if (type.equalsIgnoreCase("Word Document")) {
            return new Worddoc();
        }
        else if (type.equalsIgnoreCase("PDF Document")) {
            return new Pdfdoc();
        }
        else if (type.equalsIgnoreCase("Excel Document")) {
            return new Exceldoc();
        }
        return null;
    }
}
public class Main {
    public static void main(String[] args) {
        Doctypes d1 =
            DocumentFactory.createDocument("Word Document");
        d1.getType();
    }
}