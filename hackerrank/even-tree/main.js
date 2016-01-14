'use strict';
/** @flow */

const run = (lines) => {
  const inp = lines.map(l => l.split(' ').map(n => parseInt(n, 10)));
  const fst = inp.shift();
  const n = fst[0];
  const m = fst[1];

  const edges = {};

  for (let i = 1; i <= n; i += 1) {
    edges[i] = [];
  }

  for (let i = 0; i < m; i += 1) {
    let e = inp.shift();
    edges[e[0]].push(e[1]);
    edges[e[1]].push(e[0]);
  }

  console.log(edges);
};

const main = () => {
  process.stdin.resume();
  process.stdin.setEncoding("ascii");
  let _input = "";
  process.stdin.on("data", function (input) {
    _input += input;
  });

  process.stdin.on("end", function () {
    run(_input.split('\n'));
  });
};

main();
