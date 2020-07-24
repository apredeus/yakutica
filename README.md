# Gortzia yakutica 

<img width="940" height="301" src="https://github.com/apredeus/yakutica/blob/master/img/figure3.jpg">

Analysis scripts and supplementary data for *Gortzia yakutica* paper.

## Reference

Beliavskaia AY, Predeus AV, Garushyants SK, Logacheva MD, Gong J, Zou S, Gelfand MS, Rautian MS, [New Intranuclear Symbiotic Bacteria from Macronucleus of Paramecium putrinum—“Candidatus Gortzia Yakutica”](https://www.mdpi.com/1424-2818/12/5/198), *Diversity 12(5), 198*.

Preprint is available at [bioRxiv](https://www.biorxiv.org/content/10.1101/2020.01.13.895557v1).

## Data description

* **genome_16S_merged.bed** - interval file for 16S sequences identified in whole genomes;
* **yakut_v6g.fa** - initial compendium of 79 sequences used in the analysis;
* **yakut_v6g_trim.fa** - trimmed multiple sequence alignment, used in phylogeny and sequence similarity analysis;
* **distances_17_spp.tsv** - pairwise similarities between representative sequences; 
* **yakut_v6r2_trim.fa,yakut_v6r2_trim.nex** - same as **yakut_v6g_trim.fa**, but with simplifies sequence names. Nexus file is used for MrBayes.

## Scripts

All scripts necessary to re-do the analysis and data visualisation from the paper are available in /scripts. 

All commands are listed with comments in `commands.sh`. R script is used to create Figure 5. 

Pairwise similarities are calculated from **yakut_v6g_trim.fa** using `msa_to_pairwise.pl`. 
