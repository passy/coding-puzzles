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

  // Adjacency matrix
  const matrix = bikers.map(biker =>
    bikes.map((bike, i) =>
      [i, Math.sqrt((Math.pow(biker[0] - bike[0], 2) + Math.pow(biker[1] - bike[1], 2)))])
  );

  console.log(matrix);

  const res = Math.pow(go(k, matrix, 0), 2);
  console.log(Math.round(res));
};

const go = (k, matrix, acc) => {
  return 0;
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
