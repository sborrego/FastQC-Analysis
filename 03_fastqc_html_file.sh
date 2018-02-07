#!/bin/bash

#$ -N fastQC_03             # name of the job
#$ -o /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_03.out   # contains what would normally be printed to stdout (the$
#$ -e /data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_03.err   # file name to print standard error messages to. These m$
#$ -q free64,som,asom       # request cores from the free64, som, asom queues.
#$ -pe openmp 8-64          # request parallel environment. You can include a minimum and maximum core count.
#$ -m beas                  # send you email of job status (b)egin, (e)rror, (a)bort, (s)uspend
#$ -ckpt blcr               # (c)heckpoint: writes a snapshot of a process to disk, (r)estarts the process after the checkpoint is c$

module load blcr
module load fastqc/0.11.7

DATA_DIR=/data/users/$USER/BioinformaticsSG/griffith_data/reads                                     # The directory where the data we want to analyze is located
QC_OUT_DIR=/data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_results_03                     # The directory where we want the result files to go
QC_HTML_DIR=/data/users/$USER/BioinformaticsSG/FastQC-Analysis/fastqc_results_03/fastqc_html_03     # The directory where we want our HTML result files to go

# Making the result file directory
mkdir -p ${QC_OUT_DIR}
# Making the HTML result file directory
mkdir -p ${QC_HTML_DIR}          

# Here we are performing a loop that will use each file in our data directory as input, "*" is a wild card symbol and in this context matches any file in the indicated directory
# Each file will be processed with the program "fastqc", "\" symbol indicates that more options for the program are on the next line 
# (--outdir) indicates the output directory for the result files
# (mv) moves the HTML result files to the new HTML result file directory
for FILE in `find ${DATA_DIR} -name \*`; do
    fastqc $FILE \
    -o ${QC_OUT_DIR}
    
    mv ${QC_OUT_DIR}/*.html ${QC_HTML_DIR}
done
