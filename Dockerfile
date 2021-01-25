# BSD 3-Clause License

# Copyright (c) 2017, Juliano Petronetto
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.

# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.

# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

FROM debian:stretch-slim

LABEL maintainer="Simon Struck <simon@simonscode.org>" \
      name="Docker Python Deep Learning" \
      description="Docker container for Python Deep Learning, with almost everything that you may need." \
      vcs-url="https://github.com/AnyTimeTraveler/docker-python-deep-learning" \
      version="1.2"

ENV BUILD_PACKAGES="\
        build-essential \
        linux-headers-4.9 \
        cmake \
        tcl-dev \
        xz-utils \
        zlib1g-dev \
        libssl-dev \
        libncurses5-dev \
        libsqlite3-dev \
        libreadline-dev \
        libtk8.5 \
        libgdm-dev \
        libdb4o-cil-dev \
        libpcap-dev \
        git \
        wget \
        curl \
        libffi-dev \
        libbz2-dev \
        liblzma-dev" \
    APT_PACKAGES="\
        ca-certificates \
        openssl \
        sqlite3 \
        bash \
        graphviz \
        fonts-noto \
        libpng16-16 \
        libfreetype6 \
        libjpeg62-turbo \
        libgomp1" \
    PIP_PACKAGES="\
        pyyaml \
        pymkl \
        cffi \
        h5py \
        requests \
        pillow \
        graphviz \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        seaborn \
        matplotlib \
        jupyter \
        xgboost \
        tensorflow \
        keras \
        torch \
        torchvision \
        mxnet-mkl \
        PyMySQL" \
    PYTHON_VER=3.8.7 \
    JUPYTER_CONFIG_DIR=/home/.ipython/profile_default/startup \
    LANG=C.UTF-8

RUN set -ex; \
    apt-get update -y; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends ${APT_PACKAGES}; \
    apt-get install -y --no-install-recommends ${BUILD_PACKAGES}; \
    cd /tmp && wget https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz; \
    tar xvf Python-${PYTHON_VER}.tgz; \
    cd Python-${PYTHON_VER}; \
    ./configure --enable-optimizations && make -j8 && make altinstall; \
    rm /usr/local/bin/python || true; \
    ln -s /usr/local/bin/python3.8 /usr/local/bin/python; \
    rm /usr/local/bin/pip || true; \
    ln -s /usr/local/bin/pip3.8 /usr/local/bin/pip; \
    rm /usr/local/bin/idle || true; \
    ln -s /usr/local/bin/idle3.8 /usr/local/bin/idle; \
    rm /usr/local/bin/pydoc || true; \
    ln -s /usr/local/bin/pydoc3.8 /usr/local/bin/pydoc; \
    rm /usr/local/bin/python-config || true; \
    ln -s /usr/local/bin/python3.8m-config /usr/local/bin/python-config; \
    rm /usr/local/bin/pyvenv || true; \
    ln -s /usr/local/bin/pyvenv-3.8 /usr/local/bin/pyvenv; \
    pip install -U -V pip; \
    pip install -U -v setuptools wheel; \
    pip install -U -v ${PIP_PACKAGES}; \
    apt-get remove --purge --auto-remove -y ${BUILD_PACKAGES}; \
    apt-get clean; \
    apt-get autoclean; \
    apt-get autoremove; \
    rm -rf /tmp/* /var/tmp/*; \
    rm -rf /var/lib/apt/lists/*; \
    rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin; \
    find / -name __pycache__ | xargs rm -r; \
    rm -rf /root/.[acpw]*; \
    pip install jupyter && jupyter nbextension enable --py widgetsnbextension; \
    mkdir -p ${JUPYTER_CONFIG_DIR}; \
    echo "import warnings" | tee ${JUPYTER_CONFIG_DIR}/config.py; \
    echo "warnings.filterwarnings('ignore')" | tee -a ${JUPYTER_CONFIG_DIR}/config.py; \
    echo "c.NotebookApp.token = u''" | tee -a ${JUPYTER_CONFIG_DIR}/config.py

WORKDIR /home/notebooks

EXPOSE 8888

CMD [ "jupyter", "notebook", "--port=8888", "--no-browser", \
    "--allow-root", "--ip=0.0.0.0", "--NotebookApp.token=" ]
