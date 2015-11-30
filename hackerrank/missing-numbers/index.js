'use strict';

/**
  * @flow
  */

const run = (ns, ms) => {
  const missing = [];
  const s = {};

  for (const n of ns) {
    if (s[n])
      s[n] += 1;
    else
      s[n] = 1;
  }

  for (const m of ms) {
    if (s[m] === undefined) {
      s[m] = 0;
    }

    s[m] -= 1;

    if (s[m] === -1) {
      missing.push(m);
    }
  }

  return missing;
};

const main = () => {
  process.stdin.resume();
  process.stdin.setEncoding('ascii');

  let input = '';
  process.stdin.on('data', function (input_) {
    input += input_;
  });

  process.stdin.on('end', function () {
    const lines = input.trim().split('\n');

    lines.shift();
    const n = lines.shift().split(' ').map(n => parseInt(n, 10));
    lines.shift();
    const m = lines.shift().split(' ').map(n => parseInt(n, 10));

    console.log(run(n, m).sort().join(' '));
  });
};

main();
