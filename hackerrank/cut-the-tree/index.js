'use strict';

/**
  * @flow
  */

const go = (n, vs, es) => {
  const adj = {};
  const vals = {};
  for (let i = 0; i < n; i++) { adj[i] = []; vals[i] = 0; }
  es.forEach(e => {
    adj[e[0] - 1] = adj[e[0] - 1].concat(e[1] - 1);
    adj[e[1] - 1] = adj[e[1] - 1].concat(e[0] - 1);
  });

  const visited = new Set();
  const dfs = (i) => {
    visited.add(i);
    const ret = adj[i].reduce((acc, childi) => visited.has(childi) ? acc : acc + dfs(childi), 0);
    vals[i] = vs[i] + ret;
    return vals[i];
  };

  // Kick off side-effecting DFS.
  dfs(0);

  const tot = sum(vs);
  const best = Object.keys(vals).reduce((best, k) => {
    const diff = Math.abs(tot - (vals[k] * 2));
    return diff < best ? diff : best;
  }, Infinity);

  console.log(best);
};

const sum = (arr) => arr.reduce((b, a) => a + b, 0);

const main = () => {
  process.stdin.resume();
  process.stdin.setEncoding('ascii');

  let input = '';
  process.stdin.on('data', function (input_) {
    input += input_;
  });

  process.stdin.on('end', function () {
    const inp = input.split('\n');
    const n = parseInt(inp.shift(), 10);
    const vs = inp.shift().split(' ').map(n => parseInt(n, 10));
    const es = Array(n - 1).fill([]).map(_ =>
      inp.shift().split(' ').map(n => parseInt(n, 10))
    );

    go(n, vs, es);
  });
};

main();
