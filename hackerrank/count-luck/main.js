'use strict';

/**
 * @flow
 */

const formatBool = b => b && "Impressed" || "Oops!";

const verifyMap = (map, k) => {
  const start = findSymbol(map, 'M');
  return go(map, 0, new Set(), start) === k;
};

const go = (map, acc, visited, start) => {
  if (map[start[0]][start[1]] === '*') return acc;

  const valid = getNeighbors(start[0], start[1])
    .filter(isValidCoord.bind(null, map))
    .filter(coord => !visited.has(coord.toString()));

  // console.log('valid', valid)
  visited.add(start.toString());
  switch (valid.length) {
    case 0:
      return -1;
    case 1:
      return go(map, acc, visited, valid[0]);
    default:
      const paths = valid.map(go.bind(null, map, acc + 1, visited));
      return paths.reduce((b, a) => Math.max(a, b), -1);
  }
};

const findSymbol = (map, sym) => {
  for (let x = 0; x < map.length; x += 1) {
    const y = map[x].indexOf(sym);
    if (y >= 0) return [x, y];
  }

  return [-1, -1];
};

const getNeighbors = (x, y) => [
  [x - 1, y],
  [x, y + 1],
  [x + 1, y],
  [x, y - 1]];

const isValidCoord = (map, coord) => {
  const valid = {
    '*': true,
    '.' : true
  };
   const xc = map[coord[0]];
   return !!(xc && valid[xc[coord[1]]]);
};

const run = input => {
  const t = parseInt(input.shift(), 10);
  // Yeah, that's a bit silly. Just give us a range, ffs.
  Array(t).fill(0).forEach(() => {
    // Destructuring?
    const nm = input.shift().split(' ').map(n => parseInt(n, 10));
    const n = nm[0];
    const m = nm[1];
    const map = Array(n).fill(0).map(() => input.shift());
    const k = parseInt(input.shift(), 10);

    console.log(formatBool(verifyMap(map, k)));
  });
};

const main = () => {
  process.stdin.on('data', (data) => {
    run(data.toString().split('\n'));
  });
};

main();
