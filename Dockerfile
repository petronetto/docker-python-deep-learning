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

LABEL maintainer="Juliano Petronetto <juliano@petronetto.com.br>" \
      name="Docker Python Deep Learning" \
      description="Docker container for Python Deep Learning, with almost everything that you may need." \
      url="https://hub.docker.com/r/petronetto/docker-python-deep-learning" \
      vcs-url="https://github.com/petronetto/docker-python-deep-learning" \
      vendor="Petronetto DevTech" \
      version="1.0"

ENV BUILD_PACKAGES="\
        build-essential \
        linux-headers-4.9 \
        python3-dev \
        cmake \
        tcl-dev \
        xz-utils \
        zlib1g-dev \
        git \
        curl" \
    APT_PACKAGES="\
        ca-certificates \
        openssl \
        bash \
        graphviz \
        fonts-noto \
        libpng16-16 \
        libfreetype6 \
        libjpeg62-turbo \
        libgomp1 \
        python3 \
        python3-pip" \
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
        http://download.pytorch.org/whl/cpu/torch-0.3.0.post4-cp35-cp35m-linux_x86_64.whl \
        torchvision \
        mxnet-mkl" \
    PYTHON_VERSION=3.6.4 \
    PATH=/usr/local/bin:$PATH \
    PYTHON_PIP_VERSION=9.0.1 \
    JUPYTER_CONFIG_DIR=/home/.ipython/profile_default/startup \
    LANG=C.UTF-8

RUN set -ex; \
    apt-get update -y; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends ${APT_PACKAGES}; \
    apt-get install -y --no-install-recommends ${BUILD_PACKAGES}; \
    ln -s /usr/bin/idle3 /usr/bin/idle; \
    ln -s /usr/bin/pydoc3 /usr/bin/pydoc; \
    ln -s /usr/bin/python3 /usr/bin/python; \
    ln -s /usr/bin/python3-config /usr/bin/python-config; \
    ln -s /usr/bin/pip3 /usr/bin/pip; \
    pip install -U -v setuptools wheel; \
    pip install -U -v ${PIP_PACKAGES}; \
    apt-get remove --purge --auto-remove -y ${BUILD_PACKAGES}; \
    apt-get clean; \
    apt-get autoclean; \
    apt-get autoremove; \
    rm -rf /tmp/* /var/tmp/*; \
    rm -rf /var/lib/apt/lists/*; \
    rm -f /var/cache/apt/archives/*.deb \
        /var/cache/apt/archives/partial/*.deb \
        /var/cache/apt/*.bin; \
    find /usr/lib/python3 -name __pycache__ | xargs rm -r; \
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
