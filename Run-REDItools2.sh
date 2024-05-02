sample=QC276-1-LGB4222_L2
hisat2 -p 2  -q -x   ~/data/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa  -1   $sample\_1.fq.gz  -2   $sample\_2.fq.gz  -S  $sample.sam
samtools view -Su  $sample.sam | samtools sort  -O BAM   -@ 2 - > $sample.sorted.bam
samtools index  $sample.sorted.bam
python ~/software/REDItools2-master/src/cineca/reditools.py  -o  $sample.REDtools -S  -f $sample.sorted.bam  -r  ~/data/ensemble-104/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa 
