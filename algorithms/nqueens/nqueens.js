// Given a chess board of NxN dimensions, place N queens on it that don't
// conflict with each other.


(function () {
    'use strict';
    function solve(queens, r, solutions) {
        solutions = solutions || [];

        if (r === queens.length) {
            solutions.push(queens.slice(0));
        }

        for (var j = 0; j < queens.length; j += 1) {
            var legal = true;
            for (var i = 0; i < r; i += 1) {
                if (queens[i] === j || queens[i] === j + r - i ||
                    queens[i] === j - r + i) {
                    legal = false;
                }
            }

            if (legal) {
                queens[r] = j;
                solve(queens, r + 1, solutions);
            }
        }

        return solutions;
    }


    function main() {
        var BOARD_SIZE = 8;
        var board = new Array(BOARD_SIZE);
        for (var i = 0; i < board.length; i += 1) {
            board[i] = -1;
        }

        var solutions = solve(board, 0);
        console.log(solutions);
    }

    main();
}());
