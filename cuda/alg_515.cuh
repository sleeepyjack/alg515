#ifndef ALG_515_CUH
#define ALG_515_CUH

#include "cudahelpers/cuda_helpers.cuh"

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
HOSTDEVICEQUALIFIER INLINEQUALIFIER void comb(index_t N, index_t P, index_t L, index_t * C)
{
  index_t K = 0;
  index_t P1 = P-1;
  index_t R;
  for(index_t I = 1; I < P; I++)
  {
    C[I-1] = -1; //NOTE does this work for unsigned types?
    if(I != 1) C[I-1] = C[I-2];
    do
    {
      C[I-1] += 1;
      R = binom(N-C[I-2]-1, P-I);
      K += R;
    }while(K > L);
    K -= R;
  }
  C[P-1] = C[P1-1] + L - K + 1;
}

#endif /* ALG_515_CUH */
