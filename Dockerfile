FROM alpine:3.7
MAINTAINER Izhar ul Hassan "ezhaar@gmail.com"
COPY requirements.txt /tmp/
RUN apk add --no-cache ca-certificates \
    libstdc++ \
    krb5 \
    openblas \
    libffi \
    libpng \
    freetype \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools
RUN apk --no-cache add --virtual build-deps \
    python3-dev \
    build-base \
    clang \
    openblas-dev \
    krb5-dev \
    libffi-dev \
    openssl-dev \
    libpng-dev \
    freetype-dev && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt && \
    jupyter-kernelspec install $(pip3 show sparkmagic | grep -i location | awk '{print $2}')/sparkmagic/kernels/pyspark3kernel && \
    jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter serverextension enable --py sparkmagic && \
    apk del build-deps 
RUN rm -r /root/.cache
COPY start_notebook.sh /root/
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_config.py 
WORKDIR /root/notebook
CMD ["/root/start_notebook.sh"]
