'use strict';

/**
  * @flow
  */

/*::
  type Node = {
    val: number;
    children: [Node];
  };
*/

const go = (n, vs, es) => {
  const adj = {};
  for (let i = 0; i < n; i++) { adj[i] = []; }
  es.forEach(e => {
    const p = adj[e[0] - 1];
    adj[e[0] - 1] = p.concat(e[1] - 1);
    adj[e[1] - 1] = p.concat(e[0] - 1);
  });

  console.log(adj);
  dfs(new Set(), vs, adj, 0);
};

const dfs = (visited, vs, adj, i) => {
  if (visited.has(i)) return;
  visited.add(i);

  const children = adj[i];
  const res = children.map(c => dfs(visited, vs, adj, c));
  console.log(vs[i]);


  // Next step: Roll up the node value, get the minimum of the current node
  // and its children.
  return res;
};

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
