
FROM ubuntu:latest
LABEL Name=ardour-build Version=0.1.0

ENV DEBIAN_FRONTEND noninteractive
ENV XARCH=x86_64
ENV ROOT=/ardour
ENV MAKEFLAGS=-j4

RUN apt-get update -y && apt-get install -y \
  wget \
  git \
  python2.7 \
  apt-utils \
  libglibmm-2.4-dev \
  # jack \
  # jackd \
  libarchive-dev \
  libasound2-dev \
  libaubio-dev \
  libboost-all-dev \
  libcurl4-gnutls-dev \
  libcwiid-dev \
  libfftw3-dev \
  libglib2.0-dev \
  libgtkmm-2.4-dev \
  # libjack-jackd2-dev \
  liblilv-dev \
  liblo-dev \
  liblrdf0-dev \
  librubberband-dev \
  libsamplerate-dev \
  libserd-dev \
  libsndfile1-dev \
  libsord-dev \
  libsratom-dev \
  libtag1-dev \
  libxml2-dev \
  lv2-dev \
  # qjackctl \
  libusb-1.0-0 \
  libusb-1.0-0-dev \
  vamp-plugin-sdk 


RUN ln -sf /usr/bin/python2.7 /usr/bin/python

VOLUME [ "/build" ]

RUN git clone git://git.ardour.org/ardour/ardour.git /ardour

WORKDIR /ardour

RUN git checkout tags/8.2
RUN ./waf configure -j $(nproc) --no-phone-home \
  && ./waf build test \
  && ./waf

# RUN wget http://www.mega-nerd.com/libsndfile/files/libsndfile-1.0.28.tar.gz
# RUN tar -xzvf libsndfile-1.0.28.tar.gz libsndfile-1.0.28
# RUN cd libsndfile-1.0.28 && configure && make && make install

# RUN /ardour/tools/x-win/compile.sh