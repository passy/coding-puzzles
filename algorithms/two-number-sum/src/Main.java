import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        final List<Integer> input = Arrays.asList(3, 6, 4, 9);
        System.out.println(hasSum(input, 3));
    }

    private static boolean hasSum(final List<Integer> input, final int sum) {
        for (final Integer integer : input) {
            final Collection<Integer> copy = new ArrayList<>(input);
            copy.remove(integer);

            final int remaining = sum - integer;
            if (copy.contains(remaining)) {
                return true;
            }
        }

        return false;
    }
}
