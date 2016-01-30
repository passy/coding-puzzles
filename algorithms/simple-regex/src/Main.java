public class Main {

    public static void main(String[] args) {
        assert matches("A.CD", "ABCD");
        assert !matches("A.BC", "ABC");
        assert !matches("A.BC", "ABCD");
//        assert matches("A.*BCD", "ABCD");
//        assert matches("A.*CD", "ABCD");
//        assert matches("A.*D", "ABCD");
//        assert !matches("A.*D", "BCD");
    }

    private static boolean matches(final String pattern, final String string) {
        for (int i = 0, j = 0; i < pattern.length(); i++) {
            final char p = pattern.charAt(i);

            if (p == '.') {
                j++;
            } else {
                char s = string.charAt(j++);

                if (s != p) return false;
            }
        }

        return true;
    }
}
