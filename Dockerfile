FROM debian:jessie
MAINTAINER Michael COULLERET <michael@coulleret.pro>

# Install Curl and Git.
RUN apt-get -y update && \
    apt-get install -y sudo procps psmisc python-yaml python-jinja2 python-httplib2 && \
    apt-get install -y python-keyczar python-paramiko python-setuptools python-pkg-resources && \
    apt-get install -y git python-pip ansible locales wget

RUN rm /usr/sbin/policy-rc.d
RUN echo '[symfony]\nlocalhost\n' > /etc/ansible/hosts

# playbook
ADD ansible/ ansible/
RUN ansible-playbook ansible/playbook.yml -c local -vvv

# ssh
RUN mkdir /root/.ssh && \
  ssh-keyscan bitbucket.org  >> /root/.ssh/known_hosts && \
  ssh-keyscan github.com  >> /root/.ssh/known_hosts

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

# Port
EXPOSE 80 443

ADD web/ /vhost/current/web/

COPY ./start.sh /run/start.sh
WORKDIR /run
RUN chmod +x start.sh
CMD ["./start.sh"]
