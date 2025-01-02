---
layout: post
title:  "Getting started with Dedalus v3 at Leeds (ARC3/ ARC4)"
date:   2024-03-01 10:00:00 +0000
categories: tutorial
---

> :memo: **Update from 2-Jan-2025**. These instructions are out of date and may not currently work. Since ARC3/ ARC4 is immanently about to be replaced by Aire, I will not be updating them. However, I'll keep this page up in case the general procedure of installing Dedalus through pip3 is useful. I'll provide updated instructions for Aire when it becomes available.

Here is a quick guide describing how to setup a conda environment for [*Dedalus v3*](https://dedalus-project.readthedocs.io/en/latest/) on the [HPC](https://arcdocs.leeds.ac.uk/welcome.html) clusters *arc3* and *arc4* at Leeds. I'll describe the procedure for *arc4* and provide a summary of how it works for *arc3* (which is similar). I'll do my best to keep these instructions up to date as things change. Note, that these instructions are not the only way to install *Dedalus v3* on *arc3*/*arc4*, they are just the method that I know currently works.

## Installation on arc4

First of all, for these instructions I assume that the default modules are loaded on *arc4*. Typing `module list` should return
```
Currently Loaded Modulefiles:
  1) licenses        2) sge             3) intel/19.0.4    4) openmpi/3.1.4   5) user
```
The first step is to switch the `openmpi` module for the `intelmpi` module, and to load the `anaconda` and `fftw` modules, with 
```
module switch openmpi intelmpi
module load anaconda/2019.10
module load fftw
```

> :warning: There are a few anaconda modules on *arc4*. For *Dedalus* to work we must stick to the old default `anaconda/2019.10` as the new default has its own **mpi** which conflicts with our loaded `intelmpi` module. *Dedalus* installed with the **mpi** obtained by loading the default anaconda module will be extremely slow if code is run across more than one node. Similarly, if *Dedalus* is installed using the [recommended full-stack conda installation](https://dedalus-project.readthedocs.io/en/latest/pages/installation.html#installing-the-dedalus-package), performance will be poor across more than one node.

Now typing `module list` should return
```
Currently Loaded Modulefiles:
  1) licenses              2) sge                   3) intel/19.0.4          4) intelmpi/2019.4.243   5) user                  6) anaconda/2019.10      7) fftw/3.3.8
```
The final step before we setup our *Dedalus* conda environment is to set the following environmental variables
```
export MPI_PATH=$MPI_HOME
export FFTW_PATH=$FFTW_HOME
```
to let *Dedalus* know where **mpi** and **fftw** are situated.

To setup a *Dedalus v3* conda environment, first activate the base conda environment, then create a conda environment with *python v3.11*, and then activate this new environment by running
```
source activate base
conda create -n dedalus3-arc4 -y python=3.11
conda activate dedalus3-arc4 
```
Before installing *Dedalus* we first need to install *numpy*, *scipy*, *cython*, and *mpi4py*. To install *numpy* and *scipy*, with linear algebra handled by **mkl**, we use *conda*
```
conda install -y "libblas=*=*mkl" numpy scipy
export FFTW_STATIC=1
```
> :warning: This step can take a while so there is plenty of time for a :coffee:

Now install *cython* and *mpi4py* with *pip*
```
pip3 install cython
CC=mpicc pip3 install mpi4py
```
With all these packages installed we can now install *Dedalus* with 
```
CC=mpicc pip3 install --no-cache --no-build-isolation http://github.com/dedalusproject/dedalus/zipball/master/
```

\\
And that's it! To test that the *Dedalus* environment works, run the tests with
```
python3 -m dedalus test
```

These instructions are summarised in this [shell scipt](/assets/Dedalus/install_dedalus3_arc4.sh) which can be run with 
```
source install_dedalus3_arc4.sh
```
to automate the whole procedure.

## Installation on arc3
Installation on *arc3* is similar except that we use *pip* for installing all dependencies and **mkl** is not used. A summary is available [here](/assets/Dedalus/install_dedalus3_arc3.sh) and can be run with 
```
source install_dedalus3_arc3.sh
```
Again, the instructions assume that the default modules are loaded, i.e. typing `module list` returns
```
Currently Loaded Modulefiles:
  1) licenses        2) sge             3) intel/17.0.1    4) openmpi/2.0.2   5) user
```
## Running a job

When running a job with this environment, before you run the *Dedalus* script it is recommended to set the following environmental variables
```
export NUMEXPR_MAX_THREADS=1
export OMP_NUM_THREADS=1
```

You also need to make sure that in the job script the correct modules are loaded with
```
module switch openmpi intelmpi
module load anaconda/2019.10
source activate dedalus3-arc4
```

### Acknowledgements
I'd like to thank [Dr. Chris Wareing](http://www.cjwareing.net) for all his help in creating these instructions, as well as the rest of Prof. Steve Tobias' group in finding all the pitfulls involved in installing *Dedalus*.