#!/bin/sh

set -x

TEST_TIME=$1
TEST_INTERFACE=$2
KEYSTONE_MAC=$3
ARNDALE_MAC=$4

cd /usr/share/odp
ls -al
insmod em_mod.ko

echo "unset the ip address"
ifconfig down $TEST_INTERFACE
ifconfig $TEST_INTERFACE hw ether $KEYSTONE_MAC
ifconfig $TEST_INTERFACE 0.0.0.0
sleep 10
ifconfig up $TEST_INTERFACE
ifconfig -a

./odp_generator -i $TEST_INTERFACE -a $KEYSTONE_MAC -b $ARNDALE_MAC -c 172.16.0.101 -d 172.16.0.102 &
./odp_receiver -i $TEST_INTERFACE -m 1 &

GPID=$(pidof odp_generator)
RPID=$(pidof odp_receiver)
sleep $TEST_TIME
kill -9 $TPID $RPID

echo "test_case_id:odp_generator result:pass"

