#!/bin/sh

set -x

TEST_TIME=$1
TEST_INTERFACE=$2
KEYSTONE_MAC=$3
ARNDALE_MAC=$4

cd ~/odp-demo
ls -al

ifconfig down $TEST_INTERFACE
ifconfig $TEST_INTERFACE hw ether $KEYSTONE_MAC
ifconfig $TEST_INTERFACE 172.16.0.101
ifconfig up $TEST_INTERFACE
arp -s 172.16.0.102 $ARNDALE_MAC
route add -net 172.16.0.0 netmask 255.255.0.0 dev $TEST_INTERFACE

ifconfig -a
arp -a
route

cd test/generator
./odp_generator -i $TEST_INTERFACE -a $KEYSTONE_MAC -b $ARNDALE_MAC -c 172.16.0.101 -d 172.16.0.102 | tee ~/gen.log &
cd ../receiver
./odp_receiver -i $TEST_INTERFACE -m 1 | tee ~/recv.log &

GPID=$(pidof odp_generator)
RPID=$(pidof odp_receiver)
sleep $TEST_TIME
kill -9 $TPID $RPID
cat ~/gen.log
cat ~/recv.log

echo "test_case_id:odp_generator result:pass"

