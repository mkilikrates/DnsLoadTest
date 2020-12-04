#!/bin/bash
# Description: auto start dns load test
#
case "$1" in
 'start')
   rm -rf /tmp/dnsload.lock; rm -rf queryfile-example-10million-201202; wget https://www.dns-oarc.net/files/dnsperf/data/queryfile-example-10million-201202.gz; gunzip queryfile-example-10million-201202.gz; while [ ! -f /tmp/dnsload.lock ]; do echo -n "starting load test";date ; dnsperf -s $(cat /etc/resolv.conf | grep nameserver | awk '{print $2}') -a $(curl http://169.254.169.254/latest/meta-data/local-ipv4) -c 10000 -Q 1500 -d queryfile-example-10million-201202; sleep 5; done;;
 'stop')
   echo "Stoping load test"; touch /tmp/dnsload.lock; killall dnsperf;;
esac

