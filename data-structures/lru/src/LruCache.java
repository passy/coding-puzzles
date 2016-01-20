import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class LruCache<K, V> {
    final Map<K, Node<K, V>> map;
    final int capacity;

    Optional<Node<K, V>> top = Optional.empty();
    Optional<Node<K, V>> bottom = Optional.empty();

    public LruCache(final int capacity) {
        this.capacity = capacity;
        this.map = new HashMap<>(capacity);
    }

    private void remove(final Optional<Node<K, V>> node) {
        if (!top.isPresent() || !node.isPresent()) {
            return;
        }

        if (top == bottom && node == top) {
            top = bottom = Optional.empty();
        } else if (top == node) {
            top.get().next.get().prev = Optional.empty();
            top = top.get().next;
        } else if (bottom == node) {
            bottom.get().prev.get().next = Optional.empty();
            bottom = bottom.get().prev;
        } else {
            node.get().prev.get().next = node.get().next;
            node.get().next.get().prev = node.get().prev;
        }
    }

    private void setTop(final Node<K, V> node) {
        final Optional<Node<K, V>> nodeOptional = Optional.<Node<K, V>>of(node);
        node.next = Optional.empty();
        node.prev = Optional.empty();

        if (!top.isPresent()) {
            top = nodeOptional;
            bottom = nodeOptional;
        } else {
            top.get().prev = nodeOptional;
            node.next = this.top;
            top = nodeOptional;
        }
    }

    public Optional<V> get(final K key) {
        if (map.containsKey(key)) {
            final Node<K, V> node = map.get(key);
            remove(Optional.of(node));
            setTop(node);
            return Optional.<V>of(node.value);
        }

        return Optional.empty();
    }

    public void set(K key, V value) {
        if (map.containsKey(key)) {
            final Node<K, V> node = map.get(key);
            remove(Optional.of(node));
            setTop(node);
            node.value = value;
            return;
        }

        if (map.size() >= capacity) {
            map.remove(bottom.get().key);
            remove(bottom);
        }

        final Node<K, V> node = new Node<>(key, value);
        setTop(node);
        map.put(key, node);
    }


    static class Node<K, V> {
        Optional<Node<K, V>> prev;
        Optional<Node<K, V>> next;
        V value;
        K key;

        Node(final K key, final V value) {
            this(Optional.empty(), Optional.empty(), key, value);
        }

        Node(final Optional<Node<K, V>> prev, final Optional<Node<K, V>> next, final K key, final V value) {
            this.prev = prev;
            this.next = next;
            this.value = value;
            this.key = key;
        }
//
//        @Override
//        public String toString() {
//            return "Node{" +
//                    "prev=" + prev +
//                    ", next=" + next +
//                    ", value=" + value +
//                    ", key=" + key +
//                    '}';
//        }
    }
}
