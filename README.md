# *Algorithm 515 (Buckle's Algorithm)*
---
Python, C/C++ and CUDA implementation of Algorithm 515 proposed by B. P. Buckles. (ref. [*publication*](http://dl.acm.org/citation.cfm?id=355739))

Algorithm 515 establishes a one-to-one correspondence between the universe of *p* combinations of *n* items *(1 <= p <= n)* and the first `binom(n, p)` natural numbers in lexicographical order.

### Example:

```python
n, p = 5, 3
nCp = binom(5, 3) # binomial coefficient
print '# of distinct combinations:', nCp

print 'combinations:'
for l in range(nCp):
	print alg515(n, p, l)
```

```
# of distinct combination: 10
combinations:
[0, 1, 2]
[0, 1, 3]
[0, 1, 4]
[0, 2, 3]
[0, 2, 4]
[0, 3, 4]
[1, 2, 3]
[1, 2, 4]
[1, 3, 4]
[2, 3, 4]
```
