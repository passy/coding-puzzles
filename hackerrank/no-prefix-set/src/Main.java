import java.util.Scanner;

public class Main {

    public static void main(final String[] args) {
        final Scanner scanner = new Scanner(System.in);

        final int n = scanner.nextInt();
        final Trie t = new TrieImpl();

        for (int i = 0; i <= n; i++) {
            final String line = scanner.nextLine().trim();
            if (!line.isEmpty() && !t.add(line)) {
                System.out.printf("BAD SET\n%s", line);
                return;
            }
        }

        System.out.println("GOOD SET");
    }
}

interface Trie {
    boolean add(String word);
}

class TrieImpl implements Trie {
    private final TrieNode root = new TrieNode();

    @Override
    public boolean add(final String word) {
        TrieNode node = root;
        final int length = word.length();
        for (int index = 0; index < length; index++) {
            node.leaf = false;
            final char c = word.charAt(index);
            final int i = c - 'a';

            if (node.children[i] == null) {
                node.children[i] = new TrieNode();
            } else if (node.children[i].leaf || (index == (length - 1))) {
                return false;
            }

            node = node.children[i];
        }

        return true;
    }
}

class TrieNode {
    public static final int RANGE = ('j' - 'a') + 1;

    public boolean leaf = true;
    public TrieNode[] children = new TrieNode[RANGE];
}
