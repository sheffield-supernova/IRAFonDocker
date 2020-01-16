FROM centos:centos7
RUN yum install libXft -y
RUN yum install libX* -y
RUN yum install wget -y
WORKDIR cd home
RUN wget http://ds9.si.edu/download/centos7/ds9.centos7.8.0.1.tar.gz
RUN tar zxvf ds9.centos7.8.0.1.tar.gz
CMD ["/bin/bash"]

