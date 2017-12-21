#This docker copy from https://github.com/mikenowak/docker-nrpe
FROM alpine:edge

RUN apk add --no-cache perl ruby ruby-json nrpe nagios-plugins-procs nagios-plugins-time nagios-plugins-load nagios-plugins-swap nagios-plugins-disk perl-date-format sudo

ADD check_file.pl check_files.pl check_memory check_time_skew check_oxidized.rb /usr/lib/nagios/plugins/
ADD nrpe.cfg /etc/nrpe.cfg
RUN echo "nagios ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
#ADD check_files.pl /usr/lib/nagios/plugins/
ADD entrypoint.sh /entrypoint.sh

EXPOSE 5666

CMD /entrypoint.sh
