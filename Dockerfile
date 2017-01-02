# default build is for CentOS7, change the base image to fit your build.
FROM centos:centos7
MAINTAINER Sebastien Le Digabel "sledigabel@gmail.com"

RUN yum update -y
RUN yum install -y rpmdevtools mock
RUN if [ -f /etc/rpm/macros.dist ]; then sed -i 's,\(el[0-9]\).centos,\1,' /etc/rpm/macros.dist; fi

RUN cd /root && rpmdev-setuptree
ADD SOURCES/* /root/rpmbuild/SOURCES/
ADD SPECS/* /root/rpmbuild/SPECS/
RUN ln -s /root/rpmbuild/RPMS /RPMS

VOLUME ["/RPMS"]

CMD set -x && cd /root && spectool -g -R rpmbuild/SPECS/consul.spec && rpmbuild -ba rpmbuild/SPECS/consul.spec
