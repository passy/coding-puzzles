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
      const parentI = Math.floor(((i + 1) / 2) - 1);
      const parent = this.content[parentI];
      const parentScore = this.cmp(parent);

      if (parentScore < score) break;

      this.content[j] = parent;
      this.content[parentI] = el;
      j = parentI;
    }
  }
};

const main = () => {
  const id = a => a;
  const bh = new BinaryHeap(id);
  bh.push(5);
  bh.push(3);
  bh.push(10);
  bh.push(500);

  console.log(bh.peek());
  console.log(bh.content);
};

main();
