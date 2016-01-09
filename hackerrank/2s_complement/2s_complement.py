#!/usr/bin/env python3

"""
One of the basics of Computer Science is knowing how numbers are
represented in 2's complement. Imagine that you write down all numbers between
A and B inclusive in 2's complement representation using 32 bits. How many 1's
will you write down in all?

This solution only scores 2/10 points and times out for larger inputs.
"""

def calc(it):
    total = 0

    for value in it:
        count = 0
        n = value if value >= 0 else abs(value) - 1

        for bits in range(31, -1, -1):
            r = n - (2 ** bits)

            if r >= 0:
                count += 1
                n = r

            if n == 0:
                break

        if value >= 0:
            total += count
        else:
            total += (32 - count)

    return total


def main():
    lines = int(input())
    for i in range(lines):
        x, y = map(int, input().split(' '))
        print(calc(range(x, y + 1)))


if __name__ == "__main__":
    main()
