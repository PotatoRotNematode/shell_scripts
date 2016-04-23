#!/bin/sh

#####################################################################
# This script 
#   1) uses cufflinks to generate gtf files using bam files from 2_alignment.sh
#       * assumes all alignments for all cases/replicates are completed
#   2) creates a text file listing all gtf files created
#   3) merges the gtf files using cuffmerge
#   4) use cuffdiff to generate differential expression statistics filesa
#####################################################################

#####################################################################
# CONFIG

#FILE LOCATIONS
baseDir="."
alignDir="$baseDir/align"

fungal_rep_1="$alignDir/fungal_1/accepted_hits.bam"
fungal_1_out="$alignDir/fungal_1/cuff_out"

fungal_rep_2="$alignDir/fungal_2/accepted_hits.bam"
fungal_2_out="$alignDir/fungal_2/cuff_out"

plant_rep_1="$alignDir/plant_1/accepted_hits.bam"
plant_1_out="$alignDir/plant_1/cuff_out"

plant_rep_2="$alignDir/plant_2/accepted_hits.bam"
plant_2_out="$alignDir/plant_2/cuff_out"

list_file="$alignDir/assemblies.txt"

reference="$baseDir/ref/Dd_plant_parasitism_coord.fasta"

#Cuffdiff Options and File Locations
label="1067f1_1271f2,0126p1_1270p2"

merged_file = "$alignDir/merged_asm/merged.gtf" #output from cuffmerge

cuff_diff_out="$alignDir/f1f2_p1p2"

# CONFIG DONE
######################################################################

# Cufflinks
echo "generating gtf files with cufflinks..."
cufflinks -o $fungal_1_out $fungal_rep_1
cufflinks -o $fungal_2_out $fungal_rep_2
cufflinks -o $plant_1_out $plant_rep_1
cufflinks -o $plant_2_out $plant_rep_2

# Create text file listing all gtfs
echo "appending file names to assemblies.txt..."
echo -e $fungal_1_out/transcripts.gtf >> $list_file
echo -e $fungal_2_out/transcripts.gtf >> $list_file
echo -e $plant_1_out/transcripts.gtf >> $list_file
echo -e $plant_2_out/transcripts.gtf >> $list_file

# Cuffmerge
echo "merging gtf files from assemblies.txt..."
cuffmerge -o $alignDir/merged_asm -s $reference $list_file

# Cuffdiff
echo "generating cuffdiff files..."
cuffdiff -o $cuff_diff_out -b $reference -L $label -u $merged_file $fungal_rep_1,$fungal_rep2 $plant_rep_1,$plant_rep_2
echo "cufflinks suite finished. Proceed to 4_cummerbund"