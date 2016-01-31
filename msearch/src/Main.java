import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class Main {

    public static void main(String... args) {
        final String word = "rat";
        final char[][] matrix = {
                new char[] { 'v', 'r', 'a' },
                new char[] { 'x', 'a', 't' },
                new char[] { 'r', 'm', 'l' }
        };

        findEntries(matrix, word).stream()
                .forEach(ints -> System.out.println(Arrays.toString(ints)));
    }

    private static List<int[]> findEntries(final char[][] matrix, final String word) {
        final char fst = word.charAt(0);
        final List<int[]> res = new LinkedList<>();
        for (int i = 0; i < matrix.length; i++) {
            final char[] row = matrix[i];
            for (int j = 0; j < row.length; j++) {
                if (row[j] == fst) {
                   res.add(new int[] { i, j });
                }
            }
        }

        return res;
    }
}
