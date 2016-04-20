FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
MAINTAINER “Emory Merryman” emory.merryman+DoTDeCocXJroqaWu@gmail.com>
USER root
RUN dnf update --assumeyes && dnf install --assumeyes gnome-terminal git emacs* && dnf update --assumeyes && dnf clean all
USER ${LUSER}
RUN mkdir --parents .ssh working/desertedscorpion && chmod 0700 .ssh
COPY id_rsa.pub .ssh
COPY config .ssh
RUN chmod 0600 .ssh/id_rsa .ssh/config
WORKDIR working/desertedscorpion
CMD /usr/bin/gnome-terminal
