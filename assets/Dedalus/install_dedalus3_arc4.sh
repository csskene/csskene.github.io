module load anaconda/2019.10
module switch openmpi intelmpi
module load fftw

export MPI_PATH=$MPI_HOME
export FFTW_PATH=$FFTW_HOME

source activate base
conda create -n dedalus3-arc4 -y python=3.11

conda activate dedalus3-arc4
conda install -y "libblas=*=*mkl" numpy scipy
export FFTW_STATIC=1
pip3 install cython
CC=mpicc pip3 install mpi4py
CC=mpicc pip3 install --no-cache --no-build-isolation http://github.com/dedalusproject/dedalus/zipball/master/