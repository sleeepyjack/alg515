#include "cudahelpers/cuda_helpers.cuh"
#include "alg_515.cuh"

#define DEBUG

template <typename index_t>
GLOBALQUALIFIER void test_kernel(index_t N, const index_t P, index_t nCp, index_t * C)
{
  const index_t thid = blockIdx.x * blockDim.x + threadIdx.x;
  if(thid >= nCp) return;
  alg515(N, P, thid, C+(thid*P));
}

int main()
{
  // integer type to use
  typedef uint32_t index_t;

  // number of elements
  constexpr index_t N = 10;
  // number of elements in each combination
  constexpr index_t P = 3;
  // binomial coefficient
  const     index_t nCp = binom(N, P);

  printf("N=%u\tP=%u\tnCp=%u\n", N, P, nCp);

  // allocate memory for result
  index_t * C_h = (index_t*)malloc(sizeof(index_t)*nCp*P);
  index_t * C_d; cudaMalloc(&C_d, sizeof(index_t)*nCp*P); CUERR

  TIMERSTART(test)
  // start computation
  test_kernel<<<SDIV(nCp, 1024), 1024>>>(N, P, nCp, C_d); CUERR
  TIMERSTOP(test)

  cudaMemcpy(C_h, C_d, sizeof(index_t)*nCp*P, D2H); CUERR

  //check results
  #ifdef DEBUG
  for(index_t i = 0; i < nCp; i++)
  {
    printf("[ ");
    for(index_t j = 0; j < P; j++)
    {
      printf("%u ", C_h[i*P+j]);
    }
    printf("]\n");
  }
  #endif

  free(C_h);
  cudaFree(C_d); CUERR
}
