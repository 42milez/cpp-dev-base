FROM ubuntu:18.04

RUN apt update                                \
    && apt install -y                         \
        apt-utils=1.6.12                      \
        build-essential=12.4ubuntu1           \
        clang-9=1:9-2~ubuntu18.04.2           \
        cmake=3.10.2-1ubuntu2.18.04.1         \
        gdb=8.1-0ubuntu3.2                    \
        gdbserver=8.1-0ubuntu3.2              \
        git=1:2.17.1-1ubuntu0.5               \
        openssh-server=1:7.6p1-4ubuntu0.3     \
        python3-pip=9.0.1-2.3~ubuntu1.18.04.1 \
        rsync=3.1.2-2.1ubuntu1                \
    && apt clean -y                           \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip && python3 -m pip install --no-cache-dir conan==1.22.2

ENV SAN_SYMBOLIZER_PATH /usr/bin/llvm-symbolizer-9

CMD [ "/bin/bash" ]
