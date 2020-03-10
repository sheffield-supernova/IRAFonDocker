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
      && conda create -n iraf27 python=2.7 iraf-all pyraf-all stsci -y \
      && conda create -n geminiconda python=2.7 gemini stsci iraf-all pyraf-all \
      && /bin/bash"

RUN echo 'eval "$(/home/miniconda/bin/conda shell.bash hook)"' > /home/.profile
RUN mkdir /home/iraf/
RUN mkdir /tmp/iraf/

CMD ["/bin/bash"]
