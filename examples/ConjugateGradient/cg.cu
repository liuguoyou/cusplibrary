#include <cusp/csr_matrix.h>
#include <cusp/io.h>
#include <cusp/krylov/cg.h>

// where to perform the computation
typedef cusp::device_memory MemorySpace;

int main(void)
{
    // create an empty sparse matrix structure (HYB format)
    cusp::hyb_matrix<int, float, MemorySpace> A;

    // load a matrix stored in MatrixMarket format
    cusp::read_matrix_market_file(A, "5pt_10x10.mtx");

    // allocate storage for solution (x) and right hand side (b)
    cusp::array1d<float, MemorySpace> x(A.num_rows, 0);
    cusp::array1d<float, MemorySpace> b(A.num_rows);

    // initialize right hand side
    for(int i = 0; i < A.num_rows; i++)
        b[i] = i % 2;
   
    // obtain a linear operator from matrix A and call CG
    cusp::krylov::cg(A, x, b, 1e-5f, 1000, 1);

    return 0;
}

