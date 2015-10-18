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
    start = int(input()) - 1

    # Adjacency matrix
    matrix = collections.defaultdict(lambda: [])
    for a, b in connections:
        matrix[a].append(b)
        matrix[b].append(a)

    print("Matrix: ", matrix)
    print("Start: ", start)


if __name__ == "__main__":
    main()
