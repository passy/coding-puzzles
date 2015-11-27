'use strict';

/**
  * @flow
  */

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
    if (this.cmp(this.content[i], this.content[parent])) {
      this.swap(i, parent);
      this.bubbleUp(parent);
    }
  },

  siftDown(i) {
    const l = 2 * i + 1;
    const r = l + 1;
    let largest = i;

    if (l < this.content.length &&
        this.cmp(this.content[l], this.content[largest])) {
      largest = l;
    }
    if (r < this.content.length &&
        this.cmp(this.content[r], this.content[largest])) {
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

const run = n => n;

const main = () => {
  process.stdin.resume();
  process.stdin.setEncoding('ascii');
  process.stdin.on('data', function (input) {
    const ints = input.trim().split('\n').map(n => parseFloat(n, 10));
    ints.map(run).forEach(n => console.log(n));
  });

  process.stdin.on('end', function () {
  });
};

main();
