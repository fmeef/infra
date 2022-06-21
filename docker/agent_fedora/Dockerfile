FROM jenkins/agent:latest-jdk8 AS jenkins


FROM androidsdk/android-31:latest AS droid

FROM fedora:36
COPY --from=jenkins /usr/share/jenkins /usr/share/jenkins
COPY --from=droid /opt/android-sdk-linux /opt/android-sdk-linux
RUN dnf install -y opensc java-1.8.0-openjdk java-11-openjdk git && dnf groupinstall -y "Development Tools"
COPY smartcard.cfg /etc/smartcard.cfg

