#ifndef ALG_515_CUH
#define ALG_515_CUH

// http://stackoverflow.com/questions/24294192/computing-the-binomial-coefficient-in-c
template <typename index_t>
HOSTDEVICEQUALIFIER INLINEQUALIFIER index_t binom(index_t n, index_t k)
{
  index_t ans=1;
  k=k>n-k?n-k:k;
  index_t j=1;
  for(;j<=k;j++,n--)
  {
    if(n%j==0)
    {
        ans*=n/j;
    }else
    if(ans%j==0)
    {
        ans=ans/j*n;
    }else
    {
        ans=(ans*n)/j;
    }
  }
  return ans;
}

// http://dl.acm.org/citation.cfm?id=355739
template <typename index_t>
HOSTDEVICEQUALIFIER INLINEQUALIFIER void alg515(index_t N, index_t P, index_t L, index_t * C)
{
  index_t X = 1;
  index_t R = binom(N-X, P-1);
  index_t K = R;

  while(K <= L)
  {
    X++;
    R  = binom(N-X, P-1);
    K += R;
  }
  K -= R;
  C[0] = X-1;

  for(index_t I = 2; I < P; I++)
  {
    X++;
    R  = binom(N-X, P-I);
    K += R;
    while(K <= L)
    {
      X++;
      R  = binom(N-X, P-I);
      K += R;
    }
    K -= R;
    C[I-1] = X-1;
  }
  C[P-1] = X + L - K;
}

#endif /* ALG_515_CUH */
