#!/usr/bin/env python
"""Implementation of AES encryption/decryption in CBC mode.

Usage:
  cbc.py enc <key>
  cbc.py dec <key>
  cbc.py -h | --help
  cbc.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.

"""

from __future__ import print_function

import sys
import logbook
from docopt import docopt
from Crypto.Cipher import AES


log = logbook.Logger('cbc')


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


def encrypt(key, input, iv="0"*16):
    message = input.read().strip()
    message = pad_pkcs5(message)
    aes = AES.new(key)

    assert len(iv) == 16

    ct = [iv]
    for i in range(len(message) // 16):
        ct.append(encrypt_round(aes, ct[-1], message[i:(i + 1) * 16]))

    return "".join(ct)


def decrypt(key, input):
    full_input = input.read().strip().decode('hex')
    log.debug("Decrypting full msg %r" % full_input)
    iv = full_input[:16]
    ciphertext = full_input[16:]
    aes = AES.new(key)

    log.debug("IV: %r" % iv)
    log.debug("CT: %r" % ciphertext)

    pt = []
    cts = [iv] + list(chunks(ciphertext, 16))
    for i, ct in enumerate(cts):
        if i == 0:
            continue

        pt.append(decrypt_round(aes, cts[i - 1], ct))

    return strip_pkcs5("".join(pt))


def decrypt_round(aes, inp, ct):
    log.debug("%r XOR %r = %r" % (ct, inp, strxor(aes.decrypt(ct), inp)))
    return strxor(aes.decrypt(ct), inp)


def encrypt_round(aes, inp, msg):
    return aes.encrypt(strxor(inp, msg))



if __name__ == "__main__":
    arguments = docopt(__doc__, version="0.1")

    fn = None

    if arguments['enc']:
        fn = encrypt
    elif arguments['dec']:
        fn = decrypt

    if fn is not None:
        print(fn(arguments['<key>'].decode('hex'), sys.stdin))
