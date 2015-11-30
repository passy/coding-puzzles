'use strict';

/**
  * @flow
  */

const run = (input) => {
  let left = 0;
  let right = input.reduce((b, a) => b + a, 0);
  let cur = 0;

  // Bit of a weird one, tbh.
  if (input.length === 1) return true;

  for (let i = 0; i < input.length; i += 1) {
    if (left === right) return true;

    left += cur;
    cur = input[i];
    right -= cur;
  }

  return false;
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
    const t = parseInt(lines.shift(), 10);

    for (let i = 0; i < t; i += 1) {
      const n = parseInt(lines.shift());
      const a = lines.shift().split(' ').map((n) => parseInt(n, 10));

      console.log(run(a) ? 'YES' : 'NO');
    }
  });
};

main();
