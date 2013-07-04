#!/usr/bin/env python3


import heapq


class PriorityQueue:
    def __init__(self, data=None):
        self.counter = 0

        self.heap = []
        if data is not None:
            self._heapify(data)

    def _heapify(self, data):
        for value in data:
            self.heap.append((-1 * value[1], self.counter, value))
            self.counter += 1

        heapq.heapify(self.heap)

    def push(self, priority, value):
        heapq.heappush(self.heap, (priority, self.counter, value))
        self.counter += 1

    def peek(self):
        try:
            return self.heap[0][2]
        except IndexError:
            return float('inf'), 0

    def pop(self):
        return heapq.heappop(self.heap)[2]

    def __repr__(self):
        return '<PriorityQueue heap={!r}>'.format(self.heap)


def max_profit(prices):
    pq = PriorityQueue(enumerate(prices))
    profit = 0
    stocks = 0

    for i, price in enumerate(prices):
        while True:
            li, lmax = pq.peek()

            if i > li:
                pq.pop()
            else:
                break

        if i < li and price < lmax:
            profit -= price
            stocks += 1

        if i == li:
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
