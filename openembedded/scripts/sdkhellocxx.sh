#!/bin/bash
#
# SDK hello.cc test.
#
# Copyright (C) 2013, Linaro Limited.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# Author: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
#

cd
g++ hello.cc -o hello > sdkhellocxx.log

if [ 0 -eq $? ]
then
    echo "sdkhellocxx: pass"
    exit 0
else
    echo "sdkhellocxx: fail"
    exit 1
fi
