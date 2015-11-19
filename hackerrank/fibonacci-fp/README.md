# fibonacci

## Iterative vs DP

Both compiled via `stack ghc -- -O2 -optc-ffast-math -rtsopts Main.hs` with
`fib` replaced to `fib'` for the iterative version.

For up to `1000` the performance was almost identical but I expected
the iterative version to perform way better. With the increased range, the
results were more decisive:

Ran with `./Main +RTS -sstderr < input.txt`

### List-based approach

```
      15,414,840 bytes allocated in the heap
      14,105,640 bytes copied during GC
       6,343,816 bytes maximum residency (5 sample(s))
         205,688 bytes maximum slop
              12 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0        22 colls,     0 par    0.005s   0.006s     0.0003s    0.0007s
  Gen  1         5 colls,     0 par    0.013s   0.018s     0.0035s    0.0079s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time   27.346s  ( 27.627s elapsed)
  GC      time    0.019s  (  0.024s elapsed)
  EXIT    time    0.000s  (  0.001s elapsed)
  Total   time   27.366s  ( 27.651s elapsed)

  %GC     time       0.1%  (0.1% elapsed)

  Alloc rate    563,695 bytes per MUT second

  Productivity  99.9% of total user, 98.9% of total elapsed
```

### Iterative approach

```
     453,425,832 bytes allocated in the heap
         818,512 bytes copied during GC
          81,056 bytes maximum residency (2 sample(s))
          25,808 bytes maximum slop
               2 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0       898 colls,     0 par    0.003s   0.003s     0.0000s    0.0000s
  Gen  1         2 colls,     0 par    0.000s   0.000s     0.0001s    0.0001s

  INIT    time    0.000s  (  0.000s elapsed)
  MUT     time    0.031s  (  0.033s elapsed)
  GC      time    0.003s  (  0.003s elapsed)
  EXIT    time    0.000s  (  0.000s elapsed)
  Total   time    0.035s  (  0.036s elapsed)

  %GC     time       8.5%  (9.4% elapsed)

  Alloc rate    14,800,425,381 bytes per MUT second

  Productivity  91.3% of total user, 87.3% of total elapsed
```
