'use strict';

/**
  * @flow
  */

const go = (n, vs, es) => {
  const adj = {};
  const vals = {};
  for (let i = 0; i < n; i++) { adj[i] = []; vals[i] = 0; }
  es.forEach(e => {
    const p = adj[e[0] - 1];
    adj[e[0] - 1] = p.concat(e[1] - 1);
    adj[e[1] - 1] = p.concat(e[0] - 1);
  });

  const visited = new Set();
  const dfs = (i) => {
    visited.add(i);
    const ret = adj[i].reduce((acc, childi) => visited.has(childi) ? 0 : acc + dfs(childi), 0);
    vals[i] = vs[i] + ret;
    return vals[i];
  };

  // Kick off side-effecting DFS.
  dfs(0);

  let tot = sum(vs);
  let best = Infinity;
  for (let i = 0; i < n; i++) {
    const diff = Math.abs(tot - (vals[i] * 2));
    if (diff < best) {
      best = diff;
    }
  }

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
