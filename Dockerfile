ARG TAG=sid
FROM debian:${TAG}

# debian
RUN apt-get update -yq
RUN apt-get dist-upgrade -yq

# env
ENV DEBIAN_FRONTEND noninteractive
ENV RUNLEVEL 1
ENV TERM xterm-256color

# debconf
RUN apt-get install -yq debconf dialog libreadline8 libreadline-dev
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN dpkg-reconfigure debconf

# APP_USER
ENV APP_USER=debian
RUN echo "APP_USER=$APP_USER" > /etc/profile.d/app_user.sh
RUN apt-get install -yq zsh
RUN useradd -m $APP_USER -s /bin/zsh
RUN apt-get install -yq sudo
RUN echo "$APP_USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# ansible requirements
RUN apt-get install -yq python3

# ssh
ARG ssh_pub_host

RUN apt-get install -yq openssh-client openssh-server

RUN mkdir /home/$APP_USER/.ssh
RUN chmod 0700 /home/$APP_USER/.ssh

RUN echo "Host *" > /home/$APP_USER/.ssh/config
RUN chmod 0644 /home/$APP_USER/.ssh/config

RUN ssh-keygen -q -t rsa -N '' -f /home/$APP_USER/.ssh/id_rsa
RUN chmod 600 /home/$APP_USER/.ssh/id_rsa
RUN echo " IdentityFile /home/$APP_USER/.ssh/id_rsa" >> /home/$APP_USER/.ssh/config
RUN chmod 0644 /home/$APP_USER/.ssh/id_rsa.pub

RUN echo "$ssh_pub_host" > /home/$APP_USER/.ssh/authorized_keys
RUN chmod 0600 /home/$APP_USER/.ssh/authorized_keys

RUN chown -R $APP_USER: /home/$APP_USER/.ssh

RUN service ssh start

EXPOSE 22

CMD [ "/usr/sbin/sshd","-eD" ]
