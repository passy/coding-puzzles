import java.util.*;

public class Main {

    static class Node<T> {
        T val;
        Optional<Node<T>> next;

        public Node(T val, Main.Node next) {
            this.val = val;
            this.next = Optional.<Node<T>>of(next);
        }

        public Node(T val) {
            this.val = val;
            this.next = Optional.empty();
        }

        @Override
        public String toString() {
            return "Node{" +
                    "val=" + val +
                    ", next=" + next +
                    '}';
        }
    }

    public static void main(String[] args) {
        final Node<Integer> node = new Node(1, new Node(2, new Node(3, new Node(4, new Node(5)))));

        System.out.println(node);
        printReverseRec(node);
        printReverseIter(node);

        System.out.println(reverseRec(Optional.of(node), new LinkedList<Integer>()));
        System.out.println(reverseIter(Optional.of(node), new LinkedList<Integer>()));
    }

    static <T> void printReverseRec(final Node<T> node) {
        if (node.next.isPresent()) {
            printReverseRec(node.next.get());
        }

        System.out.println(node.val);
    }

    static <T> void printReverseIter(final Node<T> node) {
        final Stack<T> ts = new Stack<>();

        Optional<Node<T>> cur = Optional.of(node);
        do {
            ts.push(cur.get().val);
            cur = cur.get().next;
        } while (cur.isPresent());

        while (!ts.empty()) {
            System.out.println(ts.pop());
        }
    }

    static <T> List<T> reverseRec(final Optional<Node<T>> node, final List<T> acc) {
        if (!node.isPresent()) {
            return acc;
        }

        final List<T> ts = reverseRec(node.get().next, acc);
        acc.add(node.get().val);

        return ts;
    }

    static <T> List<T> reverseIter(final Optional<Node<T>> node, final List<T> acc) {
        if (!node.isPresent()) {
            return Collections.emptyList();
        }

        final Stack<T> ts = new Stack<>();

        Optional<Node<T>> cur = node;
        do {
            ts.push(cur.get().val);
            cur = cur.get().next;
        } while (cur.isPresent());

        final List l = new LinkedList<>();
        while (!ts.empty()) {
            l.add(ts.pop());
        }

        return l;
    }
}
