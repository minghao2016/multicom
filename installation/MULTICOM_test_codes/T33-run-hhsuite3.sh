#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_hhsuite3_$dtime/
cd /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_hhsuite3_$dtime/

mkdir hhsuite3
perl /data/jh7x3/multicom_github/jie_test/multicom/src/meta/hhsuite3/script/tm_hhsuite3_main.pl /data/jh7x3/multicom_github/jie_test/multicom/src/meta/hhsuite3/hhsuite3_option /data/jh7x3/multicom_github/jie_test/multicom/examples/T0993s2.fasta hhsuite3  2>&1 | tee  /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_hhsuite3_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_hhsuite3_$dtime.log>\n\n"


if [[ ! -f "/data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_hhsuite3_$dtime/hhsuite3/hhsu1.pdb" ]];then 
	printf "!!!!! Failed to run hhsuite3, check the installation </data/jh7x3/multicom_github/jie_test/multicom/src/meta/hhsuite3/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_hhsuite3_$dtime/hhsuite3/hhsu1.pdb\n\n"
fi

