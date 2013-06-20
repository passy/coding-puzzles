function Node(key, value) {
    this.key = key;
    this.value = value;

    this.left = null;
    this.right = null;
}

function BinaryTree(root) {
    this.root = root;
}

BinaryTree.prototype.insert = function (node) {
    var cur = this.root;
    var i = 0;

    do {
        i += 1;
        if (node.key <= cur.key) {
            if (cur.left === null) {
                cur.left = node;
                break;
            }
            cur = cur.left;
        } else {
            if (cur.right === null) {
                cur.right = node;
                break;
            }
            cur = cur.right;
        }
    } while (cur !== null);
};

BinaryTree.prototype.contains = function (key) {
    return !!this.get(key);
};

BinaryTree.prototype.get = function (key) {
    var cur = this.root;

    while (cur !== null) {
        if (cur.key === key) {
            return cur;
        }

        if (key <= cur.key) {
            cur = cur.left;
        } else {
            cur = cur.right;
        }
    }
};

BinaryTree.prototype.inOrder = function (cur, accu) {
    accu = accu || [];

    if (cur.left !== null) this.inOrder(cur.left, accu);
    accu.push(cur.key);
    if (cur.right !== null) this.inOrder(cur.right, accu);

    return accu;
};


BinaryTree.prototype.inOrderImmutable = function (cur, accu) {
    accu = accu || [];

    if (cur.left !== null) {
        accu = this.inOrder(cur.left, accu);
    }
    accu = accu.concat(cur.key);
    if (cur.right !== null) {
        accu = this.inOrder(cur.right, accu);
    }

    return accu;
};


BinaryTree.prototype.inOrderIterative = function () {
    var res = [];
    var node = this.root;
    var parents = [];

    while (parents.length > 0 || node !== null) {
        if (node !== null) {
            parents.push(node);
            node = node.left;
        } else {
            node = parents.pop();
            res.push(node.key);
            node = node.right;
        }
    }

    return res;
};


function main() {
    var tree = new BinaryTree(new Node(8));
    [3, 1, 5, 4, 10, 9, 12].map(function (i) { return new Node(i); }).forEach(tree.insert.bind(tree));

    console.log('inOrder:');
    console.log(tree.inOrderIterative());
}
main();
