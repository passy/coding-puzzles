#!/usr/bin/env python
"""Implementation of AES encryption/decryption in CRT mode.

Usage:
  crt.py enc <key>
  crt.py dec <key>
  crt.py -h | --help
  crt.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from __future__ import print_function

import sys
import logbook
import array
from docopt import docopt
from Crypto.Cipher import AES


log = logbook.Logger('crt')


def chunks(l, n):
    for i in xrange(0, len(l), n):
        yield l[i:i+n]


def strxor(a, b):
    return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a, b)])


def pad_pkcs5(value, bs=16):
    remainder = len(value) % 16

    value += (16 - remainder) * chr(remainder)
    return value


def strip_pkcs5(value):
    pad_length = ord(value[-1])
    return value[:-pad_length]


class Counter(object):
    def __init__(self, iv):
        self.counter = array.array('B', iv)

    def inc(self):
        for i, c in enumerate(self.counter):
            try:
                self.counter[15 - i] += 1
                break
            except OverflowError:
                self.counter[15 - i] = 0

        return self.counter.tostring()

    def __str__(self):
        return self.counter.tostring()

    def get(self):
        return self.counter.tostring()


def crypt(key, input):
    full_input = input.read().strip().decode('hex')
    log.debug("Decrypting full msg %r" % full_input)

    iv = full_input[:16]
    counter = Counter(iv)
    ciphertext = full_input[16:]
    aes = AES.new(key)

    log.debug("k: %r" % key)
    log.debug("IV: %r" % iv)
    log.debug("CT: %r" % ciphertext)

    pt = []
    cts = chunks(ciphertext, 16)
    # This loop could be parallelized if so desired.
    for i, ct in enumerate(cts):
        log.debug("Counter: %r" % counter.get())

        pt.append(crypt_round(aes, counter.get(), ct))
        counter.inc()

    return "".join(pt)


def crypt_round(aes, inp, ct):
    result = strxor(aes.encrypt(inp), ct)
    log.debug("F(k, %r) XOR %r = %r" % (inp, ct, result))
    return result


if __name__ == "__main__":
    arguments = docopt(__doc__, version="0.1")

    fn = None

    if arguments['enc']:
        print(crypt(arguments['<key>'].decode('hex'),
                      sys.stdin).encode('hex'))
    elif arguments['dec']:
        print(crypt(arguments['<key>'].decode('hex'), sys.stdin))
