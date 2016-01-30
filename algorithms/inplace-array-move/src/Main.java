import java.util.Arrays;

public class Main {

    /**
     * Move zeroes in an array to the beginning of the array, while respecting the
     * order of other elements without extra space. Runs in O(n^2).
     *
     * I think there's an O(n) solution ...
     */
    public static void main(String[] args) {
        int[] input = new int[] { 0, 1, 2, 0, 3, 4, 0, 0, 5, 0 };

        System.out.println("Before: " + Arrays.toString(input));
        moveZeroes(input);
        System.out.println("After: " + Arrays.toString(input));
    }

    private static void moveZeroes(final int[] input) {
        int j = 0;
        for (int i = 0; i < input.length; i++) {
            if (input[i] == 0) {
                insert(input, i, j++);
            }
        }
    }

    private static void insert(final int[] input, final int from, final int to) {
        System.out.printf("Moving from %d to %d.\n", from, to);
        for (int i = from; i > to; i--) {
            final int tmp = input[i - 1];
            input[i - 1] = input[i];
            input[i] = tmp;
        }
        System.out.println("After iter: " + Arrays.toString(input));
    }
}
