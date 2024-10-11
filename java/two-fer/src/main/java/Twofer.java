public class Twofer {
    public String twofer(String name) {
        final String forUnknownName = "you";
        return "One for " +
                (name == null ? forUnknownName : name) +
                ", one for me.";
    }
}
