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

# systemd
RUN apt-get install -yq systemd systemd-sysv
FROM debian:${TAG}
COPY --from=0 / /
ENV container docker
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock" ]

# locales
RUN apt-get install -yq locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" >> /etc/locale.conf
RUN locale-gen en_US.UTF-8

# curl
RUN apt-get install -yq ca-certificates curl

# APP_USER
ENV APP_USER=debian
RUN echo "APP_USER=$APP_USER" > /etc/profile.d/app_user.sh
RUN useradd -m $APP_USER -s /bin/bash
RUN apt-get install -yq sudo
RUN echo "$APP_USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# .bashrc
RUN curl -fsSL https://git.io/JUROW -o /root/.bashrc
RUN curl -fsSL https://git.io/JUROW -o /home/$APP_USER/.bashrc
RUN chmod 644 /home/$APP_USER/.bashrc

# MOTD
RUN rm -f /etc/motd

# vim
RUN apt-get install -yq vim
RUN	curl -fsSL https://git.io/JUROM -o /etc/vim/vimrc.local
RUN echo "GIT_EDITOR=vim" > /etc/profile.d/git.sh

# Timezone
RUN rm -f /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# ssh
ARG ssh_prv_key
ARG ssh_pub_key

RUN apt-get install -yq openssh-client openssh-server

RUN mkdir /home/$APP_USER/.ssh
RUN chmod 700 /home/$APP_USER/.ssh

RUN curl -fsSL https://git.io/JURcF -o /home/$APP_USER/.ssh/config
RUN chmod 644 /home/$APP_USER/.ssh/config

RUN ssh-keyscan github.com > /home/$APP_USER/.ssh/known_hosts
RUN chmod 644 /home/$APP_USER/.ssh/known_hosts

RUN ssh-keygen -q -t rsa -N '' -f /home/$APP_USER/.ssh/id_rsa
RUN chmod 600 /home/$APP_USER/.ssh/id_rsa
RUN echo " IdentityFile /home/$APP_USER/.ssh/id_rsa" >> /home/$APP_USER/.ssh/config
RUN chmod 644 /home/$APP_USER/.ssh/id_rsa.pub

RUN echo "$ssh_prv_key" > /home/$APP_USER/.ssh/id_host
RUN chmod 600 /home/$APP_USER/.ssh/id_host
RUN echo " IdentityFile /home/$APP_USER/.ssh/id_host" >> /home/$APP_USER/.ssh/config

RUN echo "$ssh_pub_key" > /home/$APP_USER/.ssh/id_host.pub
RUN chmod 644 /home/$APP_USER/.ssh/id_host.pub

RUN cp /home/$APP_USER/.ssh/id_host.pub /home/$APP_USER/.ssh/authorized_keys

RUN chown -R $APP_USER: /home/$APP_USER/.ssh

# ruby
RUN apt-get install -yq ruby

# git
RUN apt-get install -yq git-core
RUN git config --global core.editor vim
RUN git config --global core.pager less
RUN curl -fsSL https://git.io/JURsx -o /home/$APP_USER/.gitconfig

# redis
RUN apt-get install -yq redis-server
RUN curl -fsSL https://git.io/JURWX -o /etc/redis/redis.conf

# PostgreSQL
RUN apt-get install -yq postgresql-12
RUN echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/12/main/pg_hba.conf

# openjdk-8-jdk
RUN apt-get install -yq openjdk-8-jdk

# elastic dependencies
RUN apt-get install -yq wget gnupg
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get install -yq apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
RUN apt-get update -yq

# filebeat
RUN apt-get install -yq filebeat
RUN curl -fsSL https://git.io/JUETg -o /etc/filebeat/filebeat.yml

# rsyslog
RUN apt-get install -yq rsyslog
RUN echo "*.* @@172.28.5.0:4000" > /etc/rsyslog.d/logstash.conf

# solr
RUN apt-get install -yq solr-jetty

# system init
CMD [ "/sbin/init" ]
