"""
Heapsort using a binary heap in Python not utilizing heapq.
"""

import logging
logging.basicConfig(level=logging.WARN)


def heapify(arr):
    logging.info('heapifying %r', arr)
    # Last parent node
    start = (len(arr) - 2) // 2
    end = len(arr) - 1

    logging.info('start: %r, end: %r', start, end)

    while start >= 0:
        sift_down(arr, start, end)
        start -= 1

    return arr


def sift_down(arr, start, end):
    logging.info('sift_down(%r, %d, %d)', arr, start, end)
    while start * 2 + 1 <= end:
        child = start * 2 + 1
        logging.info('start: %d, child: %d', start, child)

        if child + 1 <= end and arr[child] < arr[child + 1]:
            child += 1
            logging.info('Right child is larger, child: %d', child)
        if arr[start] < arr[child]:
            logging.info('Swapping %d with %d', arr[start], arr[child])
            arr[start], arr[child] = arr[child], arr[start]
            start = child
        else:
            logging.info('Heap property is intact.')
            return


def heapsort(arr):
    heap = heapify(arr)

    end = len(arr) - 1
    while end > 0:
        # Swap max with end
        heap[0], heap[end] = heap[end], heap[0]
        end -= 1

        sift_down(arr, 0, end)

    return arr


if __name__ == "__main__":
    arr = [5, 3, 9, 1, 2, 5]
    heapsort(arr)

    print(arr)
