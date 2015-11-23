'use strict';

const run = input => {
  const t = Number.parseInt(input.shift(), 10);
  // Yeah, that's a bit silly. Just give us a range, ffs.
  Array(t).fill(0).forEach(() => {
    // Destructuring?
    const nm = input.shift().split(' ').map(n => Number.parseInt(n, 10));
    const n = nm[0];
    const m = nm[1];
    const map = Array(n).fill(0).map(() => input.shift());
    const k = input.shift();

    console.log('n, m', n, m)
    console.log('map', map)
    console.log('k', k)
  });
};

const main = () => {
  process.stdin.on('data', (data) => {
    run(data.toString().split('\n'));
  });
};

main();
