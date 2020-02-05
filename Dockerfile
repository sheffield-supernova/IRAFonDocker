#FROM centos:centos7
FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]
RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install apt-utils -y
RUN apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 -y
RUN apt-get install multiarch-support -y
RUN apt-get install wget -y
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
#RUN yum install glibc.i686 -y
#RUN yum install libXft -y
#RUN yum install libX* -y
#RUN apt-get install libXft -y
RUN apt-get install libxft-dev -y
RUN apt-get install libx11-dev -y
#RUN yum install wget -y
#WORKDIR home
#RUN wget http://ds9.si.edu/download/centos7/ds9.centos7.8.0.1.tar.gz
#RUN tar zxvf ds9.centos7.8.0.1.tar.gz
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh -b -p /home/miniconda
RUN echo 'eval "$(/home/miniconda/bin/conda shell.bash hook)"' > /root/.bashrc
RUN /bin/bash /root/.bashrc
RUN /bin/bash -c "source /root/.bashrc \
      && conda update -n base -c defaults conda \
      && conda config --add channels http://ssb.stsci.edu/astroconda \
      && conda create -n iraf27 python=2.7 iraf-all pyraf-all stsci -y \
      && /bin/bash"

RUN echo 'eval "$(/home/miniconda/bin/conda shell.bash hook)"' > /home/.profile
CMD ["/bin/bash"]
