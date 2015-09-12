FROM debian:jessie
MAINTAINER 20uf <michael.coulleret@gmail.com>

# Install Curl and Git.
RUN apt-get -y update && \
    apt-get install -y sudo procps psmisc python-yaml python-jinja2 python-httplib2 && \
    apt-get install -y python-keyczar python-paramiko python-setuptools python-pkg-resources && \
    apt-get install -y git python-pip ansible locales wget

RUN rm /usr/sbin/policy-rc.d
RUN echo '[symfony]\nlocalhost\n' > /etc/ansible/hosts

# ssh
RUN mkdir /root/.ssh && \
  ssh-keyscan bitbucket.org  >> /root/.ssh/known_hosts && \
  ssh-keyscan github.com  >> /root/.ssh/known_hosts

# playbook
ADD ansible/ ansible/
RUN ansible-playbook ansible/playbook.yml -c local -vvv

# Port
EXPOSE 80 443

CMD service php5-fpm start && nginx