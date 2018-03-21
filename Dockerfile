FROM debian:stretch

MAINTAINER 0815chr1s

ENV FHEM_VERSION 5.8
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV TZ=Europe/Paris

# Install dependencies
RUN apt-get update && apt-get upgrade -y --force-yes && apt-get install -y --force-yes --no-install-recommends apt-utils
RUN apt-get -y --force-yes install \
apt-transport-https \
build-essential \
dfu-programmer \
etherwake \
git \
perl \
snmp \
snmpd \
sqlite3 \
sudo \
telnet \
usbutils \
vim \
wget

# Install perl packages
RUN apt-get -y --force-yes install \
mysql-client \
libalgorithm-merge-perl \
libauthen-oath-perl \
libavahi-compat-libdnssd-dev \
libcgi-pm-perl \
libclass-dbi-mysql-perl \
libclass-isa-perl \
libcrypt-cbc-perl \
libcrypt-ecb-perl \
libcrypt-urandom-perl \
libcgi-pm-perl \
libcommon-sense-perl \
libconvert-base32-perl \
libcrypt-urandom-perl \
libdata-dump-perl \
libdatetime-format-strptime-perl \
libdbd-sqlite3-perl \
libdbi-perl \
libdevice-serialport-perl \
libdigest-md5-perl \
libdpkg-perl \
liberror-perl \
libfile-copy-recursive-perl \
libfile-fcntllock-perl \
libgd-graph-perl \
libgd-text-perl \
libimage-info-perl \
libimage-librsvg-perl \
libio-socket-inet6-perl \
libio-socket-ip-perl \
libio-socket-multicast-perl \
libio-socket-ssl-perl \
libimage-info-perl \
libimage-librsvg-perl \
libjson-perl \
libjson-xs-perl \
liblist-moreutils-perl \
libmail-imapclient-perl \
libmail-sendmail-perl \
libmime-base64-perl \
libnet-telnet-perl \
libsoap-lite-perl \
libsocket-perl \
libsocket6-perl \
libswitch-perl \
libsys-hostname-long-perl \
libterm-readkey-perl \
libterm-readline-perl-perl \
libtext-csv-perl \
libtext-diff-perl \
libtimedate-perl \
libwww-perl \
#zyz
#libxml-perl \
#libxml-sax-perl \
#libwww-perl \
#libarchive-zip-perl \
#libcrypt-random-seed-perl \
#libcrypt-random-source-perl \
#libcrypt-rijndael-perl \
#libcrypt-ssleay-perl \
#libdatetime-locale-perl \
#libdatetime-perl \
#libdevice-serialport-perl \
#libgd-graph-perl \
#libhttp-server-simple-perl \
#libnet-telnet-perl \
#libio-socket-ssl-perl \
#libjson-perl \
#libnet-smtp-ssl-perl \
#libnet-ssleay-perl \
#libsoap-lite-perl \
#libhttp-request-params-perl \
#libnet-upnp-perl \
#libxml-parser-lite-perl \
#libfile-queue-perl \
#libio-socket-ip-perl \
#librpc-xml-perl \
#libtime-hires-perl \
#libtest-lwp-useragent-perl \
#libjson-perl \
#libsoap-lite-perl \
#libjson-xs-perl \
#libsys-statistics-linux-perl \
#libnet-snmp-perl \
#libio-socket-ssl-perl \
#libnet-ssleay-perl perl
#zyz
libxml-simple-perl

RUN cpan Crypt::Rijndael_PP
RUN cpan Net::MQTT::Simple
RUN cpan Net::MQTT::Constants

#ZYZ:
#RUN cpan MIME:Lite
#RUN cpan Net:SMTP:SSL
#RUN cpan Image::Grab
#RUN cpan XML::Parser::Lite
#zyz

# Install fhem
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN wget https://fhem.de/fhem-${FHEM_VERSION}.deb && dpkg -i fhem-${FHEM_VERSION}.deb
RUN userdel fhem

WORKDIR "/opt/fhem"

COPY fhem/start.sh ./

EXPOSE 8083 7072

CMD bash /opt/fhem/start.sh
 