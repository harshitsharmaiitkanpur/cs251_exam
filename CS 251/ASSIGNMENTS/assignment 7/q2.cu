#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define NUM 100000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct num_array{
                    long long number;

};

__global__ void calculate(char *mem, long long num, long long i)
{
      long long z = (blockDim.x * blockIdx.x + threadIdx.x);
      long long size = z*i;

      if(size >= num)
        return;

      struct num_array *b = (struct num_array *)(mem + ((size+i-1) * sizeof(long long)));
      struct num_array *a = (struct num_array *)(mem + (size * sizeof(long long)));

        long long Xor;
        if(b->number!=-1)
		Xor = a->number ^ b->number;
        else
                Xor = a->number;

        if(z%2!=0)
		b->number = Xor;   
        else
                a->number = Xor;
      return;
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    long long c;
    struct num_array *pa;
    char *ptr;
    char *sptr;
    char *gpu_mem;
    long long num1 = NUM;
    long long blocks;
    long long seed;

    if(argc == 3)
    {
		num1 = atoi(argv[1]);
    	        seed = atoi(argv[2]);

    	        if(num1 <= 0)
        	   num1 = NUM;
    }

    blocks = num1 /1024;

    if(num1 % 1024)
        ++blocks;
    

    long long num2;
    num2 = num1;
    num1 = blocks*1024;

    srand(seed);
    ptr = (char *)malloc(num1 * sizeof(long long));
    sptr = ptr;

    for(c=0; c < num1; c++)
   {
       pa = (struct num_array *) sptr;
       pa->number = random();
       if(c>=num2)
                pa->number=-1;
       sptr += sizeof(long long);
    }


    gettimeofday(&t_start, NULL);

    cudaMalloc(&gpu_mem, num1 * sizeof(long long));
    CUDA_ERROR_EXIT("cudaMalloc");

    cudaMemcpy(gpu_mem, ptr, num1 * sizeof(long long) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");

    gettimeofday(&start, NULL);

    long long block1;
    num1 = num2;

    for(long long j=2;j<2*num1;j=2*j)
{
        block1=blocks/j;
        if(blocks%j)
            block1++;

    calculate<<<block1, 1024>>>(gpu_mem, num1, j);
    CUDA_ERROR_EXIT("kernel invocation");

}

    gettimeofday(&end, NULL);

    cudaMemcpy(ptr, gpu_mem, num1 * sizeof(long long) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);

    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);
    sptr = ptr;

    pa = (struct num_array *) (sptr);
    printf("result = %lld\n ", pa->number);

    free(ptr);
}


