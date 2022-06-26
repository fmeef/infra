FROM jenkins/agent:latest-jdk8 AS jenkins


FROM androidsdk/android-31:latest AS droid

FROM fedora:36
COPY --from=jenkins /usr/share/jenkins /usr/share/jenkins
COPY --from=droid /opt/android-sdk-linux /opt/android-sdk-linux
RUN dnf install -y opensc java-1.8.0-openjdk-devel java-11-openjdk-devel git && dnf groupinstall -y "Development Tools" &&  update-alternatives --set java java-11-openjdk.x86_64
COPY smartcard.cfg /etc/smartcard.cfg
