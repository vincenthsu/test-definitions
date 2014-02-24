#!/bin/sh

set -x

TEST_TIME=$1
TEST_INTERFACE=$2
KEYSTONE_MAC=$3
ARNDALE_MAC=$4

cd ~
git clone git://git.linaro.org/people/vincent.hsu/odp-demo.git -b keystone
cd odp-demo
make
ls -al

ifconfig up $TEST_INTERFACE
ifconfig $TEST_INTERFACE 10.10.10.101
arp -s 10.10.10.102 $ARNDALE_MAC
route add -net 10.10.10.0 netmask 255.255.255.0 dev eth1

ifconfig -a
arp -a
route

cd test/generator
./odp_generator -i $TEST_INTERFACE -a $KEYSTONE_MAC -b $ARNDALE_MAC -c 10.10.10.101 -d 10.10.10.102 | tee ~/gen.log &
cd ../receiver
./odp_receiver -i eth0 -m 1 | tee ~/recv.log &

GPID=$(pidof odp_generator)
RPID=$(pidof odp_receiver)
sleep $TEST_TIME
kill -9 $TPID $RPID
cat ~/gen.log
cat ~/recv.log

echo "test_case_id:odp_generator result:pass"

