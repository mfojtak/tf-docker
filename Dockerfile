FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL version="1.1"
RUN apt-get update && apt-get install -y wget && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    apt remove -y python 3.6 python3.5 python2.7 python-minimal && apt autoremove -y && apt-get clean -y && \
    cp /opt/conda/bin/python /usr/bin/python
ENV PATH /opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /opt/conda/lib:$LD_LIBRARY_PATH
RUN pip install tf-nightly-gpu-2.0-preview && \
    pip install https://github.com/mfojtak/mfojtak.github.io/blob/master/tensorflow_addons-0.2.0.dev0-cp37-cp37m-linux_x86_64.whl?raw=true
