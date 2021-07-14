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

RUN python3 -m pip install --no-cache-dir --upgrade pip \
  && python3 -m pip install --no-cache-dir conan==1.33.0

RUN echo 'kernel.perf_event_paranoid=-1' >> /etc/sysctl.d/99-perf.conf && \
  echo 'kernel.kptr_restrict=0' >> /etc/sysctl.d/99-perf.conf

ENV SAN_SYMBOLIZER_PATH /usr/bin/llvm-symbolizer-9

CMD [ "/bin/bash" ]
