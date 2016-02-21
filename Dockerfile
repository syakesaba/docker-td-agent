FROM centos:centos7

MAINTAINER SYA-KE

ADD td-agent.repo /etc/yum.repos.d/td-agent.repo
ADD RPM-GPG-KEY-td-agent /etc/pki/rpm-gpg/RPM-GPG-KEY-td-agent
RUN yum -y update && yum -y install td-agent initscripts && yum clean all
RUN mkdir -p /var/locks/subsys && sed "s/\/var\/lock/\/var\/locks/g" -i /etc/init.d/td-agent
#RUN /usr/sbin/td-agent-gem install 
#VOLUME ["/etc/td-agent"]
ADD td-agent.conf /etc/td-agent/td-agent.conf
#CMD ["/etc/init.d/td-agent","start"]
ENTRYPOINT ["td-agent"]

##EXECUTE
#simple ps: docker exec -ti <process> ps -a

## RELOAD
#docker exec -ti <process> chroot ./ /bin/bash (/etc/init.d/td-agent reload)
