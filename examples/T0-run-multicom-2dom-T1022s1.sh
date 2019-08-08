#!/bin/bash
#SBATCH -J  T1006
#SBATCH -o T1006-%j.out
#SBATCH --partition Lewis,hpc5,hpc4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --time 2-00:00

mkdir -p /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/
cd /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/

source /storage/hpc/scratch/jh7x3/multicom/tools/python_virtualenv/bin/activate
export LD_LIBRARY_PATH=/storage/hpc/scratch/jh7x3/multicom/tools/boost_1_55_0/lib/:/storage/hpc/scratch/jh7x3/multicom/tools/OpenBLAS:$LD_LIBRARY_PATH

if [[ ! -f "/storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/mcomb/casp1.pdb" ]];then 
	/storage/hpc/scratch/jh7x3/multicom/src/multicom_ve.pl /storage/hpc/scratch/jh7x3/multicom/src/multicom_system_option_casp13 /storage/hpc/scratch/jh7x3/multicom/examples/T1022s1.fasta  /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/   2>&1 | tee  /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom.log
fi


printf "\nFinished.."


printf "\nCheck log file </storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom.log>\n\n"

/storage/hpc/scratch/jh7x3/multicom/src/visualize_multicom_cluster/P1_organize_prediction.sh /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/  T1022s1  /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/multicom_results



printf "\nCompare individual predictions for full_length..\n"
perl /storage/hpc/scratch/jh7x3/multicom/installation/scripts/validate_integrated_predictions.pl T1022s1 /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/full_length/meta/ /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1

printf "\nCompare individual predictions for domain0..\n"
perl /storage/hpc/scratch/jh7x3/multicom/installation/scripts/validate_integrated_predictions.pl domain0 /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/domain0/meta/ /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1

printf "\nCompare individual predictions for domain1..\n"
perl /storage/hpc/scratch/jh7x3/multicom/installation/scripts/validate_integrated_predictions.pl domain1 /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/domain1/meta/ /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1



printf "\nCheck final predictions for full-length structure..\n"
perl /storage/hpc/scratch/jh7x3/multicom/installation/scripts/validate_integrated_predictions_final.pl  T1022s1  /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/comb /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1/comb/ /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1.pdb casp  2>&1 | tee -a /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom.log


printf "\nCheck final predictions for domain0..\n"
perl /storage/hpc/scratch/jh7x3/multicom/installation/scripts/validate_integrated_predictions_final.pl  domain0  /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/comb /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1/comb/ /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1-1-167.pdb casp  2>&1 | tee -a /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom.log



printf "\nCheck final predictions for domain1..\n"
perl /storage/hpc/scratch/jh7x3/multicom/installation/scripts/validate_integrated_predictions_final.pl  domain1  /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom/comb /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1/comb/ /storage/hpc/scratch/jh7x3/multicom/installation/benchmark/Two-domain/T1022s1-163-229.pdb casp  2>&1 | tee -a /storage/hpc/scratch/jh7x3/multicom/test_out/T1022s1_multicom.log
