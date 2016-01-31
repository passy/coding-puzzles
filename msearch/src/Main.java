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

        final List<int[]> entries = findEntryPoints(matrix, word.substring(1));
        final boolean[] visited = new boolean[matrix.length * matrix[0].length];

        boolean found = false;
        for (final int[] entry : entries) {
            if (walkWord(matrix, word, entry, visited)) {
                found = true;
                break;
            }
        }

        System.out.println("Found? " + found);
    }

    private static boolean walkWord(final char[][] matrix, final String word, final int[] entry, final boolean[] visited) {
        if (word.isEmpty()) return true;
        visited[matrix.length * entry[0] + entry[1]] = true;
        boolean res = directionsFrom(entry)
                .stream()
                .filter(coord -> isValid(matrix, coord))
                .filter(coord -> !visited[matrix.length * coord[0] + coord[1]])
                .filter(coord -> matrix[coord[0]][coord[1]] == word.charAt(0))
                .map(coord -> walkWord(matrix, word.substring(1), coord, visited))
                .anyMatch(a -> a);

        System.out.printf("w: %s, e: %s, r: %s\n", word, Arrays.toString(entry), res);
        return res;
    }

    private static boolean isValid(final char[][] matrix, final int[] coord) {
        final int n = matrix.length;
        final int m = matrix[0].length;

        return coord[0] >= 0 && coord[0] < n &&
                coord[1] >= 0 && coord[1] < m;
    }

    private static List<int[]> directionsFrom(final int[] entry) {
        return Arrays.asList(
                new int[] { entry[0] - 1, entry[1] },
                new int[] { entry[0], entry[1] - 1 },
                new int[] { entry[0] + 1, entry[1] },
                new int[] { entry[0], entry[1] + 1 }
        );
    }

    private static List<int[]> findEntryPoints(final char[][] matrix, final String word) {
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
