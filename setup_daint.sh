#export CXX=CC
export FC=gfortran

module use /apps/daint/UES/hackaton/modules/all
module load CUDAcore/11.7.1
module load gcc

export MADGRAPH_CUARCHFLAGS="--gpu-architecture=compute_60 --gpu-code=sm_60"
