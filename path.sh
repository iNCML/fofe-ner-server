#!/bin/bash

export LANG=C
export EXPT="/eecs/research/asr/mingbin/ner-advance"
export LOCAL_SCRIPT=${EXPT}/scripts

##############
# CUDA-related

export CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES:-""}

if [ `hostname` == "image" ] || [ `hostname` == "voice" ] || [ `hostname` == "audio" ]
then
    export CUDA_HOME="/eecs/local/pkg/cuda-8.0.44"
else
    export CUDA_HOME="/eecs/local/pkg/cuda"
fi

export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
# export LD_LIBRARY_PATH=/eecs/research/asr/Shared/cuDNN/lib64:${LD_LIBRARY_PATH}


#############
# GCC-related

export PATH=/eecs/research/asr/mingbin/gcc-4.9/bin:${PATH}
export LIBRARY_PATH=/eecs/research/asr/mingbin/gcc-4.9/lib64
export LD_LIBRARY_PATH=/eecs/research/asr/mingbin/gcc-4.9/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/eecs/research/asr/mingbin/mkl/mkl/lib/intel64:${LD_LIBRARY_PATH}
export OMP_NUM_THREADS=32
export MKL_NUM_THREADS=32 


################
# PYTHON-related

source /eecs/research/asr/mingbin/python-workspace/hopeless/bin/activate
export PYTHONPATH=${EXPT}:${LOCAL_SCRIPT}
export NLTK_DATA=/eecs/research/asr/mingbin/nltk-data


###############
# debug-related

export KNRM="\x1B[0m"
export KRED="\x1B[31m"
export KGRN="\x1B[32m"
export KYEL="\x1B[33m"
export KBLU="\x1B[34m"
export KMAG="\x1B[35m"
export KCYN="\x1B[36m"
export KWHT="\x1B[37m"

function INFO() {
    msg="$@"
    printf "${KGRN}"
    printf "`date +"%Y-%m-%d %H-%M-%S"` [INFO]: ${msg}\n"
    printf "${KNRM}"
}
export -f INFO

function CRITICAL() {
    msg="$@"
    printf "${KRED}"
    printf "`date +"%Y-%m-%d %H-%M-%S"` [CRITICAL]: ${msg}\n"
    printf "${KNRM}"
}
export -f CRITICAL


function GivePerm {
    dir=${1}
    find ${dir} -perm 700 -exec chmod 755 '{}' \;
    find ${dir} -perm 600 -exec chmod 644 '{}' \;
    upper=$(cd ${dir}; pwd)
    while [ ${upper} != '/' ]
    do
        chmod 755 ${upper} 2> /dev/null
        upper=$(dirname ${upper})
    done
}
export -f GivePerm


