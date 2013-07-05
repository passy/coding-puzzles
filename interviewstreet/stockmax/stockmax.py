#!/usr/bin/env python3

"""
Your algorithms have become so good at predicting the market that you now know
what the share price of Wooden Orange Toothpicks Inc. (WOT) will be for the
next N days.

Each day, you can either buy one share of WOT, sell any number of shares of
WOT that you ow or not make any transaction at all. What is the maximum profit
you can obtain with an optimum trading strategy?
"""


def calc_max_list(prices):
    n = len(prices)
    maxl = [prices[n - 1]] * n

    for i in range(n - 2, 0, -1):
        maxl[i] = max(prices[i], maxl[i + 1])

    return maxl


def max_profit(prices):
    maxl = calc_max_list(prices)

    profit = 0
    stocks = 0

    for i, price in enumerate(prices):

        if maxl[i] > price:
            profit -= price
            stocks += 1
        elif maxl[i] == price:
            profit += price * stocks
            stocks = 0

    return profit


def main():
    # Runs once for every test case.
    n = int(input().strip())
    prices = list(map(int, input().strip().split(' ')))
    assert(n == len(prices))

    print(max_profit(prices))


if __name__ == "__main__":
    count = int(input().strip())

    for i in range(count):
        main()
