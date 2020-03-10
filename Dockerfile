#FROM centos:centos7
FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]
RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install apt-utils -y
RUN apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 -y
RUN apt-get install multiarch-support -y
RUN apt-get install wget -y

RUN apt-get install libxft-dev -y
RUN apt-get install libx11-dev -y

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh -b -p /home/miniconda
RUN echo 'eval "$(/home/miniconda/bin/conda shell.bash hook)"' > /root/.bashrc
RUN /bin/bash /root/.bashrc
RUN /bin/bash -c "source /root/.bashrc \
      && conda update -n base -c defaults conda \
      && conda config --add channels http://ssb.stsci.edu/astroconda \
      && conda create -n iraf27 python=2.7 iraf-all pyraf-all stsci gemini -y \
      && /bin/bash"

RUN echo 'eval "$(/home/miniconda/bin/conda shell.bash hook)"' > /home/.profile
RUN mkdir /home/iraf/

WORKDIR /home/iraf
COPY login.cl.dk ./login.cl

RUN mkdir /home/iraf/uparm
RUN mkdir /tmp/iraf/
RUN mkdir /data
WORKDIR /home/iraf

CMD ["/bin/bash"]
CMD ["source activate iraf27"]
