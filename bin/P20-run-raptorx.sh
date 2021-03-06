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

mkdir -p $outputdir/raptorx

cd $outputdir
perl /home/jhou4/tools/multicom/src/meta/raptorx/script/tm_raptorx_main.pl /home/jhou4/tools/multicom/src/meta/raptorx/raptorx_option_version3 $fastafile raptorx  2>&1 | tee  raptorx.log


printf "\nFinished.."
printf "\nCheck log file <$outputdir/raptorx.log>\n\n"


if [[ ! -f "$outputdir/raptorx/rapt1.pdb" ]];then 
	printf "!!!!! Failed to run raptorx, check the installation </home/jhou4/tools/multicom/src/meta/raptorx/>\n\n"
else
	printf "\nJob successfully completed!"
	cp $outputdir/raptorx/rapt1.pdb $outputdir/$targetid.pdb 
	printf "\nResults: $outputdir/$targetid.pdb\n\n"
fi


