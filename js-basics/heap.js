'use strict';

module.exports = BinaryHeap;

function BinaryHeap(cmp) {
  this.content = [];
  this.cmp = cmp;
}

BinaryHeap.prototype = {
  push(n) {
    this.content.push(n);
    this.bubbleUp(this.content.length - 1);
  },

  swap(i, j) {
    const tmp = this.content[i];
    this.content[i] = this.content[j];
    this.content[j] = tmp;
  },

  peek() {
    return this.content[0];
  },

  bubbleUp(i) {
    if (i <= 0) return;

    const parent = Math.floor((i - 1) / 2);
    if (this.cmp(this.content[i]) > this.cmp(this.content[parent])) {
      this.swap(i, parent);
      this.bubbleUp(parent);
    }
  },

  siftDown(i) {
    const l = 2 * i + 1;
    const r = l + 1;
    let largest = i;

    const cmp = idx => this.cmp(this.content[idx]);

    if (l < this.content.length && this.cmp(this.content[l]) > this.cmp(this.content[largest])) {
      largest = l;
    }
    if (r < this.content.length && this.cmp(this.content[r]) > this.cmp(this.content[largest])) {
      largest = r;
    }
    if (largest !== i) {
      this.swap(largest, i);
      this.siftDown(largest);
    }
  },

  pop() {
    const fst = this.content[0];
    const lst = this.content.pop();

    if (!this.isEmpty()) {
      this.content[0] = lst;
      this.siftDown(0);
    }
    return fst;
  },

  isEmpty() {
    return this.content.length === 0;
  }
};

// Tests

const id = a => a;

const sort = (arr) => {
  const bh = new BinaryHeap(id);
  arr.forEach(bh.push.bind(bh));

  const res = [];
  // This should be a fold.
  while (!bh.isEmpty()) {
    res.push(bh.pop());
  }

  return res;
}

const test = () => {
  const jsc = require('jsverify');

  const prop_preservesLength = jsc.forall('array integer', (arr) => {
    return arr.length === sort(arr).length;
  });

  jsc.assert(prop_preservesLength);
};

test();