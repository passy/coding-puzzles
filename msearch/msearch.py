#!/usr/bin/env python3

import sys


def run(lines):
    res = [(i, list(enumerate(filter(lambda x: x != '\n', l)))) for (i, l) in enumerate(lines)]
    print(res)

if __name__ == "__main__":
    with open(sys.argv[1], 'r') as fp:
        run(fp.readlines())
