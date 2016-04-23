#!/bin/sh

#####################################################################
# This script 
#   1) creates bowtie indices for the reference file
#####################################################################

#####################################################################
#CONFIG

#File Locations
baseDir="."
ref="$baseDir/ref/Dd_plant_parasitism_coord.fasta"
refOut="parasitic_ref"

#END OF CONFIG
#####################################################################

#####################################################################
echo "Creating reference indices... "
bowtie2-build ref refOut
echo "Done creating bowtie indices. Proceed to 2_alignment."
