/*
 ============================================================================
 Author        : C. Aguirre
 Version       : 1.0
 Last modified : November 2023
 License       : Released under the GNU GPL 3.0
 Description   : CUDA program that prints "Hello world" from maximun global ID along with name and ID
 To build use  : nvcc <program_name>.cu -o <name> -arch=sm_75
 ============================================================================
 */

#include <stdio.h>

__global__ void hello()
{
    int threadID = blockIdx.x * blockDim.x + threadIdx.x;
    printf("Hello world from thread %d in block %d\n", threadID, blockIdx.x);
    if (threadID == 1023)
    {
        printf("ThreadID 1023 - Nombre: Cristian Aguirre, Carnet: 20231\n");
    }
}

int main()
{
    hello<<<2, 1024>>>();
    cudaThreadSynchronize(); // deprecated
    return 0;
}