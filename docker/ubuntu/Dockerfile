FROM ubuntu:18.04
#MAINTAINER Getty Images "https://github.com/gettyimages"

RUN apt-get update \
 && apt-get install --no-install-recommends -y locales iputils-ping inetutils-telnet net-tools curl \
    python3 python3-setuptools python3-pip \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen en_US.UTF-8 \
 && /usr/sbin/update-locale LANG=en_US.UTF-8 \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && ln -s /usr/bin/python3 /usr/bin/python \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Users with other locales should set this in their derivative image
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PYTHONHASHSEED=0 \
    PYTHONIOENCODING=UTF-8 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    JAVA_MAJOR_VERSION=8 \ 
    JAVA_UPDATE_VERSION=172 \
    JAVA_BUILD_NUMBER=11

# JAVA
ENV JAVA_HOME=/opt/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION} \
    PATH=/opt/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}/bin:$PATH

RUN mkdir $JAVA_HOME && curl -fSL --retry 3 --insecure --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/a58eab1ec242421181065cdc37240b08/jdk-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | tar --strip-components=1 -zxf - -C $JAVA_HOME \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man /tmp/* /var/tmp/*


CMD ["/bin/bash"]