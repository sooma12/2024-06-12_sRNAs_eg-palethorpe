#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=alignRNA_bowtie_eg
#SBATCH --time=08:00:00
#SBATCH --array=1-12%13
#SBATCH --ntasks=12
#SBATCH --mem=100G
#SBATCH --cpus-per-task=8
#SBATCH --output=/work/geisingerlab/Mark/rnaSeq/2024-06-12_sRNAs_eg-palethorpe/logs/%x-%A-%a.log
#SBATCH --error=/work/geisingerlab/Mark/rnaSeq/2024-06-12_sRNAs_eg-palethorpe/logs/%x-%A-%a.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=soo.m@northeastern.edu

## Usage: sbatch 3A_sbatch_array_bowtie2_align_eg.sh
echo "Loading tools"
module load bowtie/2.5.2

# Load config file
source ./config.cfg

echo "Bowtie2 reference genome index basename: $BT2_OUT_BASE_eg"
echo "sample sheet located at $SAMPLE_SHEET_PATH_eg"
echo "alignment output directory containing .bam files: $MAPPED_DIR_eg_VerySens"

mkdir -p $MAPPED_DIR_eg_VerySens

# Array job!  Used my sample sheet technique from 2023-11-13 breseq for this.
# NOTE!!! sample sheet prep is moved to separate script.
# Run that script before this one!

# sed and awk read through the sample sheet and grab each whitespace-separated value
name=$(sed -n "$SLURM_ARRAY_TASK_ID"p $SAMPLE_SHEET_PATH_eg |  awk '{print $1}')
fq=$(sed -n "$SLURM_ARRAY_TASK_ID"p $SAMPLE_SHEET_PATH_eg |  awk '{print $2}')

echo "Running Bowtie2 on $fq"

# Bowtie2 in paired end mode
bowtie2 --local --very-sensitive-local  -p 8 -x $BT2_OUT_BASE_eg --no-unal -q -U $fq -S $MAPPED_DIR_eg_VerySens/$name.sam
