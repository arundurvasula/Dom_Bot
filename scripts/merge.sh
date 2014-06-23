#!/bin/bash -l

# merge bam files to single individuals 

for i in $( ls /home/beissing/v3_bams_bwamem/ | cut -f 1 -d "_" | sort -n | uniq ); do

#if not already merged
if [ ! -f /home/beissing/v3_bams_bwamem/"$i"_merged.bam ]
then

	if [ $( ls -1 /home/beissing/v3_bams_bwamem/$i* | wc -l ) -gt 1 ]
	then
		samtools merge -r /home/beissing/v3_bams_bwamem/"$i"_merged.bam $( ls /home/beissing/v3_bams_bwamem/$i* | perl -ne '{BEGIN} chomp; print "$_\t"; while(<>){ chomp; print "$_\t";}; {END} chomp; print $_;')
		samtools index /home/beissing/v3_bams_bwamem/"$i"_merged.bam
	else
		mv $( ls -1 /home/beissing/v3_bams_bwamem/$i*  ) /home/beissing/v3_bams_bwamem/"$i"_merged.bam;
		samtools index /home/beissing/v3_bams_bwamem/"$i"_merged.bam
	fi;
else 
 	if [ ! -f /home/beissing/v3_bams_bwamem/"$i"_merged.bam.bai ]
	then
		samtools index /home/beissing/v3_bams_bwamem/"$i"_merged.bam
	fi;
fi;

done;