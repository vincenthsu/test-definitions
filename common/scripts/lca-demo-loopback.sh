#!/bin/sh

set -x

TEST_TIME=$1
TEST_INTERFACE=$2
KEYSTONE_MAC=$3
ARNDALE_MAC=$4

cd ~
git clone git://git.linaro.org/people/vincent.hsu/odp-demo.git -b arndale
cd odp-demo
make
ls -al

echo "unset the ip address"
ifconfig down $TEST_INTERFACE
ifconfig $TEST_INTERFACE hw ether $ARNDALE_MAC
ifconfig $TEST_INTERFACE 0.0.0.0
sleep 10
ifconfig up $TEST_INTERFACE
ifconfig -a

cd test/packet
./odp_packet -i $TEST_INTERFACE -m 1 &

echo "test_case_id:odp_loopback result:pass"

