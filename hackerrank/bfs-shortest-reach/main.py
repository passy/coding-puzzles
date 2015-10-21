#!/usr/bin/env python3

import sys
import collections


COST = 6


def main():
    for _ in range(int(input())):
        run()

def read_tuple():
    a, b = [int(x) for x in input().split(' ')]
    return (a, b)


def run():
    n, m = read_tuple()
    connections = [read_tuple() for _ in range(m)]
    start = int(input())

    # Adjacency matrix
    matrix = collections.defaultdict(lambda: set())
    for a, b in connections:
        matrix[a].add(b)
        matrix[b].add(a)

    queue = [start]
    cost = {start: 0}
    cur_cost = COST

    # I love how disgustingly imperative this is.
    while queue:
        i = queue.pop(0)
        for _n in neighbors(matrix, i):
            if _n not in cost:
                cost[_n] = cur_cost
                queue.append(_n)
        cur_cost += COST

    for i in range(2, n + 1):
        if i not in cost:
            print(-1, end=' ')
        else:
            print(cost[i], end=' ')

    print()

def neighbors(matrix, i):
    return matrix[i]


if __name__ == "__main__":
    main()
