#!/usr/bin/env python3

import sys

def main(inp, start, end):
    visited = set()
    queue = [(start, 0)]

    while queue:
        (x, y), d = queue.pop()

        if (x, y) == end:
            return d
        else:
            for n in neighbors(inp, (x, y)):
                if n not in visited:
                    queue.append((n, d + 1))
                    visited.add(n)

    return -1

def neighbors(inp, start):
    x, y = start
    coords = [
        (x + 1, y),
        (x, y + 1),
        (x - 1, y),
        (x, y - 1)
    ]

    return [(x, y) for (x, y) in coords if x >= 0 and y >= 0 and sget(sget(inp, x, []), y, 'x') == '.']

def sget(l, idx, default):
    try:
        return l[idx]
    except IndexError:
        return default

if __name__ == "__main__":
    inp = [x.strip() for x in open(sys.argv[1]).readlines() if x.strip()]
    depth = main(inp, start=(0, 0), end=(2, 0))
    print(depth)
