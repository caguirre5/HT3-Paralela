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
    int myID = (blockIdx.z * gridDim.x * gridDim.y +
                blockIdx.y * gridDim.x +
                blockIdx.x) *
                   blockDim.x * blockDim.y * blockDim.z +
               threadIdx.z * blockDim.x * blockDim.y +
               threadIdx.y * blockDim.x +
               threadIdx.x;

    // // Calculate the global thread ID
    // int myID = ( blockIdx.z * gridDim.x * gridDim.y +
    //              blockIdx.y * gridDim.x +
    //              blockIdx.x ) * blockDim.x +
    //              threadIdx.x;

    printf("Hello world from thread %i: - Cristian Aguirre 20231\n", myID);
}

int main()
{
    dim3 g(4, 2);
    dim3 b(32, 16);
    hello<<<g, b>>>();
    cudaDeviceSynchronize();
    return 0;
}
