'use strict';
/**
 * @flow
 */

const processData = (input) => {
  const nmk = input.shift().split(' ').map(i => parseInt(i, 10));
  // What a draaag ...
  const n = nmk[0];
  const m = nmk[1];
  const k = nmk[2];

  const bikers = Array(n).fill(0).map(() => input.shift().split(' ').map(i => parseInt(i, 10)));
  const bikes = Array(m).fill(0).map(() => input.shift().split(' ').map(i => parseInt(i, 10)));

  console.log(go(k, bikers, bikes));
};

const go = (k, bikers, bikes) => {
  // Okay, brute force first.
  const b = bikers.map(biker => {
    const distances = bikes.map((bike, i) =>
      [i, Math.sqrt((Math.pow(biker[0] - bike[0], 2) - Math.pow(biker[1] - bike[1], 2)))]);
    const min = distances.reduce((b, a) => a[1] < b[1] ? a : b, [0, Infinity]);
    bikes.splice(min[0], 1);
    return min[1];
  });

  const max = (arr) => arr.reduce((b, a) => a > b ? a : b, -Infinity);
  const res = max(b.sort().slice(0, k));
  return Math.pow(res, 2);
};

const main = () => {
  process.stdin.resume();
  process.stdin.setEncoding("ascii");
  let _input = [];
  process.stdin.on("data", function (input) {
    _input = _input.concat(input.split('\n'));
  });
  process.stdin.on("end", function () {
    processData(_input);
  });
};

main();
