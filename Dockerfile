# Use the official image as a parent image.
FROM gcc:10

# Set up a tools dev directory
WORKDIR /home/dev

#download and unarchive 
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 \
    && tar xvf gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 \
    && rm gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2

# Set up the compiler path
ENV PATH $PATH:/home/dev/gcc-arm-none-eabi-9-2019-q4-major/bin

RUN wget https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v14.x.x/nRF5_SDK_14.0.0_3bcc1f7.zip \
    && unzip nRF5_SDK_14.0.0_3bcc1f7.zip \
    && rm nRF5_SDK_14.0.0_3bcc1f7.zip

ENV NORDIC_PATH /home/dev/nRF5_SDK_14.0.0_3bcc1f7

# RUN arm-none-eabi-gcc --version

WORKDIR /project

COPY entrypoint.sh /project/entrypoint.sh
RUN chmod +x /project/entrypoint.sh 

ENTRYPOINT [ "/project/entrypoint.sh" ]

