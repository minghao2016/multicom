#!/bin/bash

dtime=$(date +%m%d%y)



source /data/jh7x3/multicom_github/jie_test/multicom/tools/python_virtualenv/bin/activate
export LD_LIBRARY_PATH=/data/jh7x3/multicom_github/jie_test/multicom/tools/boost_1_55_0/lib/:/data/jh7x3/multicom_github/jie_test/multicom/tools/OpenBLAS:$LD_LIBRARY_PATH

mkdir -p /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_novel_$dtime/
cd /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_novel_$dtime/

mkdir novel
perl /data/jh7x3/multicom_github/jie_test/multicom/src/meta/novel/script/tm_novel_main.pl /data/jh7x3/multicom_github/jie_test/multicom/src/meta/novel/novel_option /data/jh7x3/multicom_github/jie_test/multicom/examples/T0993s2.fasta novel  2>&1 | tee  /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_novel_$dtime.log


printf "\nFinished.."
printf "\nCheck log file </data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_novel_$dtime.log>\n\n"


if [[ ! -f "/data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_novel_$dtime/novel/novel1.pdb" ]];then 
	printf "!!!!! Failed to run novel, check the installation </data/jh7x3/multicom_github/jie_test/multicom/src/meta/novel/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /data/jh7x3/multicom_github/jie_test/multicom/test_out/T0993s2_novel_$dtime/novel/novel1.pdb\n\n"
fi

