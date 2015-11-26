'use strict';
/**
 * @flow
 */

const quickSort = l => {
  const swp = (a, i, j) => {
    const tmp = a[i];
    a[i] = a[j];
    a[j] = tmp;
  }

  const part = (a, lo, hi) => {
    const piv = a[hi];
    let i = lo;
    for (let j = lo; j < hi; j += 1) {
      if (a[j] <= piv) {
        swp(a, i, j);
        i += 1;
      }
    }
    swp(a, i, hi);
    return i;
  };

  const go = (a, lo, hi) => {
    if (lo >= hi) return;
    const p = part(a, lo, hi);
    go(a, lo, p - 1);
    go(a, p + 1, hi);
  };

  return go(l, 0, l.length - 1);
};

const main = () => {
  const input = [5, 12, 5, 12, 45, 89, 8, 2];
  quickSort(input);

  console.log(input);
}

main();
