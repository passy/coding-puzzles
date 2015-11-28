/*
   class Node
      public  int frequency; // the frequency of this tree
       public  char data;
       public  Node left, right;

*/

void decode(String S, Node root) {
    System.out.println(readHuff(root, root, S, 0, ""));
}

String readHuff(Node root, Node cur, String input, int count, String acc) {
    if (count == input.length()) return acc;

    char c = input.charAt(count);
    Node n;
    if (c == '0') {
        n = cur.left;
    } else {
        n = cur.right;
    }

    if (n.data != '\0') {
        return readHuff(root, root, input, count + 1, acc + n.data);
    } else {
        return readHuff(root, n, input, count + 1, acc);
    }
}
