'use strict';

const jsc = require('jsverify');

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

const id = a => a;

const main = () => {
  const id = a => a;
  const heap = new BinaryHeap(id);
  [10, 3, 4, 8, 2, 9, 7, 1, 2, 6, 5].forEach(heap.push.bind(heap));

  const res = [];
  while (!heap.isEmpty()) {
    console.log(heap.pop());
  }
};

main();
