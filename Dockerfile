FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
LABEL version="1.1"
RUN apt-get update && apt-get install -y wget git cmake && \
    echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    apt remove -y python 3.6 python3.5 python2.7 python-minimal && apt autoremove -y && apt-get clean -y && \
    cp /opt/conda/bin/python /usr/bin/python
ENV PATH /opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /opt/conda/lib:$LD_LIBRARY_PATH
#RUN git clone https://github.com/mfojtak/sentencepiece.git && cd sentencepiece/tensorflow && ./make_py_wheel.sh native
#COPY --from=tf_sentencepiece /sentencepiece/tensorflow/dist/tf_sentencepiece-0.1.83-py2.py3-none-manylinux1_x86_64.whl /
RUN pip install tensorflow && \
    pip install sentencepiece tensorflow-addons tensorflow-text
RUN git clone https://github.com/mfojtak/deco.git && cd deco && pip install .
