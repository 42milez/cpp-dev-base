FROM ubuntu:18.04

RUN apt update                                \
    && apt install -y                         \
	    apt-utils=1.6.12                      \
	    build-essential=12.4ubuntu1           \
	    clang-9=1:9-2~ubuntu18.04.2           \
	    cmake=3.10.2-1ubuntu2.18.04.1         \
	    gdb=8.1-0ubuntu3.2                    \
	    gdbserver=8.1-0ubuntu3.2              \
	    openssh-server=1:7.6p1-4ubuntu0.3     \
		python3-pip=9.0.1-2.3~ubuntu1.18.04.1 \
	    rsync=3.1.2-2.1ubuntu1                \
	&& apt clean -y                           \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --upgrade pip && pip3 install --no-cache-dir conan=1.22.2

# see: https://docs.docker.com/engine/examples/running_ssh_service/
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE 'in users profile'
RUN echo 'export VISIBLE=now' >> /etc/profile

EXPOSE 22 7777

RUN useradd -ms /bin/bash dev
RUN echo 'dev:dev' | chpasswd

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]
