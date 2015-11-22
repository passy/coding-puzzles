'use strict';

function BinaryHeap(cmp) {
  this.content = [];
  this.cmp = cmp;
}

BinaryHeap.prototype = {
  push(n) {
    this.content.push(n);
    this.bubbleUp(this.content.length - 1);
  },

  peek() {
    return this.content[0];
  },

  bubbleUp(i) {
    const el = this.content[i], score = this.cmp(el);
    let j = i;

    while (j > 0) {
      const parentI = Math.floor((i - 1) / 2);
      const parent = this.content[parentI];
      const parentScore = this.cmp(parent);

      if (parentScore < score) break;

      this.content[j] = parent;
      this.content[parentI] = el;
      j = parentI;
    }
  },

  siftDown(i) {
    const el = this.content[i], score = this.cmp(el);
    let j = i;

    const swap = (i, j) => {
      const tmp = this.content[i];
      this.content[i] = this.content[j];
      this.content[j] = tmp;
    }

    while (true) {
      console.log('content: ', this.content);
      const childi = j * 2;
      const a = this.content[childi + 1];
      const b = this.content[childi + 2];
      const scoreA = this.cmp(a);
      const scoreB = this.cmp(b);

      if (a !== undefined && score > scoreA && scoreA < scoreB) {
        console.log('swap(', j, childi + 1, ')');
        swap(j, childi + 1);
        j = a;
      } else if (b !== undefined && score > scoreB && scoreB < scoreA) {
        console.log('swap(', j, childi + 2, ')');
        swap(j, childi + 2);
        j = b;
      } else {
        break;
      }
    }
  },

  pop() {
    const e = this.content[0];
    this.content[0] = this.content.pop();
    this.siftDown(0);
    return e;
  },

  isEmpty() {
    return this.content.length === 0;
  }
};

const main = () => {
  const id = a => a;
  const bh = new BinaryHeap(id);
  bh.push(5);
  bh.push(3);
  bh.push(10);
  bh.push(500);

  const bh2 = new BinaryHeap(id);
  // Should pull in some property testing libs
  for (let i = 0; i < 500; i++) {
    // Yeah, really don't care about precision here.
    bh2.push(Math.floor(Math.random() * 100));
    console.log(bh2.content);
  }

  const res = [];
  while (!bh2.isEmpty()) {
    res.push(bh2.pop());
    console.log(res);
  }

  console.log(res);
};

main();
