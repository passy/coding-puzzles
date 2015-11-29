'use strict';
/**
 * @flow
 */

const run = (input /*: [string] */) => {
  const n = parseInt(input.shift(), 10);
  const nodes = Array(n).fill(0).map(() => input.shift().split(' ').map(n => parseInt(n, 10)));

  const t = parseInt(input.shift(), 10);
  const swaps = Array(t).fill(0).map(() => parseInt(input.shift(), 10));

  console.log('n: ', n);
  console.log('nodes: ', nodes);
  console.log('t: ', t);
  console.log('swaps: ', swaps);

  const tree = mkTree(nodes);
  console.log(tree);
  tree.printLevelOrder();
};

class Node {
  /* :: key: number; */
  /* :: left: ?Node; */
  /* :: right: ?Node; */
  constructor(key) {
    this.key = key;
    this.left = null;
    this.right = null;
  }

  toString() {
    return '[key=' + this.key.toString()
      + ', left=' + (this.left == null ? '-' : this.left.toString())
      + ', right=' + (this.right == null ? '-' : this.right.toString()) + ']';
  }

  printLevelOrder() {
    const q = [this];

    let str = '';
    while (q.length > 0) {
      const root = q.shift();
      str += root.key + ' ';

      if (root.left != null) {
        q.push(root.left);
      }
      if (root.right != null) {
        q.push(root.right);
      }
    }

    console.log(str);
  }
}

const mkTree = (nodes /*: [[number]]*/) => {
  const root = new Node(1);
  const q = [root];

  while (q.length > 0 && nodes.length > 0) {
    const idx = nodes.shift();
    const node = q.shift();

    const l = idx[0];
    const r = idx[1];

    if (l !== -1) {
      const lnode = new Node(l);
      node.left = lnode;
      q.push(lnode);
    }

    if (r !== -1) {
      const rnode = new Node(r);
      node.right = rnode;
      q.push(rnode);
    }
  }

  return root;
};

const main = () => {
  process.stdin.resume();
  process.stdin.setEncoding("ascii");
  let _input = '';
  process.stdin.on("data", function (input) {
      _input += input;
  });

  process.stdin.on("end", function () {
     run(_input.split('\n'));
  });
};

main();
