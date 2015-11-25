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

  const res = Math.pow(go(k, bikers, bikes, 0), 2);
  console.log(Math.round(res));
};

const go = (k, bikers, bikes, acc) => {
  if (k === 0) return acc;

  // Okay, brute force first. O((n+m)^2)
  const bikerDistances = bikers.map(biker =>
    bikes.map((bike, i) =>
      [i, Math.sqrt((Math.pow(biker[0] - bike[0], 2) + Math.pow(biker[1] - bike[1], 2)))])
  );

  const minDist = arr => arr.reduce((b, a) => b[1] < a[1] ? b : a, [-1, Infinity]);
  const bestDistances = bikerDistances.map((d, i) => [i].concat(minDist(d)));

  const bestDist = arr => arr.reduce((b, a) => b[2] < a[2] ? b : a, [-1, -1, Infinity]);
  const best = bestDist(bestDistances);

  // Should be immutable ...
  bikers.splice(best[0], 1);
  bikes.splice(best[1], 1);

  return go(k - 1, bikers, bikes, best[2]);
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
