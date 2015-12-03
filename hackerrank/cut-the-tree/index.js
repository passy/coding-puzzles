'use strict';

/**
  * @flow
  */

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
  });
};

main();
