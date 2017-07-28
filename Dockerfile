## Modified by Sam KUON - 04/07/17
FROM centos:latest
MAINTAINER Sam KUON "sam.kuonssp@gmail.com"

# System timezone
ENV TZ=Asia/Phnom_Penh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install repository, packages and update as needed
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y install http://yum.opennms.org/repofiles/opennms-repo-stable-rhel7.noarch.rpm && \
    yum-config-manager --disable opennms-repo-stable-common && \
    sed -ie '11i includepkgs=rrdtool rrdtool-perl' /etc/yum.repos.d/opennms-repo-stable-rhel7.repo && \
    rpm -Uvh https://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-14.ius.centos7.noarch.rpm
	
RUN yum clean all && \
	yum -y update && \
	yum -y install \
		php70u \
		php70u-opcache \
		php70u-mysqlnd \
		php70u-gd \
		php70u-posix \
		php70u-mcrypt \
		php70u-pear \
		php70u-json \
		php70u-xml \
		php70u-process \
		php70u-ldap \
		wget \
		httpd \
		cronie \
		net-snmp \
		net-snmp-utils \
		fping MySQL-python \
		libvirt \
		rrdtool \
		subversion \
		jwhois \
		ipmitool \
		graphviz \
		ImageMagick \
		supervisor

# Download Observium CE
RUN mkdir -p /srv/observium/{logs,rrd} && cd /srv && \
    wget http://www.observium.org/observium-community-latest.tar.gz && \
    tar xzvf observium-community-latest.tar.gz && \
    rm -rf observium-community-latest.tar.gz && \
    chown -R apache:apache /srv/observium

# Observium configuration
ADD ./conf.d/observium.conf /etc/httpd/conf.d/observium.conf
ADD ./conf.d/observium_cron /etc/cron.d/observium_cron
ADD ./conf.d/first_initialize.sh /usr/sbin/first_initialize.sh
ADD ./conf.d/supervisord.conf /etc/supervisord.conf
RUN chmod +x /usr/sbin/first_initialize.sh

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
