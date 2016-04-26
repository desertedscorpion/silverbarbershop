FROM taf7lwappqystqp4u7wjsqkdc7dquw/heavytombstone
MAINTAINER “Emory Merryman” emory.merryman+DoTDeCocXJroqaWu@gmail.com>
USER root
COPY docker.repo /etc/yum.repos.d/docker.repo
RUN dnf update --assumeyes && dnf install --assumeyes byobu git emacs* dbus curl cronie docker-engine sudo systemd && dnf update --assumeyes && dnf clean all
RUN echo "${LUSER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${LUSER} && chmod 0444 /etc/sudoers.d/${LUSER}
RUN dbus-uuidgen > /var/lib/dbus/machine-id
RUN mkdir --parents /home/${LUSER}/.ssh /home/${LUSER}/working/desertedscorpion && chmod 0700 .ssh
COPY id_rsa /home/${LUSER}/.ssh/id_rsa
COPY config /home/${LUSER}/.ssh/config
COPY push_repos.sh /usr/local/bin/push_repos
RUN chown --recursive ${LUSER}:${LUSER} /home/${LUSER}/.ssh /home/${LUSER}/working && chmod 0600 /home/${LUSER}/.ssh/id_rsa /home/${LUSER}/.ssh/config && chmod 0555 /usr/local/bin/push_repos
USER ${LUSER}
RUN echo "* * * * * /usr/local/bin/push_repos /home/${LUSER}/working/desertedscorpion" | crontab - 
CMD curl https://api.github.com/orgs/desertedscorpion/repos | grep "git_url" | sed -e "s#^\s*\"git_url\":\s*\"##" -e "s#\",\$##" | while read REPO; do git -C working/desertedscorpion clone ${REPO}; done && /usr/bin/byobu
