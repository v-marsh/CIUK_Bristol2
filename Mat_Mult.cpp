#pragma once
#include <time.h>
#include <iostream>

// generate int or float matrix
template <class M>
M** matrix_gen(int size){
    time_t t;
    srand((unsigned)time(&t));
    M** matrix = new M*[size];
    for(int i=0;i<size;i++){
        matrix[i]=new M[size];
        for (int j=0;j<size;j++){
            matrix[i][j]=static_cast<M>(rand())/static_cast<M>(RAND_MAX/100);
        }
    }
    return matrix;
}
template int** matrix_gen<int>(int size);
template float** matrix_gen<float>(int size);

// matrix multiplication
template<class M>
M** mat_mult(M** a, M** b, int size){
    M** c = new M*[size];
    for (int i=0;i<size;i++){
        c[i] = new M[size];
        for (int j=0;j<size;j++){
            c[i][j]=0;
            for (int k=0;k<size;k++)
            {
                c[i][j]+=a[i][k]*b[k][j];
            }
        }
    }
    return c;
}
template int** mat_mult<int>(int **a, int **b, int size);
template float** mat_mult<float>(float**a, float**b, int size);

// print out the matrix for debugging
template<class M>
void printMatrix(M** matrix, int size){
    for (int i=0;i<size;i++){
        for(int j=0;j<size;j++)
            std::cout<<matrix[i][j]<<"\t";
        std::cout<<"\n";
    } 
}
template void printMatrix<int>(int** matrix, int size);
template void printMatrix<float>(float** matrix, int size);

int main(int argc, char* argv[]){
    int size = atoi(argv[1]);  
    int** matrix = matrix_gen<int>(size);
    printMatrix<int>(matrix, size);
    float** matrix2 = matrix_gen<float>(size);
    printMatrix<float>(matrix2,size);
    int** c1 = mat_mult<int>(matrix,matrix, size);
    printMatrix<int>(c1, size);
    float** c2 = mat_mult<float>(matrix2, matrix2, size);
    printMatrix<float>(c2,size); 
    return 1;
}