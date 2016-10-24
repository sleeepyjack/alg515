from scipy.special import binom

def comb(N, P, L):
    C = [0] * P
    K = 0
    P1 = P - 1
    for I in range(1, P):
        C[I-1] = -1
        if (I != 1):
            C[I-1] = C[I-2]
        while True:
            C[I-1] += 1
            R  = int(binom(N-1-C[I-1], P-I))
            K += R
            if (K > L):
                break
        K -=  R
    C[P-1] = C[P1-1] + L - K + 1
    return 

################################################

n, r = 5, 3

nCr  = int(binom(n, r))

print "n =", n, "\tr =", r, "\tnCr =", nCr

for i in range(nCr):
    print comb(n, r, i)
