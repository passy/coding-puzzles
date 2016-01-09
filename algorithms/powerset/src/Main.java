import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class Main {
    public static <T> List<List<T>> powerset(final List<T> l, final int i) {
        final List<List<T>> sets;
        if (l.size() == i) {
            sets = new ArrayList<>();
            sets.add(new ArrayList<T>());
        } else {
            sets = powerset(l, i + 1);
            final T item = l.get(i);
            final Collection<List<T>> more = new ArrayList<>();
            for (final List<T> s : sets) {
                final List<T> subset = new ArrayList<>();
                subset.addAll(s);
                subset.add(item);
                more.add(subset);
            }
            sets.addAll(more);
        }
        return sets;
    }

    public static <T> List<List<T>> powerset2(final List<T> l) {
        final List<List<T>> sets = new ArrayList<List<T>>();

        final int max = 1 << l.size();
        for (int j = 0; j < max; j += 1) {
            sets.add(intToSet(j, l));
        }

        return sets;
    }

    public static <T> List<T> intToSet(final int i, final List<T> s) {
        final List<T> subset = new ArrayList<>();
        int index = 0;
        for (int j = i; j > 0; j >>= 1) {
            if ((j & 1) == 1) {
                subset.add(s.get(index));
            }
            index += 1;
        }

        return subset;
    }

    public static void main(final String[] args) {
        final List<Integer> l = Arrays.asList(1, 2, 3);
        System.out.println(powerset(l, 0));
        System.out.println(powerset2(l));
    }
}
