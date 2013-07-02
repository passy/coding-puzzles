// Given a list of positive non-zero integers `arr` and a target integer `sum`,
// is there a subset of elements in `arr` that add up to `sum`?

(function () {
    'use strict';

    function subsetSum(arr, sum) {
        if (sum === 0) {
            // An empty list would sum up to 0.
            return true;
        } else if (sum < 0 || arr.length === 0) {
            // We can't sum positive, non-zero integers up to zero; neither can
            // we add up positive number to a negative number.
            return false;
        } else {
            return subsetSum(arr.slice(1), sum) || subsetSum(arr.slice(1), sum - arr[0]);
        }

    }

    console.log(subsetSum([8, 6, 7, 5, 3, 10, 9], 15));
    console.log(subsetSum([11, 6, 5, 1, 7, 13, 12], 15));
}());
