FROM ubuntu:22.04 as builder
RUN apt-get update
RUN apt-get install -y meson gcc libc6-dev libsdl2-dev libopenal-dev \
                libpng-dev libjpeg-dev zlib1g-dev mesa-common-dev \
                libcurl4-gnutls-dev libx11-dev libxi-dev \
                libwayland-dev wayland-protocols libdecor-0-dev \
                libogg-dev libvorbis-dev wget git

# q2pro
RUN mkdir /opt/q2pro-src
WORKDIR /opt/q2pro-src
RUN wget https://skuller.net/q2pro/nightly/q2pro-source.tar.gz -O- | tar zxvf - -C /opt/q2pro-src --strip-components=1
RUN meson setup builddir
RUN meson configure -Dprefix=/opt/q2pro builddir
RUN meson compile -C builddir
RUN ninja -C builddir install

# opentdm
RUN mkdir /opt/opentdm
WORKDIR /opt/opentdm
RUN git clone https://github.com/packetflinger/opentdm.git .
RUN make

FROM ubuntu:22.04 as q2pro

MAINTAINER Przemyslaw Kadej "przemyslaw@kadej.org"
RUN useradd -m -s /bin/bash quake2
COPY --from=builder /opt/q2pro/ /opt/q2pro/
COPY --from=builder /opt/opentdm/ /opt/q2pro/opentdm/
ADD dist/ /opt/q2pro/share/q2pro/

WORKDIR /opt/q2pro/
RUN chown -R quake2:quake2 /opt/q2pro
RUN chown -R quake2:quake2 /home/quake2

USER quake2
EXPOSE 27910
#CMD bin/q2proded +exec opentdm.cfg +set dedicated 1 +set deathmatch 1
COPY --chown=quake2:quake2 q2proded.sh .
CMD ["/bin/bash", "q2proded.sh"]
