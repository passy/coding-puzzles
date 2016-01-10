import java.util.Optional;

public class Main {
    public static void main(final String[] args) {
        final Node<String> node = new Node(
                Optional.of(new Node(
                        Optional.of(new Node(Optional.empty(), Optional.empty(), "A")),
                        Optional.of(new Node(Optional.empty(), Optional.empty(), "B")),
                        "E"
                )),
                Optional.of(new Node(
                        Optional.of(new Node(
                                Optional.of(new Node(Optional.empty(), Optional.empty(), "D")),
                                Optional.empty(),
                                "F"
                        )),
                        Optional.of(new Node(
                                Optional.empty(),
                                Optional.of(new Node(Optional.empty(), Optional.empty(), "C")),
                                "G"
                        )),
                        "X"
                )),
                "R"
        );

        System.out.println(node);
        invert(node);
        System.out.println(node);
    }

    static <T> void invert(final Node<T> node) {
        node.left.ifPresent(i -> invert(i));
        node.right.ifPresent(i -> invert(i));
        final Optional<Node<T>> tmp = node.left;
        node.right = node.left;
        node.left = tmp;
    }

    static class Node<T> {
        Optional<Main.Node<T>> left;
        Optional<Main.Node<T>> right;
        T value;

        Node(final Optional<Main.Node<T>> left, final Optional<Main.Node<T>> right, final T value) {
            this.left = left;
            this.right = right;
            this.value = value;
        }

        @Override
        public String toString() {
            return "Node{" +
                    "value=" + value +
                    "\n\tleft=" + (left.isPresent() ? left.get() : "null") +
                    "\n\tright=" + (right.isPresent() ? right.get() : "null") +
                    '}';
        }
    }
}