import java.util.Optional;

public class Main {

    public static void main(String[] args) {
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

        runCounts(node);
        System.out.println(node);
    }

    static <T> void runCounts(final Node<T> root) {
        root.left.ifPresent(Main::runCounts);
        root.right.ifPresent(Main::runCounts);

        final int count = 1 +
                (root.left.isPresent() ? root.left.get().depth : 0) +
                (root.right.isPresent() ? root.right.get().depth : 0);

        root.depth = count;
    }
}

class Node<T> {
    Optional<Node<T>> left, right;
    T value;
    int depth = 0;

    Node(final Optional<Node<T>> left, final Optional<Node<T>> right, final T value) {
        this.left = left;
        this.right = right;
        this.value = value;
    }

    @Override
    public String toString() {
        return "Node{" +
                "left=" + left +
                ", right=" + right +
                ", value=" + value +
                ", depth=" + depth +
                '}';
    }
}


