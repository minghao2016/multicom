#!/bin/bash -e

echo " Start compile freecontact (will take ~1 min)
"

cd /home/casp14/MULTICOM_TS/jie_test/multicom//tools/DNCON2

cd freecontact-1.0.21

autoreconf -f -i

make clean

./configure --prefix=/home/casp14/MULTICOM_TS/jie_test/multicom//tools/DNCON2/freecontact-1.0.21 LDFLAGS="-L/home/casp14/MULTICOM_TS/jie_test/multicom//tools/OpenBLAS/lib -L/home/casp14/MULTICOM_TS/jie_test/multicom//tools/boost_1_55_0/lib" CFLAGS="-I/home/casp14/MULTICOM_TS/jie_test/multicom//tools/OpenBLAS/include -I/home/casp14/MULTICOM_TS/jie_test/multicom//tools/boost_1_55_0/include"  CPPFLAGS="-I/home/casp14/MULTICOM_TS/jie_test/multicom//tools/OpenBLAS/include -I/home/casp14/MULTICOM_TS/jie_test/multicom//tools/boost_1_55_0/include" --with-boost=/home/casp14/MULTICOM_TS/jie_test/multicom//tools/boost_1_55_0/

make

make install
