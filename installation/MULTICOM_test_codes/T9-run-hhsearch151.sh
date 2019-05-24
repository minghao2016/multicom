#!/bin/bash

dtime=$(date +%Y-%b-%d)


mkdir -p /home/casp14/MULTICOM_TS/jie_test/multicom/test_out/T0993s2-hhsearch151-$dtime/
cd /home/casp14/MULTICOM_TS/jie_test/multicom/test_out/T0993s2-hhsearch151-$dtime/

mkdir hhsearch151
perl /home/casp14/MULTICOM_TS/jie_test/multicom/src/meta/hhsearch151/script/tm_hhsearch151_main.pl /home/casp14/MULTICOM_TS/jie_test/multicom/src/meta/hhsearch151/hhsearch151_option /home/casp14/MULTICOM_TS/jie_test/multicom/examples/T0993s2.fasta hhsearch151  2>&1 | tee  /home/casp14/MULTICOM_TS/jie_test/multicom/test_out/T0993s2-hhsearch151-$dtime.log


printf "\nFinished.."
printf "\nCheck log file </home/casp14/MULTICOM_TS/jie_test/multicom/test_out/T0993s2-hhsearch151-$dtime.log>\n\n"


if [[ ! -f "/home/casp14/MULTICOM_TS/jie_test/multicom/test_out/T0993s2-hhsearch151-$dtime/hhsearch151/hg1.pdb" ]];then 
	printf "!!!!! Failed to run hhsearch151, check the installation </home/casp14/MULTICOM_TS/jie_test/multicom/src/meta/hhsearch151/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/casp14/MULTICOM_TS/jie_test/multicom/test_out/T0993s2-hhsearch151-$dtime/hhsearch151/hg1.pdb\n\n"
fi
