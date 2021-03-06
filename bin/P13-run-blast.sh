#!/bin/bash

if [ $# != 3 ]; then
	echo "$0 <target id> <fasta> <output-directory>"
	exit
fi

targetid=$1
fastafile=$2
outputdir=$3

mkdir -p $outputdir
cd $outputdir

if [[ "$fastafile" != /* ]]
then
   echo "Please provide absolute path for $fastafile"
   exit
fi

if [[ "$outputdir" != /* ]]
then
   echo "Please provide absolute path for $outputdir"
   exit
fi

mkdir -p $outputdir/blast

cd $outputdir

perl /home/jhou4/tools/multicom/src/meta/blast/script/main_blast_v2.pl /home/jhou4/tools/multicom/src/meta/blast/cm_option_adv $fastafile blast  2>&1 | tee  blast.log
perl /home/jhou4/tools/multicom/src/meta/hhsearch/script/tm_hhsearch_main_casp8.pl /home/jhou4/tools/multicom/src/meta/hhsearch/hhsearch_option_cluster_used_in_casp8 $fastafile blast

printf "\nFinished.."
printf "\nCheck log file <$outputdir/blast.log>\n\n"


if [[ ! -f "$outputdir/blast/hs1.pdb" ]];then 
	printf "!!!!! Failed to run blast, check the installation </home/jhou4/tools/multicom/src/meta/blast/>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/blast/hs1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi
