#!/bin/bash

dtime=$(date +%m%d%y)


mkdir -p /home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime/
cd /home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime/

mkdir hhsearch

touch /home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime.running
if [[ ! -f "/home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime/hhsearch/hh1.pdb" ]];then 
	perl /home/jh7x3/multicom/src/meta/hhsearch/script/tm_hhsearch_main_v2.pl /home/jh7x3/multicom/src/meta/hhsearch/hhsearch_option_cluster /home/jh7x3/multicom/examples/T1006.fasta hhsearch  2>&1 | tee  /home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime.log
fi

printf "\nFinished.."
printf "\nCheck log file </home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime.log>\n\n"


if [[ ! -f "/home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime/hhsearch/hh1.pdb" ]];then 
	printf "!!!!! Failed to run hhsearch, check the installation </home/jh7x3/multicom/src/meta/hhsearch/>\n\n"
else
	printf "\nJob successfully completed!"
	printf "\nResults: /home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime/hhsearch/hh1.pdb\n\n"
fi

rm /home/jh7x3/multicom/test_out/T1006_hhsearch_$dtime.running