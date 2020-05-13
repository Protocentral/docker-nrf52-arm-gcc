# Use the official image as a parent image.
FROM gcc:10

# Set up a tools dev directory
WORKDIR /home/dev

ENV NORDIC_PATH /home/dev/nRF5_SDK_14.0.0_3bcc1f7

ENV RELEASE_NAME v1.2.0

#download and unarchive 
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 \
    && tar xvf gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 \
    && rm gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2

# Set up the compiler path
ENV PATH $PATH:/home/dev/gcc-arm-none-eabi-9-2019-q4-major/bin

WORKDIR ${NORDIC_PATH}

RUN wget https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v14.x.x/nRF5_SDK_14.0.0_3bcc1f7.zip \
    && unzip nRF5_SDK_14.0.0_3bcc1f7.zip \
    && rm nRF5_SDK_14.0.0_3bcc1f7.zip

RUN ls /home/dev

RUN sed -i "s/GNU_INSTALL_ROOT := \/usr\/local\/gcc-arm-none-eabi-4_9-2015q3\/bin\//GNU_INSTALL_ROOT := \/home\/dev\/gcc-arm-none-eabi-9-2019-q4-major\/bin\//" ${NORDIC_PATH}/components/toolchain/gcc/Makefile.posix 

RUN cat ${NORDIC_PATH}/components/toolchain/gcc/Makefile.posix

RUN apt-get update -y
RUN apt-get install -y python3
RUN apt-get install -y python-pip

RUN pip install nrfutil

# RUN arm-none-eabi-gcc --version

WORKDIR /home/project

COPY entrypoint.sh /project/entrypoint.sh
RUN chmod +x /project/entrypoint.sh 

ENTRYPOINT [ "/project/entrypoint.sh" ]


