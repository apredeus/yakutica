#!/bin/bash 

#1 download GenBank sequences in an automated way

ID="LC466994.1"
curl -s  "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=${ID}&rettype=fasta&retmode=txt" > $ID.fa

#2 extract 16S sequences from genomes

cat GCA*fna > All_genomic.fna
makeblastdb -in All_genomic.fna -dbtype nucl
blastn -query yakut_v6.fa -db All_genomic.fna -outfmt 6 > genomes.blast.out
cut -f 2,9,10 genomes.blast.out | awk '{if ($2>$3) {print $1"\t"$3-500"\t"$2+500} else {print $1"\t"$2-500"\t"$3+500}}' > genome_16S_intervals.bed
bedtools merge -i genome_16S_intervals.bed > genome_16S_merged.bed 
bedtools getfasta -name -fi All_genomic.fna -bed genome_16S_merged.bed -fo genome_16S_merged.fa
cat yakut_v6.fa genome_16S_merged.fa > yakut_v6g.fa

#3 ssu-align and ssu-mask

ssu-align --dna yakut_v6g.fa yakut_v6g.ssualign
ssu-mask --afa --dna yakut_v6g.ssualign/
cp yakut_v6g.ssualign/yakut_v6g.ssualign.bacteria.mask.afa yakut_v6g_mask.fa

#4 trim the alignment 

java -jar ../BMGE.jar -i yakut_v6g_mask.fa -t DNA -of yakut_v6g_filt.fa -oh yakut_v6g_filt.html 
awk '{if (/^>/) {print} else {print substr($0,155,1079)}}' yakut_v6g_filt.fa > yakut_v6g_trim.fa

#5 run modeltest-ng

modeltest-ng -i yakut_v6g_trim.fa

#6 run raxmlHPC

raxmlHPC -s yakut_v6g_trim.fa -n yakut_v6g.out -m GTRGAMMAIX -f a -x 123 -N 1000 -p 456
raxmlHPC -m GTRGAMMAIX -f I -t RAxML_bipartitionsBranchLabels.yakut_v6g.out -n rooted.yakut_v6g.out

#7 make nexus file for MrBayes; nex file needs a header/footer - add manually from example files
# sequences had to be renamed for tree comparison convenience
 
perl -ne 'if (m/^>/) {chomp; s/^>//; print "$_\t"} else {print}' yakut_v6r2_trim.fa > yakut_v6r2_trim.nex

#8 run MrBayes (within the tool console):

execute yakut_v6r2_trim.nex
lset nst=6 rates=invgamma
mcmc ngen=20000 samplefreq=100 printfreq=100 diagnfreq=1000
sump
sumt

