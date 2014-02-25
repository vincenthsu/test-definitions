#!/bin/sh

set -x

TEST_TIME=$1
TEST_INTERFACE=$2
KEYSTONE_MAC=$3
ARNDALE_MAC=$4

cd ~
git clone git://git.linaro.org/people/vincent.hsu/odp-demo.git
cd odp-demo
make
ls -al

ifconfig $TEST_INTERFACE hw ether $ARNDALE_MAC
ifconfig up $TEST_INTERFACE
ifconfig $TEST_INTERFACE 10.10.10.102
arp -s 10.10.10.101 $KEYSTONE_MAC
route add -net 10.10.10.0 netmask 255.255.255.0 dev eth1

ifconfig -a
arp -a
route

cd test/packet
./odp_packet -i $TEST_INTERFACE -m 1 &

#PPID=$(pidof odp_packet)
#sleep $TEST_TIME
#kill -9 $PPID

echo "test_case_id:odp_loopback result:success"

