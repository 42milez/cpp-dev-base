FROM ubuntu:18.04

RUN apt update \
    && apt install -y \
        apt-utils \
        build-essential \
        clang-9 \
        cmake \
        curl \
        gdb \
        gdbserver \
        git \
        linux-tools-generic \
        openssh-server \
        python3-pip \
        rsync \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip && python3 -m pip install --no-cache-dir conan==1.24.0

ENV SAN_SYMBOLIZER_PATH /usr/bin/llvm-symbolizer-9

CMD [ "/bin/bash" ]
