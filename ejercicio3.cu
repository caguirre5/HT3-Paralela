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

__global__ void process_data()
{
    int globalID = blockIdx.x * blockDim.x + threadIdx.x;
    int maxGlobalID = gridDim.x * blockDim.x - 1; // ID global máximo

    if (globalID == maxGlobalID)
    {
        printf("Hello world the maximum global ID %i: - Cristian Aguirre 20231\n", globalID);
    }
}

int main()
{
    int numData = 100000;
    int blockSize = 1024;

    int numBlocks = (numData + blockSize - 1) / blockSize;

    dim3 blocks(numBlocks, 1);
    dim3 threadsPerBlock(blockSize, 1);

    process_data<<<blocks, threadsPerBlock>>>();
    cudaDeviceSynchronize();

    return 0;
}
