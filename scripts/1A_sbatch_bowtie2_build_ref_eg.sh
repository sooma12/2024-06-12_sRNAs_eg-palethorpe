#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=bowtie2_build_eg
#SBATCH --time=02:00:00
#SBATCH -N 1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=/work/geisingerlab/Mark/rnaSeq/2024-06-12_sRNAs_eg-palethorpe/logs/%x-%j.log
#SBATCH --error=/work/geisingerlab/Mark/rnaSeq/2024-06-12_sRNAs_eg-palethorpe/logs/%x-%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=soo.m@northeastern.edu

## Usage: sbatch 1A_sbatch_bowtie2_build_ref_eg.sh

echo "loading tools for STAR genomeGenerate"
module load bowtie/2.5.2

# Load config file
source ./config.cfg
# Relevant variables: GENOME_REF_DIR_OUT, FASTA_IN, GTF_IN
echo "Genome fasta files: $REF_CHR_FA_17978"
echo "Basename of output: $BT2_OUT_BASE_eg"
#echo "Directory for Bowtie2 genome index: $GENOME_INDEX_DIR"

bowtie2-build -f --threads 4 $REF_CHR_FA_17978 $BT2_OUT_BASE_eg

# mkdir -p $GENOME_INDEX_DIR
# mv *.bt2 $GENOME_INDEX_DIR
