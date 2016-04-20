FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
MAINTAINER “Emory Merryman” emory.merryman+DoTDeCocXJroqaWu@gmail.com>
USER root
RUN dnf update --assumeyes && dnf install --assumeyes byobu git emacs* dbus curl && dnf update --assumeyes && dnf clean all
RUN dbus-uuidgen > /var/lib/dbus/machine-id
USER ${LUSER}
RUN mkdir --parents /home/${LUSER}/.ssh /home/${LUSER}/working/desertedscorpion && chmod 0700 .ssh
COPY id_rsa.pub /home/${LUSER}/.ssh/id_rsa.pub
COPY config /home/${LUSER}/.ssh/config
RUN chmod 0600 .ssh/id_rsa .ssh/config
CMD curl https://api.github.com/orgs/desertedscorpion/repos grep "git_url" | sed -e "s#^\s*\"git_url\":\s*\"##" -e "s#\",\$##" | while read REPO; do git -C working/desertedscorpion clone ${REPO}; done && /usr/bin/byobu
