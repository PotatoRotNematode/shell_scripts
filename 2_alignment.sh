#!/bin/sh

#####################################################################
# This script 
#   1) aligns RNA-seq fastq files to the reference created in 1_index.sh
#       * swap out the filenames to perform this for other reads
#####################################################################

#####################################################################
# CONFIG

# FILE LOCATIONS
baseDir="."

readDir="$baseDir/reads"
pair1="$readDir/Dd_Jiangsu_01_R01v1_RNA_S001270_trim_R1.fq.gz"
pair2="$readDir/Dd_Jiangsu_01_R01v1_RNA_S001270_trim_R2.fq.gz"

refDir="$baseDir/ref"
ref="$refDir/parasitic_ref"

outDir="$baseDir/alignment/fungal_1"

# ALIGNMENT OPTIONS
sensitivity="very-sensitive"
seg_length="19"
seg_mis="3"
read_edit_dist="25"
read_mis="25"
read_gap_length="20" 

# CONFIG DONE
#####################################################################

# Create output directory if non existent
if [ ! -d $outDir ]; then
    mkdir -p $outDir
fi

# Alignment
echo "Aligning with tophat ..."
tophat --b2-$sensitivity --segment-length $seg_length --segment-mismatches $seg_mis --read-edit-dist $read_edit_dist --read-mismatches $read_mis --read-gap-length $read_gap_length -o $outDir $ref $pair1 $pair2
echo "Alignment finished, output can be found here: $outDir. Proceed to 3_cufflinks_suite"