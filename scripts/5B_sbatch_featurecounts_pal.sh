#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=featureCounts_pal
#SBATCH --time=02:00:00
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --output=/work/geisingerlab/Mark/rnaSeq/2024-06-11_sRNAs_from_eg_2020_bfmRS/logs/%x-%j.log
#SBATCH --error=/work/geisingerlab/Mark/rnaSeq/2024-06-11_sRNAs_from_eg_2020_bfmRS/logs/%x-%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=soo.m@northeastern.edu

echo "Loading environment and tools"
module load subread/2.0.6

source ./config.cfg
echo "featureCounts file name: $COUNTS_FILE_pal found in $COUNTS_OUTDIR"
echo "genome GTF reference file: $GENOME_GTF"
echo ".bam input files were found in: $MAPPED_DIR_pal_VerySens"

mkdir -p $COUNTS_OUTDIR

# Run featureCounts on all BAM files from STAR
# -t flag specifies features in column 3 of GTF to count; default is exon.
featureCounts \
-a $GENOME_GTF \
-o $COUNTS_OUTDIR/$COUNTS_FILE_pal \
-t sRNA \
$MAPPED_DIR_pal_VerySens/*.bam
