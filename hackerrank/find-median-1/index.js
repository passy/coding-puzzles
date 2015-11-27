'use strict';

/**
  * @flow
  */

const d = (str) => false && console.log(str);

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
    if (r < this.size() &&
        this.cmp(this.content[r], this.content[largest])) {
      largest = r;
    }
    if (largest !== i) {
      this.swap(largest, i);
      this.siftDown(largest);
    }
  },

  size() {
    return this.content.length;
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

const run = (maxHeap, minHeap, n) => {
  const maxHeapN = maxHeap.size();
  const minHeapN = minHeap.size();

  // Let's make the empty case easier.
  if (maxHeapN === 0 && minHeapN === 0) {
    maxHeap.push(n);
    return n;
  }

  const maxEl = maxHeap.peek();
  const minEl = minHeap.peek();
  d('max el', maxEl);
  d('min el', maxEl);

  if (n >= minEl) {
    d('pushing %d to minheap', n)
    minHeap.push(n);
  } else {
    d('pushing %d to maxheap', n)
    maxHeap.push(n);
  }

  rebalance(maxHeap, minHeap);
  d('max', maxHeap.content);
  d('min', minHeap.content);

  switch (minHeap.size() - maxHeap.size()) {
    case -1:
      return maxHeap.peek();
    case 1:
      return minHeap.peek();
    default:
      return (maxHeap.peek() + minHeap.peek()) / 2;
  }
};

const rebalance = (a, b) => {
  if (a.size() > b.size() + 1) {
    d('a is unbalanced, rebalancing.')
    b.push(a.pop());
  } else if (b.size() > a.size() + 1) {
    d('b is unbalanced, rebalancing.')
    a.push(b.pop());
  } else {
    d('not rebalancing')
  }
};

const main = () => {
  const maxHeap = new BinaryHeap((a, b) => a >= b);
  const minHeap = new BinaryHeap((a, b) => a <= b);

  process.stdin.resume();
  process.stdin.setEncoding('ascii');
  process.stdin.on('data', function (input) {
    const ints = input.trim().split('\n').map(n => parseFloat(n, 10));
    ints.shift();
    ints.map(run.bind(null, maxHeap, minHeap)).forEach(n => console.log(n.toFixed(1)));
  });

  process.stdin.on('end', function () {
  });
};

main();
