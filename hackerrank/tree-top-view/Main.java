// Java program to print top view of Binary tree
import java.util.*;

class Node {
  int data;
  Node left, right;

  public Node(int data) {
    this.data = data;
    left = right = null;
  }
}

class QNode {
  Node node;
  int hd;

  QNode(Node n, int hd) {
    this.node = n;
    this.hd = hd;
  }
}

class QNodeComparator implements Comparator<QNode> {
  @Override
  public int compare(QNode a, QNode b) {
    if (a.hd > b.hd) {
      return 1;
    } else if (a.hd < b.hd) {
      return -1;
    } else {
      return 0;
    }
  }
}

public class Main {
  public static void main(String[] args) {
    /* Create following Binary Tree
         1
       /  \
      2    3
       \
        4
         \
          5
           \
            6*/
    Node root = new Node(1);
    root.left = new Node(2);
    root.right = new Node(3);
    root.left.right = new Node(4);
    root.left.right.right = new Node(5);
    root.left.right.right.right = new Node(6);
    System.out.println("Following are nodes in top view of Binary Tree");
    printTopView(root);
  }

  public static void printTopView(Node root) {
    Set<Integer> seen = new HashSet<>();
    Queue<QNode> q = new LinkedList<>();
    PriorityQueue<QNode> nodes = new PriorityQueue<>(1, new QNodeComparator());

    q.add(new QNode(root, 0));

    while (!q.isEmpty()) {
      QNode cur = q.remove();
      if (!seen.contains(cur.hd)) {
        seen.add(cur.hd);
        nodes.add(cur);
      }

      if (cur.node.left != null) {
        q.add(new QNode(cur.node.left, cur.hd - 1));
      }

      if (cur.node.right != null) {
        q.add(new QNode(cur.node.right, cur.hd + 1));
      }
    }

    while (!nodes.isEmpty()) {
      Node cur = nodes.remove().node;
      System.out.print(String.format("%d ", cur.data));
    }
  }
}
