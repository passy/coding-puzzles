import java.util.*;

public class Main {
    public static class Node<T> {
        public final Pair<Node<T>> parents;
        public final T value;

        public Node(final T value) {
            this.value = value;
            this.parents = new Pair();
        }

        public Node<T> lca(final Node<T> them) {
            return null;
        }

        @Override
        public String toString() {
            return "Node{" +
                    "parents=" + parents +
                    ", value=" + value +
                    '}';
        }
    }

    public static class Iterables {
        public static <T> Collection<T> zip(Collection<T> a, Collection<T> b) {
            final int size = a.size() + b.size();
            final List<T> list = new ArrayList<>(size);
            final Iterator<T> ai = a.iterator();
            final Iterator<T> bi = b.iterator();
            for (int i = 0; i < size; i += 1) {
                if ((i % 2 == 0 && ai.hasNext()) || !bi.hasNext()) {
                    list.add(ai.next());
                } else {
                    list.add(bi.next());
                }
            }

            return list;
        }
    }

    public static class Pair<T> implements Iterable<T> {
        T fst;
        T snd;

        public Pair() {
        }

        public Pair(T fst, T snd) {
            this.fst = fst;
            this.snd = snd;
        }

        @Override
        public Iterator<T> iterator() {
            return toList().iterator();
        }

        public List<T> toList() {
            int size = 0;
            if (fst != null) size++;
            if (snd != null) size++;
            final List<T> list = new ArrayList<>(size);
            if (fst != null) list.add(fst);
            if (snd != null) list.add(snd);
            return list;
        }

        @Override
        public String toString() {
            return "Pair{" +
                    "fst=" + fst +
                    ", snd=" + snd +
                    '}';
        }
    }

    public static void main(String[] args) {
        final Node<String> father = new Node("F");
        final Node<String> me = new Node("Me");
        me.parents.fst = father;
        me.parents.snd = new Node("M0");

        final Node<String> them = new Node("Them");
        them.parents.fst = new Node("M1");
        them.parents.snd = father;

        final Node<String> lca = me.lca(them);
        System.out.println(lca);
    }
}
