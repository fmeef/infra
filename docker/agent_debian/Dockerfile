FROM jenkins/agent:latest-jdk8 AS jenkins


FROM androidsdk/android-31:latest
COPY --from=jenkins /usr/share/jenkins /usr/share/jenkins
RUN apt update && apt install -y openjdk-8-jdk libnss3-tools usbutils \
  libccid libpcsclite-dev libssl-dev libreadline-dev autoconf \
	automake build-essential docbook-xsl xsltproc libtool pkg-config \
	autoconf-archiv flex libsystemd-dev libudev-dev libusb-dev polkit-dev
COPY PCSC /PCSC
RUN cd /PCSC && ./bootstrap && ./configure && make && make install
COPY OpenSC /OpenSC
RUN cd /OpenSC && ./bootstrap && ./configure --prefix=/usr --sysconfdir=/etc/opensc && make && make install
