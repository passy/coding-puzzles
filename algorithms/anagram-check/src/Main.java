public class Main {

    public static void main(String[] args) {
        final String a = "xzy";
        final String b = "abxuyz";

        assert hasAna("xyz", "abzcyx");
        assert !hasAna("xyz", "abcyx");
        assert hasAna("aaa", "ababa");
        assert !hasAna("aaa", "ababc");
    }

    private static boolean hasAna(final String a, final String b) {
        final int[] seen = new int[26];

        for (int i = 0; i < a.length(); i++) {
            seen[a.charAt(i) - 'a']++;
        }

        for (int i = 0; i < b.length(); i++) {
            int tmp = seen[b.charAt(i) - 'a'];
            seen[b.charAt(i) - 'a'] = Math.max(0, tmp - 1);
        }

        int sum = 0;
        for (int i = 0; i < seen.length; i++) {
            sum += seen[i];
        }

        return sum == 0;
    }
}
