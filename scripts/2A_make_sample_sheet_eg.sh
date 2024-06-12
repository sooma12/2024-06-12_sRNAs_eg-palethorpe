#!/bin/bash
# 2A_make_sample_sheet_eg.sh
# Makes a sample_sheet.txt containing sample ID fastq filepath.  NOTE: single end reads!
# Assumes each sample file is in the format: 496-2_S11_L002_R1_001.fastq
# Script uses a split on "_" to grab the sample ID, e.g. 496-2.  Must modify this if sample file names are different!
# Example output line:  WT_1 /path/to/WT-1.fastq

source ./config.cfg

# Create .list files with R1 and R2 fastqs.  Sort will put them in same orders, assuming files are paired
find ${FASTQDIR_eg} -maxdepth 1 -name "*.fastq" | sort > R1.list

if [ -f "${SAMPLE_SHEET_PATH}" ] ; then
  rm "${SAMPLE_SHEET_PATH}"
fi

# make sample sheet from read files.  Format on each line looks like (space separated):
# WT_1 /path/to/WT_1.fastq
# from sample sheet, we can access individual items from each line with e.g. `awk '{print $3}' sample_sheet.txt`

paste R1.list | while read R1;
do
    outdir_root=$(basename ${R1} | cut -f1 -d"_")
    sample_line="${outdir_root} ${R1}"
    echo "${sample_line}" >> $SAMPLE_SHEET_PATH_eg
done

rm R1.list
