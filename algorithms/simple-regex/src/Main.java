public class Main {

    public static void main(String[] args) {
        assert matches("A.CD", "ABCD");
        assert !matches("A.BC", "ABC");
        assert !matches("A.BC", "ABCD");
        assert matches("A*BCD", "ABCD");
        assert matches("A*BCD", "BCD");
        assert matches("A*BCD", "AAAABCD");
        assert matches("A.*BCD", "ABCD");
        assert matches("A.*CD", "ABCD");
        assert matches("A.*D", "ABCD");
        assert !matches("A.*D", "BCD");
    }

    private static boolean matches(final String pattern, final String string) {
        if (pattern.isEmpty()) {
            return string.isEmpty();
        } else if (pattern.length() == 1 || pattern.charAt(1) != '*') {
            if (string.isEmpty()) {
                return false;
            }

            if (pattern.charAt(0) != '.' && pattern.charAt(0) != string.charAt(0)) {
                return false;
            }

            return matches(pattern.substring(1), string.substring(1));
        } else {
            if (matches(pattern.substring(2), string)) {
                return true;
            }

            for (int i = 0;
                 i < string.length() &&
                    (pattern.charAt(0) == '.' || string.charAt(i) == pattern.charAt(0));
                 i++) {
                if (matches(pattern.substring(2), string.substring(i + 1))) {
                    return true;
                }
            }
        }
        return false;
    }
}
